import 'package:flutter/material.dart';
import 'package:soda_project_final/page_folder/progress_culture/card_culture.dart';

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

    return Column(
      children: [
        Expanded(
          child: GridView.count(
            primary: false,
            childAspectRatio: (1 / 1.35),
            padding: const EdgeInsets.only(left: 20, right: 20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: cards.map((card) => card).toList(),
          ),
        ),
      ],
    );
  }
}
