import 'package:flutter/material.dart';
import 'package:plant_app/core/color.dart';
import 'package:plant_app/data/bottom_menu.dart';
import 'package:plant_app/page/control_panel_page.dart';
import 'package:plant_app/page/home_page.dart';
import 'package:plant_app/screens/control_device_screen.dart';
import 'package:plant_app/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController pageController = PageController();
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: child.length,
        controller: pageController,
        onPageChanged: (value) => setState(() => selectIndex = value),
        itemBuilder: (itemBuilder, index) {
          return Container(
            child: child[index],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; bottomMenu.length > i; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pageController.jumpToPage(i);
                        selectIndex = i;
                      });
                    },
                    child: Image.asset(
                      bottomMenu[i].imagePath,
                      color: selectIndex == i ? green : grey.withOpacity(0.5),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> child = [
  const ControlPanelPage(),
  const ControlDeviceScreen(),
   HomeScreen(),
];
