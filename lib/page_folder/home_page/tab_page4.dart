import 'package:flutter/material.dart';
import '../../app_color/app_color.dart';

class TapPage4 extends StatelessWidget {
  const TapPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.textColor4,
        title: const Text('장소',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.49,
              height: 1.0,
            )),
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColor.textColor4),
        child: ListView(
          children: const [
            SizedBox(
              width: 393,
              height: 305,
              child: Image(
                  fit: BoxFit.fitWidth, image: AssetImage('assets/karts.png')),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 17, left: 20),
                      child: Text(
                        '카츠류',
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
                        '경북 포항시 북구 신덕로 253 ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 2.0,
                            color: AppColor.textColor5),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '일식 카츠 전문점',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.225,
                            color: AppColor.textColor1),
                      ),
                    ),
                  ],
                ),
                /*const Expanded(child: Text('')),
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
                )*/
              ],
            ),
            SizedBox(height: 11),
            Divider(
              endIndent: 20,
              indent: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('메뉴',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.1)),
                  SizedBox(height: 10),
                  Image(image: AssetImage('assets/karts_1.png')),
                ],
              ),
            ),
            SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
