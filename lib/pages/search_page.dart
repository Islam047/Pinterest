import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/models/list_photos_model.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/models/searchPhotosModel.dart';
import 'package:pinterest/views/photo_view.dart';
import 'package:shimmer/shimmer.dart';

import '../services/network_service.dart';
import '../views/image_view.dart';

class SearchPage extends StatefulWidget {
  final int crossAxisCount;
  const SearchPage({Key? key, required this.crossAxisCount}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPhotosModel? searchPhotosModel;

  List<Results> _images = [];
  bool _isFinally = false;
  int _page = 0;
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  String? subjectCopy;
  @override
  initState() {
    super.initState();
    _paginationNext(_page++);
    scrollController.addListener(loadMore);
  }
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textEditingController.dispose();
  }

  void _apiGetAllImage(String? subject) async {
    subjectCopy = subject;
    String? resAllImages = await NetworkService.GET(
        NetworkService.API_SEARCH_PHOTOS,
        NetworkService.paramsSearchPhotosQuery(query: subject));
    print(resAllImages);
    searchPhotosModel = searchPhotosModelFromJson(resAllImages!);
    _images = searchPhotosModel!.results!;
    setState(() {});
  }

  void _paginationNext(int page) async {
    if(!_isFinally) {
      String? resAllImages = await NetworkService.GET(
          NetworkService.API_SEARCH_PHOTOS,
          NetworkService.paramsSearchPhotosQuery(page: page,query: subjectCopy ?? "sport",perPage: 25));
      searchPhotosModel = searchPhotosModelFromJson(resAllImages!);
      _images.addAll(searchPhotosModel!.results!);
      if(_images.length < 10) {
        _isFinally = true;
      }
      setState(() {});
    }
  }

  void loadMore() {
    if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
      _paginationNext(_page++);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 30,
            ),
            SizedBox(
              height: 40,
              width: widget.crossAxisCount > 2 ? MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width - 150,
              child: TextField(
                controller: textEditingController,

                onSubmitted: (String subject){
                   if(textEditingController.text.trim().isNotEmpty){
                     _apiGetAllImage(subject);
                   }
                },
                decoration: const InputDecoration(hintText: "Enter here"),
              ),
            )
          ],
        ),
      ),
      body: MasonryGridView.count(
        shrinkWrap: true,
        controller: scrollController,
        crossAxisCount: widget.crossAxisCount,
        itemCount: _images.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PhotoView(image:  _images[index].urls!.small!)),
              );
            },
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: _images[index].urls!.small!,
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
          );
        },
      ),
    );
  }
}
