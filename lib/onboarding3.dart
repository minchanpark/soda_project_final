import 'package:flutter/material.dart';
import 'package:soda_project_final/onboarding_main.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  Onboarding3State createState() => Onboarding3State();
}

class Onboarding3State extends State<Onboarding3> {
  // 이미지 목록입니다. 여기서 이미지 경로를 변경할 수 있습니다.
  List<String> images = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
  ];

  // 현재 선택된 이미지 인덱스
  int currentIndex = 0;

  void switchImage() {
    // 마지막 이미지를 탭했을 경우
    if (currentIndex == images.length - 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnboardingMain()));
    } else {
      // 다음 이미지로 전환합니다.
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: switchImage, // 이미지를 탭할 때 switchImage 함수를 호출합니다.
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(images[currentIndex]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
