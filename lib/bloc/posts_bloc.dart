import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/repository/post_repository.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;
  PostsBloc(this._postRepository) : super(const PostsState()) {
    on<PostInitilized>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        emit(state.copyWith(homeCurrentPage: 1, news: [], fileAnnments: [],));
        await _homeDataLoad(emit);
      });
    });
    on<HomePostRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        emit(state.copyWith(homeCurrentPage: 1, news: [], fileAnnments: [],));
        await _homeDataLoad(emit);
      });
    });
    on<HomePostLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _homeDataLoad(emit);
      });
    });
  }

  Future<void> _homeDataLoad(Emitter<PostsState> emit) async {
    var values = await Future.wait([
      _postRepository.getPostList(
          state.homeCurrentPage, pageSize, PostType.news),
      _postRepository.getPostList(
          state.homeCurrentPage, pageSize, PostType.fileAnnment)
    ]);
    emit(state.copyWith(
        news: state.news + values[0],
        fileAnnments: state.fileAnnments + values[1],
        homeCurrentPage: state.homeCurrentPage + 1));
  }

  Future<void> newMethod(Emitter<PostsState> emit) async {}

  Future<void> _generateCallApi(PostsEvent event, Emitter<PostsState> emit,
      GenericApiCall<PostsState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  @override
  void onChange(Change<PostsState> change) {
    print(change.nextState);
    super.onChange(change);
  }
}