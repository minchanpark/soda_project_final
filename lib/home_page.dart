import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import 'package:soda_project_final/page_folder/place_page.dart';
import 'firestore_file/firestore_resturant.dart';
import 'page_folder/course_page.dart';

class ShowPlaceList extends StatefulWidget {
  const ShowPlaceList({super.key});

  @override
  State<ShowPlaceList> createState() => _ShowPlaceListState();
}

class _ShowPlaceListState extends State<ShowPlaceList>
    with TickerProviderStateMixin {
  late final TabController tabController;

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
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          indicatorColor: AppColor.navigationBarColor1,
          labelColor: AppColor.textColor1,
          unselectedLabelColor: AppColor.appBarColor2,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const <Widget>[
            Tab(child: Text('장소')),
            Tab(child: Text('코스')),
          ],
        ),
      ),
      //TabBarView를 따로 하나의 class로 만들어서 column으로 묶어보자
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[
          PlacePage(),
          //Text('course'),
          CoursePage(),
        ],
      ),
    );
  }
}
