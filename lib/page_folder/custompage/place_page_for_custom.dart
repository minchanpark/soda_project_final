import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';
import '../../app_color/app_color.dart';
import '../../firestore_file/firestore_cafes.dart';
import '../../firestore_file/firestore_resturant.dart';

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

  int? _value = 0;
  List<String> item = ['전체', '맛집', '카페', '놀거리', '나의 찜'];

  Color containerColor = AppColor.navigationBarColor5; // 기본 색상으로 초기화

  int cardCount = 100;
  late List<bool> selectedCardIndices;
  late List<bool> selectedCardIndicesEnter;
  late List<bool> selectedCardIndicesCafe;

  @override
  void initState() {
    super.initState();
    // 이곳에 카드 개수에 맞게 리스트를 초기화하세요.

    selectedCardIndicesEnter = List<bool>.filled(cardCount, false);
    selectedCardIndices = List<bool>.filled(cardCount, false);
    selectedCardIndicesCafe = List<bool>.filled(cardCount, false);
  }

  @override
  Widget build(BuildContext context) {
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
                      int price = data['price'] ?? 0;

                      String location = data['location'] ?? '';

                      return GestureDetector(
                        onTap: () {
                          print('${index}click');
                          //아이콘 색 바꾸고 카드 색 회색으로
                          //index가 카드마다 다름을 확인하기 위한 코드
                          setState(() {
                            selectedCardIndices[index] =
                                !selectedCardIndices[index];
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
                                const SizedBox(
                                  width: 172,
                                  height: 154,
                                  child: Icon(Icons.camera),
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
                                print('${index}click');
                                //아이콘 색 바꾸고 카드 색 회색으로
                                //index가 카드마다 다름을 확인하기 위한 코드
                                setState(() {
                                  selectedCardIndicesCafe[index] =
                                      !selectedCardIndicesCafe[index];
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
              if (_value == 3) //놀거리가 선택 되었을 때,
                StreamBuilder<QuerySnapshot>(
                  stream: firestoreService.getNotesStream(),
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
                                print('${index}click');
                                //아이콘 색 바꾸고 카드 색 회색으로
                                //index가 카드마다 다름을 확인하기 위한 코드
                                setState(() {
                                  selectedCardIndicesEnter[index] =
                                      !selectedCardIndicesEnter[index];
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
              //Text('ddd'),
            ],
          );
        } else {
          return const Text('No notes...');
        }
      },
    );
  }
}
