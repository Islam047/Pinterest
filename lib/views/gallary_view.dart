import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/models/list_photos_model.dart';
import '../services/network_service.dart';
import 'image_view.dart';


class GalleryView extends StatefulWidget {
  final String api;
  final Map<String, String> params;
  final ScrollPhysics? physics;
  final int? realPage;
    final int crossAxisCount;
  const GalleryView({Key? key, this.physics, required this.api, required this.params,required this.realPage, required this.crossAxisCount}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> with AutomaticKeepAliveClientMixin{

  List<ListPhotos> listOfPhotos = [];

  ScrollController controller = ScrollController();
  Map<String, String> params = {};
  int currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    params = widget.params;
    apiGetAllImage(currentPage++);
    controller.addListener(loadMore);
  }
  void apiGetAllImage(int page) async {

    if(widget.realPage != null && widget.realPage != 0){
       page = widget.realPage!;
    }

    params['page'] = page.toString();
    String? resAllImages = await NetworkService.GET(widget.api, params,);
    listOfPhotos.addAll(parseAllUsers(resAllImages!));
      listOfPhotos.removeAt(0);
    setState(() {});
  }

  void loadMore() {
    if(controller.position.maxScrollExtent == controller.position.pixels) {
      apiGetAllImage(currentPage++);
    }
  }

  Future<void> onRefresh() async {
    listOfPhotos = [];
    currentPage = 0;
    setState(() {});
    if(Platform.isAndroid) {
      apiGetAllImage(currentPage++);
    }
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: MasonryGridView.count(
        physics: widget.physics,
        shrinkWrap: true,
        controller: controller,
        crossAxisCount: widget.crossAxisCount,
        itemCount: listOfPhotos.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
        return ImageView(listPhotos: listOfPhotos[index], currentIndex: currentPage,);
        },
      ),
    );
  }
}