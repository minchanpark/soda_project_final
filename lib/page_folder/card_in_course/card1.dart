import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import '../card_tab_page/card1_tab_page.dart';
import '../card_tab_page/card2_tab_page.dart';
import '../card_tab_page/card3_tab_page.dart';
import '../card_tab_page/card4_tab_page.dart';
import '../card_tab_page/card5_tab_page.dart';
import '../card_tab_page/card6_tab_page.dart';

class Card1 extends StatelessWidget {
  final String title;
  final String description;
  final double price; // 가격 속성 추가
  final String pictureName;

  const Card1({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.pictureName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColor.backGroundColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (pictureName == 'card1') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Card1TabPage()));
                  } else if (pictureName == 'card2') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Card2TabPage()));
                  } else if (pictureName == 'card3') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Card3TabPage()));
                  } else if (pictureName == 'card4') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Card4TabPage()));
                  } else if (pictureName == 'card5') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Card5TabPage()));
                  } else if (pictureName == 'card6') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Card6TabPage()));
                  }
                },
                child: SizedBox(
                  width: 180,
                  height: 154,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/$pictureName.png'),
                  ),
                ),
              ),
              Positioned(
                left: 140,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Card1TabPage(),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 8.37),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.24,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Padding(
                  padding: const EdgeInsets.only(left: 8.37),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.18,
                      color: AppColor.textColor2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
