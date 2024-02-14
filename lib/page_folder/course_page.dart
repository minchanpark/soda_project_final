import 'package:flutter/material.dart';
import '../app_color/app_color.dart';
import 'card_in_course/card1.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<Card1> cards = [
    const Card1(
      title: '스트레스 받아?',
      description: '매운거 먹고 소리 질러~',
      price: 19000,
      pictureName: 'card1',
    ),
    const Card1(
      title: '추적추적 비올 땐',
      description: '실내가 최고지',
      price: 15400,
      pictureName: 'card2',
    ),
    const Card1(
      title: '야자 끝나고 어디가지?',
      description: '떡볶이 먹고 노래방 고?',
      price: 12500,
      pictureName: 'card3',
    ),
    const Card1(
      title: '오늘은 소녀처럼 놀고시퍼',
      description: '파스타 먹고 티타임 가자 공주들아~',
      price: 20500,
      pictureName: 'card4',
    ),
    const Card1(
      title: '예쁜곳 모음.zip',
      description: '분위기 있고 인스타 감성 느낌~',
      price: 22300,
      pictureName: 'card5',
    ),
    const Card1(
      title: '몸이 뻐근하네',
      description: '총싸움 하고 놀아볼까?',
      price: 22800,
      pictureName: 'card6',
    ),
  ];

  late String title = '낮은 가격순';

  double _currentSliderValue = 20000;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              const Expanded(child: Text('')),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              const TabBar(
                                tabs: [
                                  Text(
                                    '가격',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '정렬',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                                unselectedLabelColor:
                                    AppColor.navigationBarColor5,
                                labelColor: AppColor.textColor1,
                                indicator: BoxDecoration(),
                              ),
                              SizedBox(
                                  width: 393,
                                  height: 261,
                                  child: TabBarView(children: [
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Slider(
                                        thumbColor: AppColor.appBarColor1,
                                        activeColor: AppColor.appBarColor1,
                                        inactiveColor: AppColor.appBarColor1,
                                        value: _currentSliderValue,
                                        min: 0,
                                        max: 60000,
                                        divisions: 3,
                                        label: _currentSliderValue
                                            .round()
                                            .toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _currentSliderValue = value;
                                          });
                                        },
                                      );
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 21),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 39),
                                            child: GestureDetector(
                                              child: const Text(
                                                '낮은 가격순',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  cards = List.from(cards)
                                                    ..sort((a, b) => a.price
                                                        .compareTo(b.price));
                                                });
                                                title = '낮은 가격순';
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          const Divider(),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 39),
                                            child: GestureDetector(
                                              child: const Text(
                                                '높은 가격순',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  cards = List.from(cards)
                                                    ..sort((a, b) => b.price
                                                        .compareTo(a.price));
                                                });
                                                title = '높은 가격순';
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  ]))
                            ],
                          ));
                    },
                  );
                },
                child: Row(
                  children: [
                    const Text('가격',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.18,
                          color: AppColor.textColor3,
                        )),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: AppColor.textColor3,
                    ),
                    const SizedBox(width: 10),
                    Text(title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.18,
                          color: AppColor.textColor3,
                        )),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: AppColor.textColor3,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1 / 1.35),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return cards[index];
            },
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ),
      ],
    );
  }
}
