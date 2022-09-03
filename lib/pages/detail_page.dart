import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinterest/main_page.dart';
import 'package:pinterest/models/Statistics.dart';
import 'package:pinterest/services/hive_service.dart';
import 'package:pinterest/services/util_service.dart';
import 'package:pinterest/views/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:universal_html/html.dart';
import '../models/list_photos_model.dart';
import '../services/network_service.dart';
import '../views/gallary_view.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final ListPhotos user;
  int currentIndex;

  DetailPage(
      {Key? key,
      required this.currentIndex,
      required this.image,
      required this.user})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  ProfileImage? profileImage;
  User? user;
  Statistics? statistics;
  String? id;
  String name = "";
  String subTitle = "";
  String image = '';
  int correctPage = 0;
  int vote = 0;

  // #fillingTheModelsDetailPage
  void distributeTheModels() {
    image = widget.image;
    user = widget.user.user;
    profileImage = user?.profileImage;
  }

  // #fillingTheValuesDetailPage
  void takeTheValue() {
    id = widget.user.id;
    name = user?.username ?? '';
    subTitle = user?.location ?? '';
  }

  // #initializationDetailPage
  @override
  void initState() {
    distributeTheModels();
    takeTheValue();
    getStatistics();
    getTheCorrectPage();

    super.initState();
  }

  // #disposeDetailPage
  @override
  void dispose() {
    super.dispose();
  }

  // #voteFunctionDetailPage
  void pressVote() async {
    if (vote == 1) {
      vote = 0;
    } else {
      vote = 1;
    }
    setState(() {});
  }
  // #statistics info
  void _statisticsInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text("Statistics",
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                ),
                const Divider(color: Colors.black),
                const Text("Total likes"),
                Text(statistics!.likes?.total.toString() ?? "0"),
                const Divider(color: Colors.black),
                const Text("Total views"),
                Text(statistics!.views?.total.toString() ?? "0"),
                const Divider(color: Colors.black),
                const Text(" Total downloads"),
                Text(statistics!.downloads?.total.toString() ?? "0"),
              ],
            ),
          ),
        );
      },
    );
  }

  // #voteFunctionDetailPage
  void getTheCorrectPage() {
    correctPage = HiveService.readData(StorageKey.page, defaultValue: 0);
    correctPage = correctPage + widget.currentIndex + 1;
    HiveService.setData(StorageKey.page, correctPage);
  }

  // #fillingStatisticsDetailPage
  void getStatistics() async {
    String? response = await NetworkService.GET(
        '${NetworkService.API_LIKE_PHOTO}${id!}/statistics',
        NetworkService.paramsMyKey());
    statistics = statisticsFromJson(response!);
  }

  // #saveImageDetailPage
  void saveImage(String image) async {
  if(kIsWeb) {
    await NetworkService.GETDOWNLOADWEB(image,name);
  }
  else{
    await NetworkService.GETDOWNLOAD(image, name).whenComplete(() {
      Utils.fireSnackBar("Image was uploaded successfully", context);
    });
  }
  }

  // #shareImageDetailPage
  void shareImage(String image) async {
    await Share.share("Check this out $image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Column(
                children: [
                  // #imageDetailPage
                  Visibility(
                      visible: MediaQuery.of(context).size.width > 835,
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30)),
                            ),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.2),
                                  Colors.black.withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhotoView(image: image)),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: image,
                                height: 600,
                                width: 500,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  highlightColor: Colors.grey.shade300,
                                  baseColor: Colors.grey.shade100,
                                  child: Container(
                                    color: Colors.white,
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 600,
                            padding: const EdgeInsets.all(35),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: user?.profileImage?.medium == null
                                          ? const ColoredBox(
                                              color: Colors.blueAccent)
                                          : Image.network(
                                              user!.profileImage!.medium!),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    title: const Text(
                                      "Pinterest",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                      icon: vote == 0
                                          ? const Icon(
                                              Icons.thumb_up_alt_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            )
                                          : const Icon(Icons.thumb_up_alt,
                                              color: Colors.red, size: 30),
                                      onPressed: pressVote,
                                    ),
                                  ),
                                  Visibility(
                                    visible: subTitle.isNotEmpty,
                                    child: Text(
                                      subTitle,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      // #favorite
                                      SizedBox(
                                        width: 300,
                                        child: ElevatedButton(
                                          onPressed: () => statistics != null
                                              ? _statisticsInfo()
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: const Color.fromRGBO(
                                                239, 239, 239, 1),
                                            shape: const StadiumBorder(),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20,
                                              horizontal: 15,
                                            ),
                                          ),
                                          child: const Text(
                                            "Statistics",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),

                                      // #save
                                      SizedBox(
                                        width: 300,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            saveImage(image);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: Colors.red,
                                            shape: const StadiumBorder(),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20,
                                              horizontal: 15,
                                            ),
                                          ),
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(
                                              fontSize: 17.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // #share
                                  SizedBox(
                                    width: double.infinity,
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: const Icon(
                                        Icons.share,
                                        size: 30,
                                      ),
                                      onPressed: () => shareImage(image),
                                    ),
                                  ),
                                ]),
                          ),
                        )
                      ])),

                  // #footerDetailPage
                  Visibility(
                    visible: MediaQuery.of(context).size.width < 835,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          foregroundDecoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoView(image: image)),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: image,
                              height: 600,
                              width: 500,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                highlightColor: Colors.grey.shade300,
                                baseColor: Colors.grey.shade100,
                                child: Container(
                                  color: Colors.white,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // #vote and #channel
                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: user?.profileImage?.medium == null
                                      ? const ColoredBox(
                                          color: Colors.blueAccent)
                                      : Image.network(
                                          user!.profileImage!.medium!),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                title: const Text("Pinterest"),
                                trailing: IconButton(
                                  icon: vote == 0
                                      ? const Icon(Icons.thumb_up_alt_outlined,
                                          size: 30)
                                      : const Icon(Icons.thumb_up_alt,
                                          color: Colors.red, size: 30),
                                  onPressed: pressVote,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // #title
                              Visibility(
                                visible: name.isNotEmpty,
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // #subtitle
                              Visibility(
                                visible: subTitle.isNotEmpty,
                                child: Text(
                                  subTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox.shrink(),
                                  ),

                                  // #favorite
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      onPressed: () => statistics != null
                                          ? _statisticsInfo()
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: const Color.fromRGBO(
                                            239, 239, 239, 1),
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 15,
                                        ),
                                      ),
                                      child: const Text(
                                        "Statistics",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),

                                  // #save
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        saveImage(image);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.red,
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 15,
                                        ),
                                      ),
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // #share
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.share,
                                        size: 30,
                                      ),
                                      onPressed: () => shareImage(image),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 2),

          // #similaryDetailPage
          Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 65,
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Similar",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                LayoutBuilder(builder: (context, boxConstraints) {
                  int crossAxisCount = boxConstraints.maxWidth ~/ 250;
                  if (boxConstraints.maxWidth < 580) {
                    // phone
                    return GalleryView(
                      realPage: correctPage,
                      crossAxisCount: 2,
                      api: NetworkService.API_ALL_USERS,
                      params: NetworkService.paramsAllPhotos(
                        perPage: 30,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  }
                  if (boxConstraints.maxWidth < 1025) {
                    // tablet
                    return GalleryView(
                      realPage: correctPage,
                      crossAxisCount: crossAxisCount,
                      api: NetworkService.API_ALL_USERS,
                      params: NetworkService.paramsAllPhotos(
                        perPage: 30,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  } else {
                    // desktop
                    return GalleryView(
                      realPage: correctPage,
                      crossAxisCount: crossAxisCount,
                      api: NetworkService.API_ALL_USERS,
                      params: NetworkService.paramsAllPhotos(
                        perPage: 30,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
}
