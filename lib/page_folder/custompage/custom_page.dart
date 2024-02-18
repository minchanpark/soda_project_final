import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import 'place_page_for_custom.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 154),
              const Text(
                '커스텀하기',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: -0.49,
                  color: AppColor.textColor7,
                ),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/custom');
                },
                child: const Text(
                  '이름 설정하기',
                  style: TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const PlacePageForCustom(),
    );
  }
}
