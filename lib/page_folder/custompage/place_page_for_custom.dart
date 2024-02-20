import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soda_project_final/firestore_file/firestore_custom.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';
import 'package:soda_project_final/provider/trip_provider.dart';
import '../../app_color/app_color.dart';
import '../../firestore_file/firestore_cafes.dart';
import '../../firestore_file/firestore_resturant.dart';
import '../../provider/appstate_provider.dart';
import '../my_page/my_custom_in_my_page.dart';

class PlacePageForCustom extends StatefulWidget {
  const PlacePageForCustom({Key? key});

  @override
  State<PlacePageForCustom> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePageForCustom> {
  String title = '낮은 가격순';

  final FirestoreServiseResturant firestoreService =
      FirestoreServiseResturant();

  final FirestoreServiseEntertainment firestoreServiceEntertainment =
      FirestoreServiseEntertainment();

  final FirestoreServiseCafes firestoreService3 = FirestoreServiseCafes();

  TextEditingController textEditingController = TextEditingController();

  int? _value = 0;
  List<String> item = [/*'전체',*/ '맛집', '카페', '놀거리', '나의 찜'];

  Color containerColor = AppColor.navigationBarColor5; // 기본 색상으로 초기화

  int cardCount = 100;
  late List<bool> selectedCardIndices;
  late List<bool> selectedCardIndicesEnter;
  late List<bool> selectedCardIndicesCafe;

  int sum = 0;

  late Trip tripInstance;

  List<DocumentSnapshot> selectedList = [];

  List<DocumentSnapshot> notesList = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final firestoreServiseCustom = FirestoreServiceCustom();

  @override
  void initState() {
    super.initState();

    //firestoreServiseCustom.clearCachedNotes();
    firestore.collection("collection").doc().delete();

    // 카드 개수에 맞게 리스트를 초기화
    selectedCardIndicesEnter = List<bool>.filled(cardCount, false);
    selectedCardIndices = List<bool>.filled(cardCount, false);
    selectedCardIndicesCafe = List<bool>.filled(cardCount, false);
  }

  OverlayEntry? overlayEntry; // 팝업 내용을 담을 OverlayEntry

  @override
  Widget build(BuildContext context) {
    MyAppState appState = Provider.of<MyAppState>(context);

    void showOverlay2(BuildContext context) {
      OverlayEntry overlayEntry2 = OverlayEntry(
        builder: (context) => Positioned(
          bottom: 0,
          left: 10.0,
          right: 10.0,
          child: Material(
            elevation: 0,
            child: Container(
              width: 393,
              height: 58,
              padding: const EdgeInsets.all(20),
              color: AppColor.backGroundColor2,
              child: Row(
                children: [
                  const Text('나의 커스텀에 코스가 저장 되었어요',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.24,
                          color: Color(0xff5f5c5b))),
                  const Expanded(child: Text('')),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCustomInMyPage()));
                    },
                    child: const Text('보러가기',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.24,
                            color: AppColor.appBarColor1,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.appBarColor1)),
                  )
                ],
              ),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(overlayEntry2);

      Future.delayed(const Duration(seconds: 3), () {
        overlayEntry2.remove();
      });
    }

    void removeOverlay() {
      overlayEntry?.remove(); // Overlay에서 OverlayEntry 제거
      overlayEntry = null; // OverlayEntry 초기화
    }

    void showOverlay(BuildContext context) {
      if (overlayEntry == null) {
        // OverlayEntry가 아직 생성되지 않았다면 새로 생성
        overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            bottom: 0,
            left: 10.0,
            right: 10.0,
            child: Material(
              elevation: 0,
              child: Container(
                width: 393,
                height: 68,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Row(
                  children: [
                    Text('총 가격: $sum원',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const Expanded(child: Text('')),
                    SizedBox(
                      width: 100,
                      height: 31,
                      child: ElevatedButton(
                          onPressed: () {
                            removeOverlay();
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyCustomInMyPage()));*/
                            showOverlay2(context);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColor.navigationBarColor4)),
                          child: const Text(
                            '저장',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                                color: AppColor.backGroundColor1),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );

        Overlay.of(context)
            .insert(overlayEntry!); // 현재 Overlay에 OverlayEntry 추가
      } else {
        // OverlayEntry가 이미 존재한다면, 가격 정보만 업데이트
        overlayEntry!.markNeedsBuild();
      }
    }

    void updateTotalPrice(int price, bool isSelected) {
      final tripinstance = appState.trip;
      setState(() {
        if (isSelected) {
          sum += price;
        } else {
          sum -= price;
        }
      });

      tripinstance?.totalSum = sum;

      // Overlay 팝업 표시
      showOverlay(context);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          notesList = snapshot.data!.docs;

          List<DocumentSnapshot> sortedNotesListLarge = List.from(notesList);
          sortedNotesListLarge.sort((a, b) {
            int priceA = a['price'];
            int priceB = b['price'];
            return priceB.compareTo(priceA);
          });

          List<DocumentSnapshot> sortedNotesListSmall = List.from(notesList);
          sortedNotesListSmall.sort((a, b) {
            int priceA = a['price'];
            int priceB = b['price'];
            return priceA.compareTo(priceB);
          });

          if (_value == 0) {
            selectedList = notesList;
          } else if (_value == 1) {
            selectedList = notesList;
          }

          return Container(
            decoration: const BoxDecoration(color: AppColor.textColor4),
            child: Column(
              children: [
                const Divider(),
                LayoutBuilder(builder: (context, constraints) {
                  final spacing = (constraints.maxWidth - (120 * 3)) / 3;
                  return Wrap(
                    spacing: spacing,
                    children: List.generate(4, (index) {
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
                if (_value == 0) // 맛집이 선택되었을 때만 ListView를 보여줌
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Expanded(
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
                                                    padding: EdgeInsets.only(
                                                        left: 40),
                                                    child: Text(
                                                      '정렬',
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // 낮은 가격순으로 notesList를 정렬
                                                    sortedNotesListSmall
                                                        .sort((a, b) {
                                                      int priceA = a['price'];
                                                      int priceB = b['price'];
                                                      return priceA
                                                          .compareTo(priceB);
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
                                                    // 높은 가격순으로 notesList를 정렬
                                                    sortedNotesListLarge
                                                        .sort((a, b) {
                                                      int priceA = a['price'];
                                                      int priceB = b['price'];
                                                      return priceB
                                                          .compareTo(priceA);
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
                          const SizedBox(height: 15),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / 1.35),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: notesList.length,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              itemBuilder: (context, index) {
                                DocumentSnapshot documentSnapshot =
                                    selectedList[index];
                                Map<String, dynamic> data = documentSnapshot
                                    .data() as Map<String, dynamic>;

                                String name = data['name'] ?? '';
                                String url = data['URL'] ?? '';
                                String location = data['location'] ?? '';
                                int price = data['price'];

                                FirebaseFirestore firestore =
                                    FirebaseFirestore.instance;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // 선택 상태 토글
                                      selectedCardIndices[index] =
                                          !selectedCardIndices[index];

                                      updateTotalPrice(data['price'],
                                          selectedCardIndices[index]);

                                      // 선택 상태에 따라 맛집 추가 또는 삭제
                                      if (selectedCardIndices[index]) {
                                        // 선택됐다면 추가
                                        appState.addRestaurant(name);
                                        appState.addRestaurantPrice(price);
                                        firestore
                                            .collection("collection")
                                            .doc('collection$index')
                                            .set(
                                          {
                                            "name": name,
                                            "URL": url,
                                            'location': location,
                                            'timestamp': DateTime.now(),
                                            'price': price
                                          },
                                        );

                                        firestore
                                            .collection("collectionImage")
                                            .doc('collectionImage$index')
                                            .set(
                                          {
                                            "name": name,
                                            "URL": url,
                                            'timestamp': DateTime.now(),
                                          },
                                        );
                                      } else {
                                        // 선택 해제됐다면 삭제
                                        appState.deleteRestaurant(name);
                                        appState.deleteRestaurantPrice(price);
                                        firestore
                                            .collection("collection")
                                            .doc('collection$index')
                                            .delete();

                                        firestore
                                            .collection("collectionImage")
                                            .doc('collectionImage$index')
                                            .delete();
                                      }
                                    });
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: AppColor.backGroundColor2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(children: [
                                          SizedBox(
                                            width: 172,
                                            height: 154,
                                            child: Image.network(url,
                                                fit: BoxFit.cover),
                                          ),
                                          Positioned(
                                            top: 11,
                                            left: 139,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  width: 33,
                                                  height: 33,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: (selectedCardIndices[
                                                            index])
                                                        ? AppColor.appBarColor1
                                                        : AppColor
                                                            .navigationBarColor5,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.check,
                                                  color:
                                                      AppColor.backGroundColor1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.09, top: 12),
                                          child: Text(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 19),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.location_on_outlined,
                                                color: Color(0xff61646b)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.37),
                                              child: Text(
                                                location,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: -0.18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                if (_value == 1) //카페가 선택 되었을 때,
                  StreamBuilder<QuerySnapshot>(
                    stream: firestoreService3.getNotesStream(),
                    builder: (context, snapshot) {
                      List<DocumentSnapshot> notesListCafe = [];
                      if (snapshot.hasData && snapshot.data != null) {
                        // 데이터가 null이 아닌지 검사
                        notesListCafe = snapshot.data!.docs;

                        List<DocumentSnapshot> sortedNotesListLargeCafe =
                            List.from(notesListCafe);
                        sortedNotesListLarge.sort((a, b) {
                          int priceA = a['price'];
                          int priceB = b['price'];
                          return priceB.compareTo(priceA);
                        });

                        List<DocumentSnapshot> sortedNotesListSmallCafe =
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
                            (BuildContext context, StateSetter setState) {
                          return Expanded(
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
                                              color: AppColor.textColor4,
                                              height: 200,
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 40),
                                                          child: Text(
                                                            '정렬',
                                                            style: TextStyle(
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // 낮은 가격순으로 notesList를 정렬
                                                          sortedNotesListSmallCafe
                                                              .sort((a, b) {
                                                            int priceA =
                                                                a['price'];
                                                            int priceB =
                                                                b['price'];
                                                            return priceA
                                                                .compareTo(
                                                                    priceB);
                                                          });
                                                          selectedListCafe =
                                                              sortedNotesListSmallCafe; // 정렬된 리스트를 selectedList에 할당
                                                          title =
                                                              '낮은 가격순'; // 타이틀 업데이트
                                                        });
                                                        Navigator.pop(
                                                            context); // 모달 바텀 시트 닫기
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 40),
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
                                                    const Divider(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // 높은 가격순으로 notesList를 정렬
                                                          sortedNotesListLargeCafe
                                                              .sort((a, b) {
                                                            int priceA =
                                                                a['price'];
                                                            int priceB =
                                                                b['price'];
                                                            return priceB
                                                                .compareTo(
                                                                    priceA);
                                                          });
                                                          selectedListCafe =
                                                              sortedNotesListLargeCafe; // 정렬된 리스트를 selectedList에 할당
                                                          title =
                                                              '높은 가격순'; // 타이틀 업데이트
                                                        });
                                                        Navigator.pop(
                                                            context); // 모달 바텀 시트 닫기
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 40),
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
                                const SizedBox(height: 15),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / 1.35),
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: notesListCafe.length,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot documentSnapshot =
                                          selectedListCafe[index];

                                      Map<String, dynamic> data =
                                          documentSnapshot.data()
                                              as Map<String, dynamic>;

                                      String name = data['name'] ?? '';
                                      int price = data['price'];
                                      String url = data["URL"] ?? '';
                                      String location = data['location'] ?? '';

                                      FirebaseFirestore firestore =
                                          FirebaseFirestore.instance;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // 선택 상태 토글
                                            selectedCardIndicesCafe[index] =
                                                !selectedCardIndicesCafe[index];

                                            updateTotalPrice(data['price'],
                                                selectedCardIndicesCafe[index]);

                                            // 선택 상태에 따라 맛집 추가 또는 삭제
                                            if (selectedCardIndicesCafe[
                                                index]) {
                                              // 선택됐다면 추가
                                              appState.addCafe(name);
                                              appState.addCafePrice(price);

                                              firestore
                                                  .collection("collection")
                                                  .doc('collectionCafe$index')
                                                  .set(
                                                {
                                                  "name": name,
                                                  "URL": url,
                                                  'location': location,
                                                  'timestamp': DateTime.now(),
                                                  'price': price
                                                },
                                              );

                                              firestore
                                                  .collection("collectionImage")
                                                  .doc(
                                                      'collectionImageCafe$index')
                                                  .set(
                                                {
                                                  "name": name,
                                                  "URL": url,
                                                  'timestamp': DateTime.now(),
                                                },
                                              );
                                            } else {
                                              // 선택 해제됐다면 삭제
                                              appState.deleteCafe(name);
                                              appState.deleteCafePrice(price);

                                              firestore
                                                  .collection("collection")
                                                  .doc('collectionCafe$index')
                                                  .delete();

                                              firestore
                                                  .collection("collectionImage")
                                                  .doc(
                                                      'collectionImageCafe$index')
                                                  .delete();
                                            }
                                          });
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: AppColor.backGroundColor2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(children: [
                                                SizedBox(
                                                  width: 172,
                                                  height: 154,
                                                  child: Image(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(url),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 11,
                                                  left: 139,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 33,
                                                        height: 33,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: (selectedCardIndicesCafe[
                                                                  index])
                                                              ? AppColor
                                                                  .appBarColor1
                                                              : AppColor
                                                                  .navigationBarColor5,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.check,
                                                        color: AppColor
                                                            .backGroundColor1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.09, top: 12),
                                                child: Text(
                                                  name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.24,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 19),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Color(0xff61646b)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.37),
                                                    child: Text(
                                                      location,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
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
                    stream: firestoreServiceEntertainment.getNotesStream(),
                    builder: (context, snapshot) {
                      List<DocumentSnapshot> notesListEntertainment = [];
                      if (snapshot.hasData && snapshot.data != null) {
                        // 데이터가 null이 아닌지 검사
                        notesListEntertainment = snapshot.data!.docs;

                        List<DocumentSnapshot>
                            sortedNotesListLargeEntertainment =
                            List.from(notesListEntertainment);
                        sortedNotesListLargeEntertainment.sort((a, b) {
                          int priceA = a['price'];
                          int priceB = b['price'];
                          return priceB.compareTo(priceA);
                        });

                        List<DocumentSnapshot>
                            sortedNotesListSmallEntertainment =
                            List.from(notesListEntertainment);
                        sortedNotesListLargeEntertainment.sort((a, b) {
                          int priceA = a['price'];
                          int priceB = b['price'];
                          return priceA.compareTo(priceB);
                        });

                        List<DocumentSnapshot> selectedListEntertainment = [];

                        // 선택된 정렬 기준에 따라 적절한 리스트를 할당합니다.
                        if (_value == 0) {
                          selectedList = notesList;
                        } else if (_value == 1) {
                          selectedListEntertainment = notesListEntertainment;
                        } else if (_value == 2) {
                          selectedListEntertainment = notesListEntertainment;
                        }

                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Expanded(
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
                                              color: AppColor.textColor4,
                                              height: 200,
                                              child: Center(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 40),
                                                          child: Text(
                                                            '정렬',
                                                            style: TextStyle(
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
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // 낮은 가격순으로 notesList를 정렬
                                                          sortedNotesListSmallEntertainment
                                                              .sort((a, b) {
                                                            int priceA =
                                                                a['price'];
                                                            int priceB =
                                                                b['price'];
                                                            return priceA
                                                                .compareTo(
                                                                    priceB);
                                                          });
                                                          selectedListEntertainment =
                                                              sortedNotesListSmallEntertainment; // 정렬된 리스트를 selectedList에 할당
                                                          title =
                                                              '낮은 가격순'; // 타이틀 업데이트
                                                        });
                                                        Navigator.pop(
                                                            context); // 모달 바텀 시트 닫기
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 40),
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
                                                    const Divider(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // 높은 가격순으로 notesList를 정렬
                                                          sortedNotesListLargeEntertainment
                                                              .sort((a, b) {
                                                            int priceA =
                                                                a['price'];
                                                            int priceB =
                                                                b['price'];
                                                            return priceB
                                                                .compareTo(
                                                                    priceA);
                                                          });
                                                          selectedListEntertainment =
                                                              sortedNotesListLargeEntertainment; // 정렬된 리스트를 selectedList에 할당
                                                          title =
                                                              '높은 가격순'; // 타이틀 업데이트
                                                        });
                                                        Navigator.pop(
                                                            context); // 모달 바텀 시트 닫기
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 40),
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
                                const SizedBox(height: 15),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / 1.35),
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: notesListEntertainment.length,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot documentSnapshot =
                                          selectedListEntertainment[index];

                                      Map<String, dynamic> data =
                                          documentSnapshot.data()
                                              as Map<String, dynamic>;

                                      String name = data['name'] ?? '';
                                      int price = data['price'];
                                      String url = data["URL"] ?? '';
                                      String location = data['location'] ?? '';

                                      FirebaseFirestore firestore =
                                          FirebaseFirestore.instance;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // 선택 상태 토글
                                            selectedCardIndicesEnter[index] =
                                                !selectedCardIndicesEnter[
                                                    index];

                                            updateTotalPrice(
                                                data['price'],
                                                selectedCardIndicesEnter[
                                                    index]);

                                            // 선택 상태에 따라 맛집 추가 또는 삭제
                                            if (selectedCardIndicesEnter[
                                                index]) {
                                              // 선택됐다면 추가
                                              appState.addEntertainment(name);
                                              appState
                                                  .addEntertainmentPrice(price);

                                              firestore
                                                  .collection("collection")
                                                  .doc(
                                                      'collectionEntertainment$index')
                                                  .set(
                                                {
                                                  "name": name,
                                                  "URL": url,
                                                  'location': location,
                                                  'timestamp': DateTime.now(),
                                                  'price': price,
                                                  'index': index,
                                                },
                                              );

                                              firestore
                                                  .collection("collectionImage")
                                                  .doc(
                                                      'collectionImageEnter$index')
                                                  .set(
                                                {
                                                  "name": name,
                                                  "URL": url,
                                                  'timestamp': DateTime.now(),
                                                },
                                              );
                                            } else {
                                              // 선택 해제됐다면 삭제
                                              appState
                                                  .deleteEntertainment(name);
                                              appState.deleteEntertainmentPrice(
                                                  price);

                                              firestore
                                                  .collection("collection")
                                                  .doc(
                                                      'collectionEntertainment$index')
                                                  .delete();

                                              firestore
                                                  .collection("collectionImage")
                                                  .doc(
                                                      'collectionImageEnter$index')
                                                  .delete();
                                            }
                                          });
                                        },
                                        child: Card(
                                          elevation: 0,
                                          color: AppColor.backGroundColor2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(children: [
                                                SizedBox(
                                                  width: 172,
                                                  height: 154,
                                                  child: Image(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(url),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 11,
                                                  left: 139,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 33,
                                                        height: 33,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color: (selectedCardIndicesEnter[
                                                                  index])
                                                              ? AppColor
                                                                  .appBarColor1
                                                              : AppColor
                                                                  .navigationBarColor5,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.check,
                                                        color: AppColor
                                                            .backGroundColor1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.09, top: 12),
                                                child: Text(
                                                  name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.24,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 19),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Color(0xff61646b)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.37),
                                                    child: Text(
                                                      location,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
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
                if (_value == 3)

                  //나의 찜 체이지를 만드는데, 여기는 위에서 저장한 것들을 모두 다 보여주는 페이지입니다.
                  StreamBuilder<QuerySnapshot>(
                    stream: firestoreServiseCustom.getNotesStream(),
                    builder: (context, snapshot) {
                      if (appState.trip == null) {
                        return Container(
                          padding: const EdgeInsets.only(top: 300),
                          child: const Text(
                            '커스텀 이름부터 설정해주세요',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        );
                      }

                      tripInstance = appState.trip!;

                      if (snapshot.hasData && snapshot.data != null) {
                        List<DocumentSnapshot> notesList = snapshot.data!.docs;

                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (1 / 1.35),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: notesList.length,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                                  notesList[index];
                              Map<String, dynamic> data = documentSnapshot
                                  .data() as Map<String, dynamic>;

                              String name = data['name'] ?? '';
                              String location = data['location'] ?? '';
                              String url = data["URL"] ?? '';

                              return Card(
                                elevation: 0,
                                color: AppColor.backGroundColor2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 172,
                                      height: 154,
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(url),
                                      ), // 실제 이미지로 대체
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.09, top: 12),
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 19),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined,
                                            color: Color(0xff61646b)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.37),
                                          child: Text(
                                            location,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError || appState.trip == null) {
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
              ],
            ),
          );
        } else {
          return const Text('No notes...');
        }
      },
    );
  }
}
