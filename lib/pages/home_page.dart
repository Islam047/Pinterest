import 'package:flutter/material.dart';
import 'package:pinterest/main_page.dart';
import '../services/network_service.dart';
import '../views/gallary_view.dart';

class HomeScreen extends StatefulWidget {
  final int subPage;
  final int crossAxisCount;

  const HomeScreen({Key? key, this.crossAxisCount = 2, this.subPage = 0})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Image> allImage = [];

  // #actionInPressHomeScreen
  void pressButton(int screen) {
    currentScreen = screen;
    controller.jumpToPage(screen);
    setState(() {});
  }

  // #paginationHomeScreen
  void onScreenChanged(int screen) {
    currentScreen = screen;
    setState(() {});
  }

  // #initializationHomeScreen
  @override
  void initState() {
    currentScreen = widget.subPage;
    controller = PageController(initialPage: widget.subPage, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // #all
              ElevatedButton(
                onPressed: () => pressButton(0),
                style: ElevatedButton.styleFrom(
                  primary: currentScreen == 0 ? Colors.black : Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  "All",
                  style: TextStyle(
                      color: currentScreen == 0 ? Colors.white : Colors.black,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      body:  GalleryView(
        crossAxisCount: widget.crossAxisCount,
        realPage: 0,
        api: NetworkService.API_ALL_USERS,
        params: NetworkService.paramsAllPhotos(),
        physics: const BouncingScrollPhysics(),
      ),

    );

  }
}

