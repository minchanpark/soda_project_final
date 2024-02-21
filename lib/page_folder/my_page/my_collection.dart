import 'package:flutter/material.dart';
import '../../app_color/app_color.dart';
import 'course_page_for_collection.dart';
import 'place_page_for_collection.dart';

class MyCollectionPage extends StatelessWidget {
  const MyCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Tab 갯수를 2개로 설정
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.textColor4,
          bottom: const TabBar(
            indicatorColor: AppColor.navigationBarColor1, // Indicator Color
            labelColor: AppColor.textColor1, // Selected Tab Color
            unselectedLabelColor: AppColor.appBarColor2, // Unselected Tab Color
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(
                  child: Text(
                '장소',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              )), // 텍스트 변경
              Tab(
                  child: Text(
                '코스',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              )), // 텍스트 변경
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: AppColor.textColor4),
          child: const TabBarView(
            children: <Widget>[
              PlacePageForCollection(), // 장소 페이지
              CoursePageForCollection(), // 코스 페이지
            ],
          ),
        ),
      ),
    );
  }
}
