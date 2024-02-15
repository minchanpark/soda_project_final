import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';

import '../pop_up_page/card2_popup.dart';

class Card2TabPage extends StatelessWidget {
  const Card2TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '코스',
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              height: 1.0,
              letterSpacing: -0.49),
        ),
      ),
      body: ListView(
        children: [
          Image.asset('assets/card2_1.png'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 17, left: 20),
                    child: Text(
                      '추적추적 비올땐',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      '실내가 최고지',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 2.0,
                          color: AppColor.textColor5),
                    ),
                  ),
                ],
              ),
              const Expanded(child: Text('')),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                    width: 43,
                    height: 43,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.backGroundColor2,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                ]),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 33, left: 28),
            child: Row(
              children: [
                Text(
                  '코스 설명',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.11,
                      color: AppColor.textColor6),
                ),
                Expanded(child: Text('')),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppColor.textColor4,
                            content: const Card2PopUp(),
                            insetPadding:
                                const EdgeInsets.fromLTRB(0, 80, 0, 80),
                          );
                        });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      '세부정보 보기',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColor.textColor2,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 22),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: Image(
                        image: AssetImage('assets/mara.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('행복한 마라탕'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('10,000원'),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 58),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: Image(
                        image: AssetImage('assets/manhwa.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('만화라떼'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('2,400원'),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 58),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: Image(
                        image: AssetImage('assets/balling.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('ABC 볼링장'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('3,000원'),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, top: 26, bottom: 25),
            child: Row(
              children: [
                Expanded(child: Text('')),
                Text(
                  '총 15,400원',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41,
                      height: 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
