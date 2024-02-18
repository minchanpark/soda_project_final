import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_color/app_color.dart';
import '../../firestore_file/firestore_resturant.dart';
import '../../provider/favorite_provider.dart';
import '../card_in_course/card1.dart';
import 'cafe_page.dart';
import 'entertainment_page.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
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

  double _currentSliderValue = 60000;

  final FirestoreServiseResturant firestoreService =
      FirestoreServiseResturant();

  final storage = FirebaseStorage.instance;
  //String title = '낮은 가격순';

  int? _value = 0;
  List<String> item = [/*'전체',*/ '맛집', '카페', '놀거리'];

  List<DocumentSnapshot> notesList = []; // 리스트를 상태 변수로 선언합니다.

  Icon favoriteIcon = const Icon(Icons.favorite_border);

  bool _isSelected = false;

  final Set<int> _selectedItems = {};

  @override
  Widget build(BuildContext context) {
    var filteredCards =
        cards.where((card) => card.price <= _currentSliderValue).toList();
    return DefaultTabController(
      length: 2, // Tab 갯수를 2개로 설정
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorColor: AppColor.navigationBarColor1, // Indicator Color
            labelColor: AppColor.textColor1, // Selected Tab Color
            unselectedLabelColor: AppColor.appBarColor2, // Unselected Tab Color
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(text: '장소'), // 텍스트 변경
              Tab(text: '코스'), // 텍스트 변경
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getNotesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  notesList = snapshot.data!.docs; // 데이터가 변경될 때마다 리스트를 업데이트합니다.

                  List<DocumentSnapshot> sortedNotesListLarge =
                      List.from(notesList);
                  sortedNotesListLarge.sort((a, b) {
                    int priceA = a['price'];
                    int priceB = b['price'];
                    return priceB.compareTo(priceA);
                  });

                  List<DocumentSnapshot> sortedNotesListSmall =
                      List.from(notesList);
                  sortedNotesListSmall.sort((a, b) {
                    int priceA = a['price'];
                    int priceB = b['price'];
                    return priceA.compareTo(priceB);
                  });

                  List<DocumentSnapshot> selectedList =
                      []; // 선택된 정렬 기준에 따라 사용할 리스트를 선언합니다.

                  // 선택된 정렬 기준에 따라 적절한 리스트를 할당합니다.
                  if (_value == 0) {
                    selectedList = notesList;
                  } else if (_value == 1) {
                    selectedList = sortedNotesListSmall;
                  } else if (_value == 2) {
                    // 다른 탭들에 대한 처리를 추가할 수 있습니다.
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 20),

                      LayoutBuilder(builder: (context, constraints) {
                        //final spacing = (constraints.maxWidth - (110 * 3)) / 3;
                        final spacing = (constraints.maxWidth - (80 * 3)) / 3;
                        return Wrap(
                          spacing: spacing,
                          children: List.generate(3, (index) {
                            return SizedBox(
                              width: 80,
                              child: RawChip(
                                label: Text(
                                  item[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.225,
                                  ),
                                ),
                                selectedColor: AppColor.navigationBarColor3,
                                backgroundColor: index == _value
                                    ? AppColor.navigationBarColor3
                                    : Colors.transparent,
                                labelStyle: TextStyle(
                                  color: index == _value
                                      ? Colors.white
                                      : AppColor.navigationBarColor5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      100), // 원 모양으로 만들기 위한 모양 지정
                                  side: BorderSide(
                                    color: index == _value
                                        ? AppColor
                                            .navigationBarColor3 // 선택된 경우 테두리 색상 지정
                                        : Colors.white, // 선택되지 않은 경우 테두리 색상 지정
                                    width: 0, // 테두리 두께 지정
                                  ),
                                ),
                                selected: index == _value,
                                showCheckmark: false, // 체크 표시를 없애기 위한 속성
                                onSelected: (bool selected) {
                                  setState(() {
                                    _value = selected ? index : null;
                                  });
                                },
                              ),
                            );
                          }),
                        );
                      }),

                      Row(
                        children: [
                          const Expanded(child: Text('')),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: AppColor.textColor4,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 40),
                                                child: Text(
                                                  '정렬',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Divider()
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                //여기서 listtile을 정렬하는 함수를 호출합니다.
                                              });
                                              title = '낮은 가격순';
                                              Navigator.pop(context);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                '낮은 가격순',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                //여기서 listtile을 정렬하는 함수를 호출합니다.
                                              });
                                              title = '높은 가격순';
                                              Navigator.pop(context);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Text(
                                                '높은 가격순',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
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
                      //if (_value == 0) AllPage(),
                      if (_value == 0) // 맛집이 선택되었을 때만 ListView를 보여줌
                        Expanded(
                          child: ListView.builder(
                            itemCount: notesList.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                                  selectedList[index];

                              final isSelected = _selectedItems.contains(index);

                              Map<String, dynamic> data = documentSnapshot
                                  .data() as Map<String, dynamic>;

                              String name = data['name'];
                              int price = data['price'];
                              String explain = data['explain'];
                              String location = data['location'];
                              String url = data["URL"] ?? '';

                              FavoriteProvider favoriteProvider =
                                  Provider.of<FavoriteProvider>(context);

                              return SizedBox(
                                height: 162,
                                child: Card(
                                  elevation: 0,
                                  color: AppColor.backGroundColor2,
                                  child: ListTile(
                                    leading: SizedBox(
                                        width: 104,
                                        height: 124,
                                        child: Image(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(url),
                                        )),
                                    title: Row(
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.24,
                                          ),
                                        ),
                                        const Text(' '),
                                        Text(
                                          location,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          explain,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.18,
                                          ),
                                        ),
                                        const SizedBox(height: 56),
                                        Row(
                                          children: [
                                            Container(
                                              width: 75,
                                              height: 20,
                                              padding:
                                                  const EdgeInsets.only(top: 0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: AppColor.appBarColor1,
                                              ),
                                              child: Text(
                                                '${price.toString()}원~',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.18,
                                                  color: AppColor.textColor4,
                                                ),
                                              ),
                                            ),
                                            const Expanded(child: Text(' ')),
                                            IconButton(
                                              isSelected: _isSelected,
                                              //selectedIcon: Icon(Icons.favorite),
                                              onPressed: () {
                                                setState(() {
                                                  _isSelected = !_isSelected;

                                                  if (isSelected) {
                                                    _selectedItems
                                                        .remove(index);
                                                    favoriteProvider
                                                        .deleteFavoriteRestaraurant(
                                                            name);
                                                  } else {
                                                    _selectedItems.add(index);
                                                    favoriteProvider
                                                        .addFavoriteRestaraurant(
                                                            name);
                                                  }
                                                });
                                              },
                                              icon: (isSelected)
                                                  ? const Icon(Icons.favorite)
                                                  : favoriteIcon,
                                              style: const ButtonStyle(
                                                iconColor:
                                                    MaterialStatePropertyAll(
                                                        AppColor.appBarColor1),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        AppColor
                                                            .backGroundColor1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (_value == 1) //카페가 선택 되었을 때,
                        const CafePage(),
                      if (_value == 2) //놀거리가 선택 되었을 때,
                        const EntertainmentPage(),
                      //Text('ddd'),
                    ],
                  );
                } else {
                  return const Text('No notes...');
                }
              },
            ), // 장소 페이지
            Column(
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
                                                thumbColor:
                                                    AppColor.appBarColor1,
                                                activeColor:
                                                    AppColor.appBarColor1,
                                                inactiveColor:
                                                    AppColor.appBarColor1,
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
                                                    // 카드를 필터링하여 업데이트된 카드 배열을 얻습니다.
                                                    filteredCards = cards
                                                        .where((card) =>
                                                            card.price <=
                                                            _currentSliderValue)
                                                        .toList();
                                                  });
                                                },
                                              );
                                            }),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 21),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 39),
                                                    child: GestureDetector(
                                                      child: const Text(
                                                        '낮은 가격순',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          cards = List.from(
                                                              cards)
                                                            ..sort((a, b) => a
                                                                .price
                                                                .compareTo(
                                                                    b.price));
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
                                                        const EdgeInsets.only(
                                                            left: 39),
                                                    child: GestureDetector(
                                                      child: const Text(
                                                        '높은 가격순',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          cards = List.from(
                                                              cards)
                                                            ..sort((a, b) => b
                                                                .price
                                                                .compareTo(
                                                                    a.price));
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
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return GridView.builder(
                        itemCount: filteredCards.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1.35),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return filteredCards[index];
                        },
                        padding: const EdgeInsets.only(left: 20, right: 20),
                      );
                    },
                  ),
                ),
              ],
            ), // 코스 페이지
          ],
        ),
      ),
    );
  }
}
