import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

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
              const SizedBox(
                width: 172,
                height: 154,
                child: Icon(Icons.image),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 140,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: 8.37),
            child: Text(
              '추적추적 비올 땐',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.24,
                color: AppColor.textColor1,
              ),
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.only(left: 8.37),
            child: Text(
              '실내가 최고지',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.18,
                color: AppColor.textColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
