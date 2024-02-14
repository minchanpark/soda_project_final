import 'package:flutter/material.dart';
import 'package:soda_project_final/page_folder/progress_culture/card_culture.dart';

class ProgressCulturePage extends StatefulWidget {
  const ProgressCulturePage({super.key});

  @override
  State<ProgressCulturePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<ProgressCulturePage> {
  @override
  Widget build(BuildContext context) {
    List<CardCulture> cards = [
      const CardCulture(
        title: '아라, NEXT',
        description: '2023.12.15 ~ 2024.3.31',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
      ),
      const CardCulture(
        title: '',
        description: '',
        pictureName: 'culture1',
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
