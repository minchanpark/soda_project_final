import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soda_project_final/firestore_file/firestore_all.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';
import 'package:soda_project_final/page_folder/custompage/custom_page.dart';
import 'package:soda_project_final/provider/trip_provider.dart';
import '../../app_color/app_color.dart';
import '../../firestore_file/firestore_cafes.dart';
import '../../firestore_file/firestore_resturant.dart';
import '../../provider/appstate_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../my_page/my_custom_in_my_page.dart';

class PlacePageForCustom extends StatefulWidget {
  const PlacePageForCustom({Key? key});

  @override
  State<PlacePageForCustom> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePageForCustom> {
  final FirestoreServiseResturant firestoreService =
      FirestoreServiseResturant();

  final FirestoreServiseEntertainment firestoreService2 =
      FirestoreServiseEntertainment();

  final FirestoreServiseCafes firestoreService3 = FirestoreServiseCafes();

  final FirestoreSAll firestoreAll = FirestoreSAll();

  TextEditingController textEditingController = TextEditingController();

  int? _value = 0;
  List<String> item = ['전체', '맛집', '카페', '놀거리', '나의 찜'];

  Color containerColor = AppColor.navigationBarColor5; // 기본 색상으로 초기화

  int cardCount = 100;
  late List<bool> selectedCardIndices;
  late List<bool> selectedCardIndicesEnter;
  late List<bool> selectedCardIndicesCafe;

  int sum = 0;

  late Trip tripInstance;

  @override
  void initState() {
    super.initState();

    // 카드 개수에 맞게 리스트를 초기화
    selectedCardIndicesEnter = List<bool>.filled(cardCount, false);
    selectedCardIndices = List<bool>.filled(cardCount, false);
    selectedCardIndicesCafe = List<bool>.filled(cardCount, false);

    // WidgetsBinding을 사용하여 initState 완료 후 모달을 표시
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          MyAppState appState = Provider.of<MyAppState>(context);
          return Container(
            color: AppColor.textColor4,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          width: 27,
                          height: 24,
                          child: Image(image: AssetImage('assets/cancel.png')),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 102),
                        child: Text(
                          '나의 커스텀 이름 설정',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  TextField(
                    controller: textEditingController,
                    minLines: 1, // 최소 높이를 1줄로 설정
                    maxLines: 2, // 최대 높이를 3줄로 설정
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 31),
                      border: InputBorder.none,
                      hintText: '나만의 코스 이름을 설정해주세요.\n이름은 최소 한 글자 이상 입력해주세요. ',
                    ),
                  ),
                  const SizedBox(height: 320),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColor.appBarColor1),
                                  shape: MaterialStatePropertyAll(
                                      BeveledRectangleBorder(
                                          side: BorderSide.none))),
                              onPressed: () {
                                appState.addTrip(textEditingController.text);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                '저장하기',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                    color: AppColor.textColor1),
                              ))),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  OverlayEntry? overlayEntry; // 팝업 내용을 담을 OverlayEntry

  @override
  Widget build(BuildContext context) {
    MyAppState appState = Provider.of<MyAppState>(context);

    void removeOverlay() {
      overlayEntry?.remove(); // Overlay에서 OverlayEntry 제거
      overlayEntry = null; // OverlayEntry 초기화
    }

    void showOverlay(BuildContext context) {
      if (overlayEntry == null) {
        // OverlayEntry가 아직 생성되지 않았다면 새로 생성
        overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            child: Material(
              elevation: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Row(
                  children: [
                    Text('총 가격: $sum원', style: const TextStyle(fontSize: 20)),
                    const Expanded(child: Text('')),
                    SizedBox(
                      width: 100,
                      height: 31,
                      child: ElevatedButton(
                          onPressed: () async {
                            removeOverlay();
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyCustomInMyPage()));
                          },
                          style: ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColor.navigationBarColor4)),
                          child: Text(
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

      //tripinstance.totalSum = sum;
    }

    void updateTotalPrice(int price, bool isSelected) {
      Trip tripinstance = appState.trip;
      setState(() {
        if (isSelected) {
          sum += price;
        } else {
          sum -= price;
        }
      });

      tripinstance.totalSum = sum;

      // Overlay 팝업 표시
      showOverlay(context);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List notesList = snapshot.data!.docs;

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

          return Column(
            children: [
              const SizedBox(height: 20),
              LayoutBuilder(builder: (context, constraints) {
                final spacing = (constraints.maxWidth - (140 * 3)) / 3;
                return Wrap(
                  spacing: spacing,
                  children: List.generate(5, (index) {
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
                          borderRadius:
                              BorderRadius.circular(100), // 원 모양으로 만들기 위한 모양 지정
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
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Row(
                                      children: [
                                        Text('가격 설정'),
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
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              if (_value == 1) // 맛집이 선택되었을 때만 ListView를 보여줌
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          sortedNotesListLarge[index];
                      Map<String, dynamic> data =
                          documentSnapshot.data() as Map<String, dynamic>;

                      String name = data['name'] ?? '';
                      String url = data['URL'] ?? '';
                      String location = data['location'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // 선택 상태 토글
                            selectedCardIndices[index] =
                                !selectedCardIndices[index];

                            updateTotalPrice(
                                data['price'], selectedCardIndices[index]);

                            // 선택 상태에 따라 맛집 추가 또는 삭제
                            if (selectedCardIndices[index]) {
                              // 선택됐다면 추가
                              appState.addRestaurant(name);
                            } else {
                              // 선택 해제됐다면 삭제
                              appState.deleteRestaurant(name);
                            }
                          });
                        },
                        child: Card(
                          elevation: 0,
                          color: AppColor.backGroundColor2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                SizedBox(
                                  width: 172,
                                  height: 154,
                                  child: Image.network(url, fit: BoxFit.cover),
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
                                              BorderRadius.circular(100),
                                          color: (selectedCardIndices[index])
                                              ? AppColor.appBarColor1
                                              : AppColor.navigationBarColor5,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.check,
                                        color: AppColor.backGroundColor1,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.09, top: 12),
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
                                    padding: const EdgeInsets.only(left: 8.37),
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
              if (_value == 2) //카페가 선택 되었을 때,
                StreamBuilder<QuerySnapshot>(
                  stream: firestoreService3.getNotesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // 데이터가 null이 아닌지 검사
                      List notesList = snapshot.data!.docs;
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
                                sortedNotesListSmall[index];

                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            String name = data['name'] ?? '';
                            int price = data['price'] ?? 0;

                            String location = data['location'] ?? '';

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // 선택 상태 토글
                                  selectedCardIndicesCafe[index] =
                                      !selectedCardIndicesCafe[index];

                                  updateTotalPrice(data['price'],
                                      selectedCardIndicesCafe[index]);

                                  // 선택 상태에 따라 맛집 추가 또는 삭제
                                  if (selectedCardIndicesCafe[index]) {
                                    // 선택됐다면 추가
                                    appState.addCafe(name);
                                  } else {
                                    // 선택 해제됐다면 삭제
                                    appState.deleteCafe(name);
                                  }
                                });
                              },
                              child: Card(
                                elevation: 0,
                                color: AppColor.backGroundColor2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(children: [
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
                                                    BorderRadius.circular(100),
                                                color: (selectedCardIndicesCafe[
                                                        index])
                                                    ? AppColor.appBarColor1
                                                    : AppColor
                                                        .navigationBarColor5,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.check,
                                              color: AppColor.backGroundColor1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 172,
                                        height: 154,
                                        child: Icon(Icons.image),
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
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // 에러가 발생한 경우 에러 메시지를 출력합니다.
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // 데이터가 아직 수신되지 않은 경우 로딩 표시를 표시합니다.
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              if (_value == 3) //놀거리가 선택 되었을 때,
                StreamBuilder<QuerySnapshot>(
                  stream: firestoreService2.getNotesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // 데이터가 null이 아닌지 검사
                      List notesList = snapshot.data!.docs;
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
                                sortedNotesListSmall[index];

                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            String name = data['name'] ?? '';
                            int price = data['price'] ?? 0;

                            String location = data['location'] ?? '';

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // 선택 상태 토글
                                  selectedCardIndicesEnter[index] =
                                      !selectedCardIndicesEnter[index];

                                  updateTotalPrice(data['price'],
                                      selectedCardIndicesEnter[index]);

                                  // 선택 상태에 따라 맛집 추가 또는 삭제
                                  if (selectedCardIndicesEnter[index]) {
                                    // 선택됐다면 추가
                                    appState.addEntertainment(name);
                                  } else {
                                    // 선택 해제됐다면 삭제
                                    appState.deleteEntertainment(name);
                                  }
                                });
                              },
                              child: Card(
                                elevation: 0,
                                color: AppColor.backGroundColor2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(children: [
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
                                                    BorderRadius.circular(100),
                                                color: (selectedCardIndicesEnter[
                                                        index])
                                                    ? AppColor.appBarColor1
                                                    : AppColor
                                                        .navigationBarColor5,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.check,
                                              color: AppColor.backGroundColor1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 172,
                                        height: 154,
                                        child: Icon(Icons.camera),
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
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // 에러가 발생한 경우 에러 메시지를 출력합니다.
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // 데이터가 아직 수신되지 않은 경우 로딩 표시를 표시합니다.
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              if (_value == 4)
                //나의 찜 체이지를 만드는데, 여기는 위에서 저장한 것들을 모두 다 보여주는 페이지입니다.
                StreamBuilder<QuerySnapshot>(
                  stream: firestoreAll.getNotesStream(),
                  builder: (context, snapshot) {
                    tripInstance = appState.trip;

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
                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;

                            String name = data['name'] ?? '';
                            String location = data['location'] ?? '';

                            // 선택된 항목 중 하나와 일치하는지 확인
                            bool isSelected = tripInstance.selectedRestaurants
                                    .contains(name) ||
                                tripInstance.selectedCafes.contains(name) ||
                                tripInstance.selectedEntertainment
                                    .contains(name);

                            // 선택되지 않은 항목의 투명도를 조정
                            double opacity = isSelected ? 1.0 : 0.1;

                            return Opacity(
                              opacity: opacity,
                              child: Card(
                                elevation: 0,
                                color: AppColor.backGroundColor2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 172,
                                      height: 154,
                                      child: Icon(Icons.image), // 실제 이미지로 대체
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
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
            ],
          );
        } else {
          return const Text('No notes...');
        }
      },
    );
  }
}
