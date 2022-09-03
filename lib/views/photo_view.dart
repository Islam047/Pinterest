import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PhotoView extends StatefulWidget {
  final String image;

  const PhotoView({Key? key, required this.image}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  Animation<Matrix4>? animation;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    controller = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onDoubleTapDown: (details) {
              tapDownDetails = details;
            },
            onDoubleTap: () {
              final position = tapDownDetails!.localPosition;
              const double scale = 3;
              final x = -position.dx * (scale - 1);
              final y = -position.dy * (scale - 1);
              final zoomed = Matrix4.identity()
                ..translate(x, y)
                ..scale(scale);
              final value = controller.value.isIdentity() ? zoomed : Matrix4.identity();
              controller.value = value;
            },
            child: InteractiveViewer(
              transformationController: controller,
              panEnabled: false,
              scaleEnabled: false,
              clipBehavior: Clip.none,
              child: CachedNetworkImage(
                imageUrl: widget.image,
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
          ),
        ));
  }
}
