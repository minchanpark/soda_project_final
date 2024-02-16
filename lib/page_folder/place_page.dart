import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/firestore_file/firestore_cafes.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';
import 'package:soda_project_final/page_folder/cafe_page.dart';
import 'package:soda_project_final/page_folder/entertainment_page.dart';
import '../app_color/app_color.dart';
import '../firestore_file/firestore_resturant.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({Key? key});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  final FirestoreServiseResturant firestoreService =
      FirestoreServiseResturant();

  final storage = FirebaseStorage.instance;
  String title = '낮은 가격순';

  int? _value = 0;
  List<String> item = ['전체', '맛집', '카페', '놀거리'];

  List<DocumentSnapshot> notesList = []; // 리스트를 상태 변수로 선언합니다.

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          notesList = snapshot.data!.docs; // 데이터가 변경될 때마다 리스트를 업데이트합니다.

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
                final spacing = (constraints.maxWidth - (110 * 3)) / 3;
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
                          return Container(
                            color: AppColor.textColor4,
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 40),
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
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        '낮은 가격순',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
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
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text(
                                        '높은 가격순',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
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
              if (_value == 1) // 맛집이 선택되었을 때만 ListView를 보여줌
                Expanded(
                  child: ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot = selectedList[index];

                      Map<String, dynamic> data =
                          documentSnapshot.data() as Map<String, dynamic>;

                      String name = data['name'];
                      int price = data['price'];
                      String explain = data['explain'];
                      String location = data['location'];

                      String url = data["URL"];

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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: const EdgeInsets.only(top: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
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
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border),
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
              if (_value == 2) //카페가 선택 되었을 때,
                const CafePage(),
              if (_value == 3) //놀거리가 선택 되었을 때,
                const EntertainmentPage(),
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
