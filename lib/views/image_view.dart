import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/list_photos_model.dart';
import '../pages/detail_page.dart';

class ImageView extends StatefulWidget {
   final ListPhotos listPhotos;
   int currentIndex;
   ImageView({Key? key, required this.listPhotos,required this.currentIndex})
      : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  String? image;
  ListPhotos? photos;
  double ratio = 16 / 9;
  bool visible = false;
  bool isLike = false;
  String? favoriteId;
  String? name;
  String? title;
  String? bio;

  // #initializtionImageView
  @override
  void initState() {
    photos = widget.listPhotos;
    _convertData();
    changeToString();
    super.initState();

  }

  // #_convertDataImageView
  void _convertData() {
    if (photos?.width != null && photos?.height != null) {
      ratio = (photos!.width! / photos!.height!);
    }
    setState(() {});
  }

  // #gettingValueImageView
  void changeToString(){
    if(photos?.urls?.small == null){
     return;
    }else{
      image = photos!.urls!.regular!;
      name = photos?.user?.name ?? '';
      title = photos?.user?.location ?? '';
    }
  }


  // #openDetailPage
  void openDetailPage() {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => DetailPage(
            image: image!,
           user: widget.listPhotos, currentIndex: widget.currentIndex,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // #image
        GestureDetector(
          onTap: openDetailPage,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // #imageImageView
                AspectRatio(
                  aspectRatio: ratio,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: image!,
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

              ],
            ),
          ),
        ),

        // #image_data
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(bottom: 10, top: 5, left: 5),
          title:
               Text(name!, maxLines: 1, overflow: TextOverflow.ellipsis,) ,
          subtitle: Text(title!, maxLines: 2, overflow: TextOverflow.ellipsis,) ,
          trailing: IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(Icons.star,color: Colors.red,),
          ),
        ),
      ],
    );
  }
}
