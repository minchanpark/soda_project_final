import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';

import 'my_custom_in_my_page.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Column(
        children: [
          Text(
            '마이 페이지',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.49,
                height: 1.0),
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, top: 39),
        child: Column(children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 353,
              height: 302,
              decoration: BoxDecoration(
                  color: AppColor.appBarColor1,
                  borderRadius: BorderRadius.circular(30)),
              child: Stack(
                children: [
                  Image.asset('assets/mypage.png'),
                  Center(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 84,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.appBarColor1),
                      ),
                      const Text(
                        '나의 찜',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyCustomInMyPage()));
            },
            child: Container(
              width: 353,
              height: 302,
              decoration: BoxDecoration(
                  color: AppColor.appBarColor1,
                  borderRadius: BorderRadius.circular(30)),
              child: Stack(
                children: [
                  Image.asset('assets/mypage_1.png'),
                  Center(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 126,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.appBarColor1),
                      ),
                      const Text(
                        '나의 커스텀',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
