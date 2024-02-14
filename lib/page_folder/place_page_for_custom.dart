import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/firestore_file/firestore_cafes.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';
import 'package:soda_project_final/page_folder/cafe_page.dart';
import 'package:soda_project_final/page_folder/entertainment_page.dart';
import '../app_color/app_color.dart';
import '../firestore_file/firestore_resturant.dart';

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

  int? _value = 0;
  List<String> item = ['전체', '맛집', '카페', '놀거리', '나의 찜'];

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
                  child: ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          sortedNotesListSmall[index];

                      Map<String, dynamic> data =
                          documentSnapshot.data() as Map<String, dynamic>;

                      String name = data['name'];
                      int price = data['price'];
                      String explain = data['explain'];
                      String location = data['location'];

                      return SizedBox(
                        height: 162,
                        child: Card(
                          elevation: 0,
                          color: AppColor.backGroundColor2,
                          child: ListTile(
                            leading: const SizedBox(
                                width: 113,
                                height: 124,
                                child: Icon(Icons.image)),
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
