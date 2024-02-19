import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  // CourseProvider의 단일 인스턴스를 저장할 private static 변수
  static final CourseProvider _instance = CourseProvider._internal();

  // 외부에서 인스턴스를 생성하지 못하게 private constructor를 선언
  CourseProvider._internal();

  // CourseProvider의 단일 인스턴스에 접근할 수 있는 정적 메서드
  factory CourseProvider() {
    return _instance;
  }

  // Course 타이틀을 저장할 리스트
  List<String> courseTitles = [];

  // 새로운 course title을 리스트에 추가하는 메서드
  void addCourseCard(String title) {
    courseTitles.add(title);
    notifyListeners();
    print(courseTitles);
  }

  void deleteCourseCard(String title) {
    courseTitles.remove(title);
    notifyListeners();
    print(courseTitles);
  }
}
