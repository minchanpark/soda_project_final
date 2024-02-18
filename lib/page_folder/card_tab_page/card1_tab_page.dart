import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';

import '../pop_up_page/card1_popup.dart';

class Card1TabPage extends StatelessWidget {
  const Card1TabPage({super.key});

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
          Image.asset('assets/card1_1.png'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 17, left: 20),
                    child: Text(
                      '스트레스 받아?',
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
                      '매운거 먹고 소리 질러~',
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
            padding: const EdgeInsets.only(top: 33, left: 28),
            child: Row(
              children: [
                const Text(
                  '코스 설명',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.11,
                      color: AppColor.textColor6),
                ),
                const Expanded(child: Text('')),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            backgroundColor: AppColor.textColor4,
                            content: Card1PopUp(),
                            insetPadding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                          );
                        });
                  },
                  child: const Padding(
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
                        image: AssetImage('assets/firechicken.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('신세계 불닭발'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('8,000원'),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Divider(),
            ],
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
                        image: AssetImage('assets/coin.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('지니코인노래연습장'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('5,000원'),
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
                        image: AssetImage('assets/walk.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('영일대 산책'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('0원'),
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
                        image: AssetImage('assets/hay.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 46),
                      child: Text('헤이안'),
                    ),
                    Expanded(child: Text('')),
                    Padding(
                      padding: EdgeInsets.only(right: 19),
                      child: Text('6,000원'),
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
                  '총 19,000원',
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
