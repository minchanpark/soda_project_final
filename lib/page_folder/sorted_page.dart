import 'package:flutter/material.dart';

import 'card_in_course/card1.dart';

class SortedPage extends StatefulWidget {
  const SortedPage({super.key});

  @override
  State<SortedPage> createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 39),
              child: GestureDetector(
                child: const Text(
                  '낮은 가격순',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  setState(() {
                    cards = List.from(cards)
                      ..sort((a, b) => a.price.compareTo(b.price));
                  });
                  title = '낮은 가격순';
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 39),
              child: GestureDetector(
                child: const Text(
                  '높은 가격순',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  setState(() {
                    cards = List.from(cards)
                      ..sort((a, b) => b.price.compareTo(a.price));
                  });
                  title = '높은 가격순';
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
