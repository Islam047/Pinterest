import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/services/network_service.dart';
import 'package:pinterest/views/photo_view.dart';
import 'package:shimmer/shimmer.dart';
import '../models/topicModel.dart';

class TopicView extends StatefulWidget {
  final String topic;
  final int crossAxisCount;
  const TopicView({Key? key,required this.topic, required this.crossAxisCount }) : super(key: key);

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> with AutomaticKeepAliveClientMixin {
  List<CoverPhoto>? previewPhotos;
  int page = 0;
  List<String> list = [];
  final ScrollController _scrollController = ScrollController();
  // #wantKeepAliveTopicView
  @override
  bool get wantKeepAlive => true;

  // #initializationTopicView
  @override
  void initState() {
    _apiGetAllImage(page++);
    _scrollController.addListener(_pagination);
    super.initState();
    getAxisCount();
  }

  // #paginationTopicView
  void _pagination() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      _apiGetAllImage(page++);
    }
  }

  // #getAllImagesTopicView
  void _apiGetAllImage(int screen) async {
    String? response = await NetworkService.GET("${NetworkService.API_GET_TOPIC}${widget.topic}/photos", NetworkService.paramsSearchPhotosQuery(perPage: 15 , page: screen,)) ?? "[]";
    previewPhotos = parseAllCover(response);
    for (var item in previewPhotos!) {
        list.add(item.urls!.small!);
    }
    setState(() {});
  }
  int getAxisCount(){
   if(widget.crossAxisCount == 3){
     return 4;
   }
   else if(widget.crossAxisCount == 4){
     return 4;
   }
   else if(widget.crossAxisCount == 5){
return 6;
   }
   else{
     return 2;
   }
  }
  // #disposeTopicView
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      controller: _scrollController,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: getAxisCount(),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(2, 2),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 1),
          const QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PhotoView(image: list[index],)),
              );
            },
            // #cachedImageTopicView
            child: CachedNetworkImage(

                  fit: BoxFit.cover,
                  imageUrl: list[index],
                  placeholder: (context, url) => Shimmer.fromColors(
                    highlightColor: Colors.grey.shade300,
                    baseColor: Colors.grey.shade100,
                    child: Container(
                      color: Colors.white,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
          ),
          childCount: list.length,
      ),
    );
  }

}
