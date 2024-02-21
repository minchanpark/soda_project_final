import 'package:flutter/material.dart';
import 'package:soda_project_final/page_folder/progress_culture/card_culture.dart';

import '../../app_color/app_color.dart';

class ScheduledCulturePage extends StatefulWidget {
  const ScheduledCulturePage({super.key});

  @override
  State<ScheduledCulturePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<ScheduledCulturePage> {
  @override
  Widget build(BuildContext context) {
    List<CardCulture> cards = [
      const CardCulture(
        title: "구룡포 어서오시'게'",
        description: '2024년 3월 하순경',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture2',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColor.textColor4,
      ),
      child: GridView.count(
        primary: false,
        childAspectRatio: (1 / 1.35),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 2,
        children: cards.map((card) => card).toList(),
      ),
    );
  }
}
