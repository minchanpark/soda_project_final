import 'package:flutter/material.dart';
import 'app_color/app_color.dart';
import 'page_folder/home_page/home_page.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFCD767),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 330, height: 47, child: Image.asset('assets/start.png')),
          SizedBox(height: 68),
          SizedBox(
              width: 182, height: 115, child: Image.asset('assets/custom.png')),
          const SizedBox(height: 102),
          SizedBox(
            width: 153,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                elevation: const MaterialStatePropertyAll(0),
                backgroundColor:
                    const MaterialStatePropertyAll(AppColor.textColor4),
              ),
              child: const Text(
                '시작하기',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textColor7,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
