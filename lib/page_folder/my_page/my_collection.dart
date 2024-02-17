import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../../app_color/app_color.dart';
import 'course_page_for_collection.dart';
import 'place_page_for_collection.dart';

class MyCollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Tab 갯수를 2개로 설정
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: AppColor.navigationBarColor1, // Indicator Color
            labelColor: AppColor.textColor1, // Selected Tab Color
            unselectedLabelColor: AppColor.appBarColor2, // Unselected Tab Color
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(text: '장소'), // 텍스트 변경
              Tab(text: '코스'), // 텍스트 변경
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            PlacePageForCollection(), // 장소 페이지
            CoursePageForCollection(), // 코스 페이지
          ],
        ),
      ),
    );
  }
}