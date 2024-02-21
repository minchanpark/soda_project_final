import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/firestore_file/firestore_favorite.dart';
import '../../app_color/app_color.dart';
import 'package:intl/intl.dart';

import '../home_page/tab_page2.dart';
import '../home_page/tab_page3.dart';
import '../home_page/tab_page4.dart';
import '../home_page/tab_page5.dart';
import '../home_page/tap_page1.dart';

class PlacePageForCollection extends StatelessWidget {
  const PlacePageForCollection({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreServiseFavorite firestoreServiseFavorite =
        FirestoreServiseFavorite();
    var f = NumberFormat('###,###,###,###');
    return StreamBuilder(
        stream: firestoreServiseFavorite.getNotesStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List notesList = snapshot.data!.docs;

          notesList = snapshot.data!.docs;
          if (notesList.isNotEmpty) {
            return Column(
              children: [
                SizedBox(height: 9),
                Expanded(
                  child: ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot = notesList[index];
                        Map<String, dynamic> data =
                            documentSnapshot.data() as Map<String, dynamic>;

                        String name = data['name'] ?? ''; // null인 경우 빈 문자열 반환
                        int price = data['price'] ?? 0; // null인 경우 0 반환
                        String explain =
                            data['explain'] ?? 'null'; // null인 경우 빈 문자열 반환
                        String location =
                            data['location'] ?? ''; // null인 경우 빈 문자열 반환
                        String url = data["URL"] ?? '';

                        return Container(
                          padding: const EdgeInsets.only(
                              top: 3, right: 21, left: 20),
                          height: 148,
                          width: 400,
                          child: Card(
                              elevation: 0,
                              color: AppColor.backGroundColor2,
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
                                                builder: (context) =>
                                                    const TapPage1()));
                                      }
                                      if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/1.png?alt=media&token=d04bd2f8-ad06-4818-94c8-895f01f4e5b5') {
                                        //
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TapPage2()));
                                      }
                                      if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/20.png?alt=media&token=26ac0b20-2349-4ef9-bdd4-db0740cb425e') {
                                        //
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TapPage3()));
                                      }
                                      if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20142.png?alt=media&token=2754d11c-e1a7-45a5-81e8-12207348196b') {
                                        //
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TapPage4()));
                                      }
                                      if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/chicken.png?alt=media&token=13281834-d813-4ab4-972c-fad75ece2ec8') {
                                        //
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TapPage5()));
                                      }
                                    },
                                    child: Container(
                                      width: 104,
                                      height: 124,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image(
                                          image: NetworkImage(url),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12.36,
                                      top: 12,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.24,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          location,
                                          style: const TextStyle(
                                            color: Color(0xff696969),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.18,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          explain,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.18,
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        //버튼
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
                                                '${f.format(price)}원~',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.18,
                                                  color: AppColor.textColor4,
                                                ),
                                              ),
                                            ),
                                            //맛집 선택하는 코드
                                            SizedBox(width: 140.17),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        );
                      }),
                ),
              ],
            );
          } else {
            return const Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('찜한 장소가 없어요',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1f1e1d))),
                SizedBox(height: 10),
                Text('하트를 눌러 마음에 드는 장소를 찜해보세요.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff83817d))),
              ],
            ));
          }
        });
  }
}
