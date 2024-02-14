import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import 'package:soda_project_final/home_page.dart';
import 'package:soda_project_final/page_folder/place_page.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'course_page.dart';
import 'culture_page.dart';
import 'place_page_for_custom.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _HomePageState();
}

class _HomePageState extends State<CustomPage> with TickerProviderStateMixin {
  late final TabController tabController;

  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        return;
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CulturePage()));
        return;
      }
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                '커스텀하기',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: -0.49,
                  color: AppColor.textColor7,
                ),
              ),
            ),
          ],
        ),
      ),
      //TabBarView를 따로 하나의 class로 만들어서 column으로 묶어보자
      body: const PlacePageForCustom(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_24_filled),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.pencil),
            label: '커스텀',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.ticket),
            label: '문화',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              IconaMoon.profile,
            ),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.navigationBarColor3,
        onTap: onItemTapped,
        selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4),
      ),
    );
  }
}
