import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/page_folder/home_page/tab4_enter_page.dart';
import 'package:soda_project_final/page_folder/home_page/tab_page2.dart';
import 'package:soda_project_final/page_folder/home_page/tab_page3.dart';
import 'package:soda_project_final/page_folder/home_page/tab_page5.dart';
import '../../app_color/app_color.dart';
import '../../firestore_file/firestore_cafes.dart';
import '../../firestore_file/firestore_entertainment.dart';
import '../../firestore_file/firestore_resturant.dart';
import '../card_in_course/card1.dart';
import 'tab1_cafe_page.dart';
import 'tab1_enter_page.dart';
import 'tab2_cafe_page.dart';
import 'tab2_enter_page.dart';
import 'tab3_cafe-page.dart';
import 'tab3_enter_page.dart';
import 'tab4_cafe_page.dart';
import 'tab5_cafe_page.dart';
import 'tab5_enter_page.dart';
import 'tab_page4.dart';
import 'tap_page1.dart';
import 'package:intl/intl.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List<Card1> cards = [
    const Card1(
      index: 0,
      title: '스트레스 받아?',
      description: '매운거 먹고 소리 질러~',
      price: 19000,
      pictureurl:
          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20141.png?alt=media&token=39c330ee-4aaf-44ed-ad67-b17eefd5d1b8',
    ),
    const Card1(
      index: 1,
      title: '추적추적 비올 땐',
      description: '실내가 최고지',
      price: 15400,
      pictureurl:
          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20141%20%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB.png?alt=media&token=9f522e16-6069-40a2-b77d-3c72dcd160c7',
    ),
    const Card1(
      index: 2,
      title: '야자 끝나고 어디가지?',
      description: '떡볶이 먹고 노래방 고?',
      price: 12500,
      pictureurl:
          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201413.png?alt=media&token=fd5bc6cf-e10e-4d5d-a31a-e2c913005bda',
    ),
    const Card1(
      index: 3,
      title: '오늘은 소녀처럼 놀고시퍼',
      description: '파스타 먹고 티타임 가자 공주들아~',
      price: 20500,
      pictureurl:
          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201414.png?alt=media&token=794d88e5-7946-4f46-809c-1b45d0dd71e5',
    ),
    const Card1(
      index: 4,
      title: '예쁜곳 모음.zip',
      description: '분위기 있고 인스타 감성 느낌~',
      price: 22300,
      pictureurl:
          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201415.png?alt=media&token=34331bb1-b8dc-43b4-9afd-a32ae7567cd4',
    ),
    const Card1(
      index: 5,
      title: '몸이 뻐근하네',
      description: '총싸움 하고 놀아볼까?',
      price: 22800,
      pictureurl:
          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201416.png?alt=media&token=76101246-4371-41d4-877d-5f0e004f9e37',
    ),
  ];

  var f = NumberFormat('###,###,###,###');

  late String title = '낮은 가격순';

  double _currentSliderValue = 60000;

  final FirestoreServiseResturant firestoreService =
      FirestoreServiseResturant();

  final FirestoreServiseCafes firestoreServiseCafes = FirestoreServiseCafes();

  final FirestoreServiseEntertainment firestoreServiceEntertainment =
      FirestoreServiseEntertainment();

  final storage = FirebaseStorage.instance;
  //String title = '낮은 가격순';

  int? _value = 0;
  List<String> item = ['맛집', '카페', '놀거리'];

  List<DocumentSnapshot> notesList = []; // 리스트를 상태 변수로 선언합니다.

  Icon favoriteIcon = const Icon(Icons.favorite_border);

  bool _isSelected = false;
  bool _isSelectedCafe = false;
  bool _isSelectedEntertainment = false;

  final Set<int> _selectedItems = {};
  final Set<int> _selectedItemsCafe = {};
  final Set<int> _selectedItemsEntertainment = {};

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isSelectedPriceHigh = false;
  bool isSelectedPriceLow = false;

  @override
  Widget build(BuildContext context) {
    var filteredCards =
        cards.where((card) => card.price <= _currentSliderValue).toList();
    return DefaultTabController(
      length: 2, // Tab 갯수를 2개로 설정
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.textColor4,
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
        body: Container(
          decoration: const BoxDecoration(color: AppColor.textColor4),
          child: TabBarView(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getNotesStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    notesList =
                        snapshot.data!.docs; // 데이터가 변경될 때마다 리스트를 업데이트합니다.

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

                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),

                          LayoutBuilder(builder: (context, constraints) {
                            //final spacing = (constraints.maxWidth - (110 * 3)) / 3;
                            final spacing =
                                (constraints.maxWidth - (80 * 3)) / 3;

                            if (_value == 0) {
                              selectedList = notesList;
                            } else if (_value == 1) {
                              selectedList = notesList;
                            }
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
                                        : AppColor.textColor4,
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
                                            : Colors
                                                .white, // 선택되지 않은 경우 테두리 색상 지정
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

                          //if (_value == 0) AllPage(),
                          if (_value == 0) // 맛집이 선택되었을 때만 ListView를 보여줌
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(child: Text('')),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 261,
                                                  decoration: const BoxDecoration(
                                                      color:
                                                          AppColor.textColor4,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30))),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 40),
                                                              child: Text(
                                                                '정렬',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                            Divider()
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              // 낮은 가격순으로 notesList를 정렬
                                                              sortedNotesListSmall
                                                                  .sort((a, b) {
                                                                int priceA =
                                                                    a['price'];
                                                                int priceB =
                                                                    b['price'];
                                                                return priceA
                                                                    .compareTo(
                                                                        priceB);
                                                              });
                                                              selectedList =
                                                                  sortedNotesListSmall; // 정렬된 리스트를 selectedList에 할당
                                                              title =
                                                                  '낮은 가격순'; // 타이틀 업데이트
                                                            });
                                                            Navigator.pop(
                                                                context); // 모달 바텀 시트 닫기
                                                          },
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 40,
                                                            ),
                                                            child: Text(
                                                              '낮은 가격순',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Divider(),
                                                        const SizedBox(
                                                            height: 10),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              // 높은 가격순으로 notesList를 정렬
                                                              sortedNotesListLarge
                                                                  .sort((a, b) {
                                                                int priceA =
                                                                    a['price'];
                                                                int priceB =
                                                                    b['price'];
                                                                return priceB
                                                                    .compareTo(
                                                                        priceA);
                                                              });
                                                              selectedList =
                                                                  sortedNotesListLarge; // 정렬된 리스트를 selectedList에 할당
                                                              title =
                                                                  '높은 가격순'; // 타이틀 업데이트
                                                            });
                                                            Navigator.pop(
                                                                context); // 모달 바텀 시트 닫기
                                                          },
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 40,
                                                            ),
                                                            child: Text(
                                                              '높은 가격순',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        const Divider(),
                                                        const SizedBox(
                                                            height: 11),
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
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: notesList.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot documentSnapshot =
                                              selectedList[index];

                                          final isSelected =
                                              _selectedItems.contains(index);

                                          Map<String, dynamic> data =
                                              documentSnapshot.data()
                                                  as Map<String, dynamic>;

                                          String name = data['name'];
                                          int price = data['price'];
                                          String explain = data['explain'];
                                          String location = data['location'];
                                          String url = data["URL"] ?? '';

                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: 148,
                                                width: 400,
                                                child: Card(
                                                    elevation: 0,
                                                    color: AppColor
                                                        .backGroundColor2,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 9.24),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (url ==
                                                                'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/2.png?alt=media&token=e9d6e755-f659-4b31-841f-caed9f5cad4f') {
                                                              //
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const TapPage1()));
                                                            }
                                                            if (url ==
                                                                'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/1.png?alt=media&token=d04bd2f8-ad06-4818-94c8-895f01f4e5b5') {
                                                              //
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const TapPage2()));
                                                            }
                                                            if (url ==
                                                                'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/20.png?alt=media&token=26ac0b20-2349-4ef9-bdd4-db0740cb425e') {
                                                              //
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const TapPage3()));
                                                            }
                                                            if (url ==
                                                                'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20142.png?alt=media&token=2754d11c-e1a7-45a5-81e8-12207348196b') {
                                                              //
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const TapPage4()));
                                                            }
                                                            if (url ==
                                                                'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/chicken.png?alt=media&token=13281834-d813-4ab4-972c-fad75ece2ec8') {
                                                              //
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const TapPage5()));
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 104,
                                                            height: 124,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              child: Image(
                                                                image:
                                                                    NetworkImage(
                                                                        url),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 12.36,
                                                            top: 12,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                name,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  letterSpacing:
                                                                      -0.24,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                location,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff696969),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  letterSpacing:
                                                                      -0.18,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                explain,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  letterSpacing:
                                                                      -0.18,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 1),
                                                              //버튼
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 75,
                                                                    height: 20,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13),
                                                                      color: AppColor
                                                                          .appBarColor1,
                                                                    ),
                                                                    child: Text(
                                                                      '${f.format(price)}원~',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        letterSpacing:
                                                                            -0.18,
                                                                        color: AppColor
                                                                            .textColor4,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //맛집 선택하는 코드
                                                                  SizedBox(
                                                                      width:
                                                                          140.17),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            0),
                                                                    child:
                                                                        IconButton(
                                                                      isSelected:
                                                                          _isSelected,
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          _isSelected =
                                                                              !_isSelected;

                                                                          if (isSelected) {
                                                                            _selectedItems.remove(index);

                                                                            firestore.collection("favorite").doc('favorite$index').delete();
                                                                          } else {
                                                                            _selectedItems.add(index);

                                                                            firestore.collection("favorite").doc('favorite$index').set(
                                                                              {
                                                                                "name": name,
                                                                                "explain": explain,
                                                                                "price": price,
                                                                                "URL": url,
                                                                                'location': location,
                                                                                'timestamp': DateTime.now(),
                                                                              },
                                                                            );
                                                                          }
                                                                        });
                                                                      },
                                                                      icon: (isSelected)
                                                                          ? const Icon(
                                                                              Icons.favorite)
                                                                          : favoriteIcon,
                                                                      style:
                                                                          const ButtonStyle(
                                                                        iconColor:
                                                                            MaterialStatePropertyAll(AppColor.appBarColor1),
                                                                        backgroundColor:
                                                                            MaterialStatePropertyAll(AppColor.backGroundColor1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (_value == 1) //카페가 선택 되었을 때,
                            StreamBuilder<QuerySnapshot>(
                              stream: firestoreServiseCafes.getNotesStream(),
                              builder: (context, snapshot) {
                                List<DocumentSnapshot> notesListCafe = [];
                                if (snapshot.hasData && snapshot.data != null) {
                                  // 데이터가 null이 아닌지 검사
                                  notesListCafe = snapshot.data!.docs;

                                  List<DocumentSnapshot>
                                      sortedNotesListLargeCafe =
                                      List.from(notesListCafe);
                                  sortedNotesListLarge.sort((a, b) {
                                    int priceA = a['price'];
                                    int priceB = b['price'];
                                    return priceB.compareTo(priceA);
                                  });

                                  List<DocumentSnapshot>
                                      sortedNotesListSmallCafe =
                                      List.from(notesListCafe);
                                  sortedNotesListSmall.sort((a, b) {
                                    int priceA = a['price'];
                                    int priceB = b['price'];
                                    return priceA.compareTo(priceB);
                                  });

                                  List<DocumentSnapshot> selectedListCafe = [];

                                  // 선택된 정렬 기준에 따라 적절한 리스트를 할당합니다.
                                  if (_value == 0) {
                                    selectedList = notesList;
                                  } else if (_value == 1) {
                                    selectedListCafe = notesListCafe;
                                  }

                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(child: Text('')),
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          decoration: const BoxDecoration(
                                                              color: AppColor
                                                                  .textColor4,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30))),
                                                          height: 261,
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                const Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              40),
                                                                      child:
                                                                          Text(
                                                                        '정렬',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                24,
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      // 낮은 가격순으로 notesList를 정렬
                                                                      sortedNotesListSmallCafe
                                                                          .sort((a,
                                                                              b) {
                                                                        int priceA =
                                                                            a['price'];
                                                                        int priceB =
                                                                            b['price'];
                                                                        return priceA
                                                                            .compareTo(priceB);
                                                                      });
                                                                      selectedListCafe =
                                                                          sortedNotesListSmallCafe; // 정렬된 리스트를 selectedList에 할당
                                                                      title =
                                                                          '낮은 가격순'; // 타이틀 업데이트
                                                                    });
                                                                    Navigator.pop(
                                                                        context); // 모달 바텀 시트 닫기
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                40),
                                                                    child: Text(
                                                                      '낮은 가격순',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const Divider(),
                                                                const SizedBox(
                                                                    height: 10),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      // 높은 가격순으로 notesList를 정렬
                                                                      sortedNotesListLargeCafe
                                                                          .sort((a,
                                                                              b) {
                                                                        int priceA =
                                                                            a['price'];
                                                                        int priceB =
                                                                            b['price'];
                                                                        return priceB
                                                                            .compareTo(priceA);
                                                                      });
                                                                      selectedListCafe =
                                                                          sortedNotesListLargeCafe; // 정렬된 리스트를 selectedList에 할당
                                                                      title =
                                                                          '높은 가격순'; // 타이틀 업데이트
                                                                    });
                                                                    Navigator.pop(
                                                                        context); // 모달 바텀 시트 닫기
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                40),
                                                                    child: Text(
                                                                      '높은 가격순',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const Divider(),
                                                                const SizedBox(
                                                                    height: 10),
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing:
                                                                -0.18,
                                                            color: AppColor
                                                                .textColor3,
                                                          )),
                                                      const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 20,
                                                        color:
                                                            AppColor.textColor3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: notesListCafe.length,
                                                itemBuilder: (context, index) {
                                                  DocumentSnapshot
                                                      documentSnapshot =
                                                      selectedListCafe[index];

                                                  final isSelectedCafe =
                                                      _selectedItemsCafe
                                                          .contains(index);

                                                  Map<String, dynamic> data =
                                                      documentSnapshot.data()
                                                          as Map<String,
                                                              dynamic>;

                                                  String name = data['name'] ??
                                                      ''; // null인 경우 빈 문자열 반환
                                                  int price = data['price'] ??
                                                      0; // null인 경우 0 반환
                                                  String explain = data[
                                                          'explain'] ??
                                                      'null'; // null인 경우 빈 문자열 반환
                                                  String location = data[
                                                          'location'] ??
                                                      ''; // null인 경우 빈 문자열 반환
                                                  String url =
                                                      data["URL"] ?? 'null';

                                                  return SizedBox(
                                                    height: 148,
                                                    width: 400,
                                                    child: Card(
                                                        elevation: 0,
                                                        color: AppColor
                                                            .backGroundColor2,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 9.24),
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/greg.png?alt=media&token=de989507-658d-420f-b983-0fa71384a0f0') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage1Cafe()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/cafetita.png?alt=media&token=9d37404f-229d-449a-a163-09e7fb303b82') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage2Cafe()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/frank.png?alt=media&token=5f5725c6-b2b2-4611-a794-f92a2f5b3689') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage3Cafe()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/plant.png?alt=media&token=70724d65-e275-4c49-a631-da534ffabeac') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage4Cafe()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20142.png?alt=media&token=2a271f25-8494-41da-9aff-1deb6bf0520c') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage5Cafe()));
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 104,
                                                                height: 124,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  child: Image(
                                                                    image:
                                                                        NetworkImage(
                                                                            url),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 12.36,
                                                                top: 12,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    name,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          -0.24,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    location,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xff696969),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          -0.18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    explain,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      letterSpacing:
                                                                          -0.18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          1),
                                                                  //버튼
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            75,
                                                                        height:
                                                                            20,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(13),
                                                                          color:
                                                                              AppColor.appBarColor1,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '${f.format(price)}원~',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            letterSpacing:
                                                                                -0.18,
                                                                            color:
                                                                                AppColor.textColor4,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      //맛집 선택하는 코드
                                                                      SizedBox(
                                                                          width:
                                                                              140.17),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            IconButton(
                                                                          isSelected:
                                                                              _isSelectedCafe,
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _isSelectedCafe = !_isSelectedCafe;

                                                                              if (isSelectedCafe) {
                                                                                _selectedItemsCafe.remove(index);

                                                                                firestore.collection("favorite").doc('favorite$index').delete();
                                                                              } else {
                                                                                _selectedItemsCafe.add(index);

                                                                                firestore.collection("favorite").doc('favorite$index').set(
                                                                                  {
                                                                                    "name": name,
                                                                                    "explain": explain,
                                                                                    "price": price,
                                                                                    "URL": url,
                                                                                    'location': location,
                                                                                    'timestamp': DateTime.now(),
                                                                                  },
                                                                                );
                                                                              }
                                                                            });
                                                                          },
                                                                          icon: (isSelectedCafe)
                                                                              ? const Icon(Icons.favorite)
                                                                              : favoriteIcon,
                                                                          style:
                                                                              const ButtonStyle(
                                                                            iconColor:
                                                                                MaterialStatePropertyAll(AppColor.appBarColor1),
                                                                            backgroundColor:
                                                                                MaterialStatePropertyAll(AppColor.backGroundColor1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                } else if (snapshot.hasError) {
                                  // 에러가 발생한 경우 에러 메시지를 출력합니다.
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // 데이터가 아직 수신되지 않은 경우 로딩 표시를 표시합니다.
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          if (_value == 2) //놀거리가 선택 되었을 때,
                            StreamBuilder<QuerySnapshot>(
                              stream: firestoreServiceEntertainment
                                  .getNotesStream(),
                              builder: (context, snapshot) {
                                List<DocumentSnapshot> notesListEntertainment =
                                    [];
                                if (snapshot.hasData && snapshot.data != null) {
                                  // 데이터가 null이 아닌지 검사
                                  notesListEntertainment = snapshot.data!.docs;

                                  List<DocumentSnapshot>
                                      sortedNotesListLargeEntertainment =
                                      List.from(notesListEntertainment);
                                  sortedNotesListLarge.sort((a, b) {
                                    int priceA = a['price'];
                                    int priceB = b['price'];
                                    return priceB.compareTo(priceA);
                                  });

                                  List<DocumentSnapshot>
                                      sortedNotesListSmallEntertainment =
                                      List.from(notesListEntertainment);
                                  sortedNotesListSmall.sort((a, b) {
                                    int priceA = a['price'];
                                    int priceB = b['price'];
                                    return priceA.compareTo(priceB);
                                  });

                                  List<DocumentSnapshot>
                                      selectedListEntertainment = [];

                                  // 선택된 정렬 기준에 따라 적절한 리스트를 할당합니다.
                                  if (_value == 0) {
                                    selectedList = notesList;
                                  } else if (_value == 1) {
                                    selectedListEntertainment =
                                        notesListEntertainment;
                                  } else if (_value == 2) {
                                    selectedListEntertainment =
                                        notesListEntertainment;
                                  }

                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(child: Text('')),
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          decoration: const BoxDecoration(
                                                              color: AppColor
                                                                  .textColor4,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30))),
                                                          height: 261,
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                const Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              40),
                                                                      child:
                                                                          Text(
                                                                        '정렬',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                24,
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      // 낮은 가격순으로 notesList를 정렬
                                                                      sortedNotesListSmallEntertainment
                                                                          .sort((a,
                                                                              b) {
                                                                        int priceA =
                                                                            a['price'];
                                                                        int priceB =
                                                                            b['price'];
                                                                        return priceA
                                                                            .compareTo(priceB);
                                                                      });
                                                                      selectedListEntertainment =
                                                                          sortedNotesListSmallEntertainment; // 정렬된 리스트를 selectedList에 할당
                                                                      title =
                                                                          '낮은 가격순'; // 타이틀 업데이트
                                                                    });
                                                                    Navigator.pop(
                                                                        context); // 모달 바텀 시트 닫기
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                40),
                                                                    child: Text(
                                                                      '낮은 가격순',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const Divider(),
                                                                const SizedBox(
                                                                    height: 10),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      // 높은 가격순으로 notesList를 정렬
                                                                      sortedNotesListLargeEntertainment
                                                                          .sort((a,
                                                                              b) {
                                                                        int priceA =
                                                                            a['price'];
                                                                        int priceB =
                                                                            b['price'];
                                                                        return priceB
                                                                            .compareTo(priceA);
                                                                      });
                                                                      selectedListEntertainment =
                                                                          sortedNotesListLargeEntertainment; // 정렬된 리스트를 selectedList에 할당
                                                                      title =
                                                                          '높은 가격순'; // 타이틀 업데이트
                                                                    });
                                                                    Navigator.pop(
                                                                        context); // 모달 바텀 시트 닫기
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                40),
                                                                    child: Text(
                                                                      '높은 가격순',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing:
                                                                -0.18,
                                                            color: AppColor
                                                                .textColor3,
                                                          )),
                                                      const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        size: 20,
                                                        color:
                                                            AppColor.textColor3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    notesListEntertainment
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  DocumentSnapshot
                                                      documentSnapshot =
                                                      selectedListEntertainment[
                                                          index];

                                                  final isSelectedEntertainment =
                                                      _selectedItemsEntertainment
                                                          .contains(index);

                                                  Map<String, dynamic> data =
                                                      documentSnapshot.data()
                                                          as Map<String,
                                                              dynamic>;

                                                  String name = data['name'] ??
                                                      ''; // null인 경우 빈 문자열 반환
                                                  int price = data['price'] ??
                                                      0; // null인 경우 0 반환
                                                  String explain = data[
                                                          'explain'] ??
                                                      'null'; // null인 경우 빈 문자열 반환
                                                  String location = data[
                                                          'location'] ??
                                                      ''; // null인 경우 빈 문자열 반환
                                                  String url =
                                                      data["URL"] ?? 'null';

                                                  return SizedBox(
                                                    height: 148,
                                                    width: 400,
                                                    child: Card(
                                                        elevation: 0,
                                                        color: AppColor
                                                            .backGroundColor2,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 9.24),
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/ballingimage.png?alt=media&token=bf0de6ed-0dee-4b46-a4b0-b8b561fccf49') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage1Enter()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/manhwacoffee.png?alt=media&token=9e0ef1ee-00b6-4c9d-96a0-ba3f7f5bb5c6') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage2Enter()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/laser.png?alt=media&token=9cabb440-a147-416d-bf34-cfecb17d3c16') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage3Enter()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/spacespace.png?alt=media&token=c7f461fd-fc1d-4d29-97c5-43c8e0cc669a') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage4Enter()));
                                                                }
                                                                if (url ==
                                                                    'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/boardboard.png?alt=media&token=4fd86757-d051-4c4f-a809-6aae822eecda') {
                                                                  //
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const TapPage5Enter()));
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 104,
                                                                height: 124,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  child: Image(
                                                                    image:
                                                                        NetworkImage(
                                                                            url),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 12.36,
                                                                top: 12,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    name,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          -0.24,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    location,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xff696969),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          -0.18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    explain,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      letterSpacing:
                                                                          -0.18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          1),
                                                                  //버튼
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            75,
                                                                        height:
                                                                            20,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(13),
                                                                          color:
                                                                              AppColor.appBarColor1,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '${f.format(price)}원~',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            letterSpacing:
                                                                                -0.18,
                                                                            color:
                                                                                AppColor.textColor4,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      //맛집 선택하는 코드
                                                                      SizedBox(
                                                                          width:
                                                                              140.17),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                0),
                                                                        child:
                                                                            IconButton(
                                                                          isSelected:
                                                                              _isSelectedEntertainment,
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              _isSelectedEntertainment = !_isSelectedEntertainment;

                                                                              if (isSelectedEntertainment) {
                                                                                _selectedItemsEntertainment.remove(index);

                                                                                firestore.collection("favorite").doc('favorite$index').delete();
                                                                              } else {
                                                                                _selectedItemsEntertainment.add(index);

                                                                                firestore.collection("favorite").doc('favorite$index').set(
                                                                                  {
                                                                                    "name": name,
                                                                                    "explain": explain,
                                                                                    "price": price,
                                                                                    "URL": url,
                                                                                    'location': location,
                                                                                    'timestamp': DateTime.now(),
                                                                                  },
                                                                                );
                                                                              }
                                                                            });
                                                                          },
                                                                          icon: (isSelectedEntertainment)
                                                                              ? const Icon(Icons.favorite)
                                                                              : favoriteIcon,
                                                                          style:
                                                                              const ButtonStyle(
                                                                            iconColor:
                                                                                MaterialStatePropertyAll(AppColor.appBarColor1),
                                                                            backgroundColor:
                                                                                MaterialStatePropertyAll(AppColor.backGroundColor1),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                } else if (snapshot.hasError) {
                                  // 에러가 발생한 경우 에러 메시지를 출력합니다.
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  // 데이터가 아직 수신되지 않은 경우 로딩 표시를 표시합니다.
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          //Text('ddd'),
                        ],
                      );
                    });
                  } else {
                    return const Text('No notes...');
                  }
                },
              ), // 여기까지 장소 페이지
              //아래부터는 코스 페이지
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
                                return Container(
                                  width: double.infinity,
                                  height: 261,
                                  decoration: const BoxDecoration(
                                      color: AppColor.textColor4,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: DefaultTabController(
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                '정렬',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                            unselectedLabelColor:
                                                AppColor.navigationBarColor5,
                                            labelColor: AppColor.textColor1,
                                            indicator: BoxDecoration(),
                                          ),
                                          Expanded(
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
                                                      _currentSliderValue =
                                                          value;
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
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
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
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Divider(),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          )
                                        ],
                                      )),
                                );
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
                        //const SizedBox(width: 10),
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
      ),
    );
  }
}
