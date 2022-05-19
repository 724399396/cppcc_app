import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/repository/post_repository.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;
  PostsBloc(this._postRepository) : super(const PostsState()) {
    on<PostInitilized>((event, emit) async {
      await _postRepository.getFileAnnounmentUnreadCount().then((count) {
        Map<PostType, int> newData = Map.from(state.unreadCount);
        newData[PostType.fileAnnment] = count;
        emit(state.copyWith(unreadCount: newData));
      });

      await _postRepository.getLearningUnreadCount().then((count) {
        Map<PostType, int> newData = Map.from(state.unreadCount);
        newData[PostType.learning] = count;
        emit(state.copyWith(unreadCount: newData));
      });

      await _postRepository.getGdHistoryUnreadCount().then((count) {
        Map<PostType, int> newData = Map.from(state.unreadCount);
        newData[PostType.guanduHistory] = count;
        emit(state.copyWith(unreadCount: newData));
      });

      for (var type in [PostType.fileAnnment, PostType.news]) {
        Map<PostKey, List<Posts>> newPosts = Map.from(state.posts);
        newPosts[PostKey(type, null)] = [];
        Map<PostKey, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[PostKey(type, null)] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          posts: newPosts,
        ));
        await _dataLoad(emit, PostKey(type, null));
      }
    });

    on<PostFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.key)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.key);
        });
      }
    });

    on<PostRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<PostKey, List<Posts>> newPosts = Map.from(state.posts);
        newPosts[event.key] = [];
        Map<PostKey, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.key] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          posts: newPosts,
        ));
        await _dataLoad(emit, event.key);
      });
    });

    on<PostLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.key);
      });
    });
    on<PostReaded>((event, emit) async {
      var post = await _postRepository.getPostsDetail(event.posts.id);
      Map<PostKey, List<Posts>> newPosts = Map.from(state.posts);
      Map<PostType, int> unreadCount = Map.from(state.unreadCount);
      for (var key in newPosts.keys) {
        newPosts[key] = updateWithGenerateNewList<Posts>(
          newPosts[key] ?? [],
          (item) => item.id == event.posts.id,
          (item) => item?.copyWith(
              read: true,
              hits: (item.hits ?? 0) + 1,
              userReadRecords: post.userReadRecords),
          matcherCallback: (e) {
            if (!e.read) {
              unreadCount[key.type] = (unreadCount[key.type] ?? 1) - 1;
            }
          },
        );
      }
      emit(state.copyWith(
          posts: newPosts,
          currentPost: post.copyWith(read: true),
          unreadCount: unreadCount));
    });
  }

  Future<void> _generateCallApi(PostsEvent event, Emitter<PostsState> emit,
      GenericApiCall<PostsState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get posts error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(Emitter<PostsState> emit, PostKey key) async {
    var datas = await _postRepository.getPostList(
        state.currentPage[key] ?? 1, pageSize, key.type, key.category);
    Map<PostKey, List<Posts>> newPosts = Map.from(state.posts);
    newPosts[key] = (newPosts[key] ?? []) + datas;
    Map<PostKey, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[key] = (newCurrentPage[key] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      posts: newPosts,
    ));
  }

  @override
  void onChange(Change<PostsState> change) {
    super.onChange(change);
  }
}
