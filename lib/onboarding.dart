import 'package:flutter/material.dart';
import 'onboarding3.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool _isTextVisible = false;
  bool _isTextVisibleSecond = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTextVisible = true;
      });
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isTextVisibleSecond = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xffFCD767),
        child: _isTextVisible
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 274,
                      height: 173,
                      child: Image.asset('assets/custom.png')),
                  SizedBox(
                      width: 192,
                      height: 59,
                      child: Image.asset('assets/coscos.png')),
                  const SizedBox(height: 10),
                  _isTextVisibleSecond
                      ? SizedBox(
                          width: 315,
                          height: 45,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Onboarding3()),
                              );
                            },
                            child: Image(
                                image: AssetImage('assets/onboardingpage.png')),
                          ))
                      : const SizedBox(
                          width: 315,
                          height: 45,
                        )
                ],
              )
            : Container());
  }
}
