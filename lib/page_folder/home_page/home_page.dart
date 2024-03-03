import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import 'package:soda_project_final/page_folder/culture_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../custompage/custom_main_page.dart';
import 'home_page_2.dart';
import '../my_page/my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //late final TabController tabController;

  int _selectedIndex = 0;

  static List<Widget> widgetOptions = <Widget>[
    const HomePage2(),
    const CustomMainPage(),
    const CulturePage(),
    const MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      //TabBarView를 따로 하나의 class로 만들어서 column으로 묶어보자
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions.map<Widget>((Widget widget) {
          return Navigator(
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (BuildContext context) => widget,
              );
            },
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.textColor4,
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
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.navigationBarColor3,
        unselectedItemColor: const Color(0xffD1CDC8),
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
