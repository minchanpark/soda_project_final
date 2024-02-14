import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import 'package:soda_project_final/home_page.dart';
import 'package:soda_project_final/page_folder/place_page.dart';

import 'package:iconamoon/iconamoon.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'course_page.dart';
import 'custom_page.dart';

class CulturePage extends StatefulWidget {
  const CulturePage({super.key});

  @override
  State<CulturePage> createState() => _HomePageState();
}

class _HomePageState extends State<CulturePage> with TickerProviderStateMixin {
  late final TabController tabController;

  int _selectedIndex = 2;

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
      } else if (index == 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CustomPage()));
        return;
      }

      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      //TabBarView를 따로 하나의 class로 만들어서 column으로 묶어보자
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 77),
            child: TabBar(
              controller: tabController,
              indicatorColor: AppColor.navigationBarColor1,
              labelColor: AppColor.textColor1,
              unselectedLabelColor: AppColor.appBarColor2,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const <Widget>[
                Tab(child: Text('진행중인')),
                Tab(child: Text('예정된')),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const <Widget>[
                PlacePage(), //페이지 새로 파기-진행중인 페이지
                CoursePage(), //페이지 새로 파기-예정된 페이지
              ],
            ),
          ),
        ],
      ),
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
