import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:cppcc_app/utils/routes.dart';

class DiscussNetworkItem extends StatelessWidget {
  final DiscussNetwork _response;
  const DiscussNetworkItem(this._response, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.discussNetworkDetailsPage,
              arguments: {"id": _response.id});
        },
        child: Container(
          height: 120,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _response.read
                            ? Container()
                            : Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 8),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFfa7c2f),
                                )),
                        Expanded(
                            child: Text(
                          _response.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.black),
                        ))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _response.status == 1
                                ? const Color(0xFFc6c3bc)
                                : const Color(0xff3c6dea),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          child: Text(
                            _response.statusDictText.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _response.praiseCount.toString() + '点赞',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.greyTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: _response.cover == null
                        ? Image.asset('assets/icons/ic_news.png')
                        : CachedNetworkImage(
                            imageUrl: _response.cover!,
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
