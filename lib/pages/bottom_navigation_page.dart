import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/pages/navigate_pages.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kGreenColor,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wechat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page_sharp), label: "Contact"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}
