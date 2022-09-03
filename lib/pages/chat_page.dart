import 'package:flutter/material.dart';
import 'package:pinterest/views/topic.dart';

class ChatPage extends StatefulWidget {
  static const String id = '/chat_page';
  final int crossAxisCount;

  const ChatPage({Key? key, required this.crossAxisCount}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() {
      setState(() {
        _selectedIndex = controller.index;
      });
      changePage(_selectedIndex);
    });
    super.initState();
  }

  void changePage(int page) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Commonly discussed topics",
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            controller: controller,
            onTap: changePage,
            tabs: const [
              Tab(text: "Nature"),
              Tab(text: "Athletics"),
              Tab(text: "Animals"),
              Tab(text: "Wallpapers"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: controller,
          children: [
            TopicView(
              topic: "nature",
              crossAxisCount: widget.crossAxisCount,
            ),
            TopicView(
              topic: "athletics",
              crossAxisCount: widget.crossAxisCount,
            ),
            TopicView(
              topic: "animals",
              crossAxisCount: widget.crossAxisCount,
            ),
            TopicView(
              topic: "wallpapers",
              crossAxisCount: widget.crossAxisCount,
            ),
          ],
        ));
  }
}
