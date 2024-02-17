import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';
import 'package:soda_project_final/page_folder/home_page/home_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final GlobalKey closeKey = GlobalKey();
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    focusNodes = List<FocusNode>.generate(
      4,
      (int i) => FocusNode(debugLabel: 'Onboarding Focus Node $i'),
      growable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Onboarding(
        steps: [
          OnboardingStep(
              focusNode: focusNodes[0],
              titleText: '우리 동네 맛집/카페/놀거리를 한눈에 살펴볼 수 있어요')
        ],
        child: HomePage(),
      ),
    );
  }
}
