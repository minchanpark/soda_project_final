import 'package:flutter/material.dart';

import '../app_color/app_color.dart';
import 'card_in_course/card1.dart';
import 'card_in_course/card2.dart';
import 'card_in_course/card3.dart';
import 'card_in_course/card4.dart';
import 'card_in_course/card5.dart';
import 'card_in_course/card6.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              const Expanded(child: Text('')),
              GestureDetector(
                onTap: () {
                  print('tap');
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print('북구');
                                },
                                child: const Row(
                                  children: [
                                    Text('포항시 북구'),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: AppColor.textColor3,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Text('가격',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.18,
                          color: AppColor.textColor3,
                        )),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: AppColor.textColor3,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('정렬하기'),
                        ),
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Text('낮은 가격순',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.18,
                          color: AppColor.textColor3,
                        )),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: AppColor.textColor3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.count(
            primary: false,
            childAspectRatio: (1 / 1.35),
            padding: const EdgeInsets.only(left: 20, right: 20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: const <Widget>[
              Card1(),
              Card2(),
              Card3(),
              Card4(),
              Card5(),
              Card6(),
            ],
          ),
        ),
      ],
    );
  }
}
