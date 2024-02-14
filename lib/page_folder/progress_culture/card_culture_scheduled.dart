import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';

class CardCultureScheduled extends StatelessWidget {
  final String title;
  final String description;

  final String pictureName;

  const CardCultureScheduled({
    Key? key,
    required this.title,
    required this.description,
    required this.pictureName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 0,
        color: AppColor.backGroundColor2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    //사진 누르면 링크 연결
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
              ],
            ),
            GestureDetector(
              onTap: () {
                //여기도 누르면 링크 연결
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
      ),
    );
  }
}
