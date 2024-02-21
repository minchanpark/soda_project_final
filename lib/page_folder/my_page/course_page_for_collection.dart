import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/page_folder/card_tab_page/card3_tab_page.dart';
import '../../app_color/app_color.dart';
import '../../firestore_file/firestore_course.dart';
import '../card_tab_page/card1_tab_page.dart';
import '../card_tab_page/card2_tab_page.dart';
import '../card_tab_page/card4_tab_page.dart';
import '../card_tab_page/card5_tab_page.dart';
import '../card_tab_page/card6_tab_page.dart';
import 'package:intl/intl.dart';

class CoursePageForCollection extends StatefulWidget {
  const CoursePageForCollection({super.key});

  @override
  State<CoursePageForCollection> createState() =>
      _CoursePageForCollectionState();
}

class _CoursePageForCollectionState extends State<CoursePageForCollection> {
  @override
  Widget build(BuildContext context) {
    FirestoreServiceCourse firestoreServiceCourse = FirestoreServiceCourse();

    return StreamBuilder(
        stream: firestoreServiceCourse.getNotesStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          List notesList = snapshot.data!.docs;

          notesList = snapshot.data!.docs;

          var f = NumberFormat('###,###,###,###');

          if (notesList.isNotEmpty) {
            return Column(
              children: [
                const SizedBox(height: 9),
                Expanded(
                  child: GridView.builder(
                    itemCount: notesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.35),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot documentSnapshot = notesList[index];
                      Map<String, dynamic> data =
                          documentSnapshot.data() as Map<String, dynamic>;

                      String title = data['title'] ?? ''; // null인 경우 빈 문자열 반환
                      double price = data['price'] ?? 0; // null인 경우 0 반환
                      String discription =
                          data['discription'] ?? 'null'; // null인 경우 빈 문자열 반환
                      String url = data["URL"] ?? 'null';

                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          elevation: 0,
                          color: AppColor.backGroundColor2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20141.png?alt=media&token=39c330ee-4aaf-44ed-ad67-b17eefd5d1b8') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Card1TabPage()));
                                      } else if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20141%20%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB.png?alt=media&token=9f522e16-6069-40a2-b77d-3c72dcd160c7') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Card2TabPage()));
                                      } else if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201413.png?alt=media&token=fd5bc6cf-e10e-4d5d-a31a-e2c913005bda') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Card3TabPage()));
                                      } else if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201414.png?alt=media&token=794d88e5-7946-4f46-809c-1b45d0dd71e5') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Card4TabPage()));
                                      } else if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201415.png?alt=media&token=34331bb1-b8dc-43b4-9afd-a32ae7567cd4') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Card5TabPage()));
                                      } else if (url ==
                                          'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201416.png?alt=media&token=76101246-4371-41d4-877d-5f0e004f9e37') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Card6TabPage()));
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: 182,
                                          height: 154,
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(url),
                                          ),
                                        ),
                                        Positioned(
                                            top: 130,
                                            left: 100,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                    color:
                                                        AppColor.appBarColor1,
                                                  ),
                                                  width: 75,
                                                  height: 20,
                                                ),
                                                Text(
                                                  '${f.format(price.toInt())}원~',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.18,
                                                      color:
                                                          AppColor.textColor4),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  /*Positioned(
                                  left: 132,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: AppColor.backGroundColor2,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isFavorited = !_isFavorited;
                      
                                            if (_isFavorited) {
                                              firestore
                                                  .collection("course")
                                                  .doc('course${widget.index}')
                                                  .set(
                                                {
                                                  "title": widget.title,
                                                  "discription": widget.description,
                                                  "URL": widget.pictureurl,
                                                  'timestamp': DateTime.now(),
                                                },
                                              );
                                            } else {
                                              firestore
                                                  .collection("course")
                                                  .doc('course${widget.index}')
                                                  .delete();
                                              _courseProvider
                                                  .deleteCourseCard(widget.title);
                                            }
                      
                                            //파베에 정보 넘기기
                                            print(widget.title);
                                            print(_isFavorited);
                                          });
                                        },
                                        icon: Icon(
                                          _isFavorited
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: AppColor.appBarColor1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (url ==
                                      'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20141.png?alt=media&token=39c330ee-4aaf-44ed-ad67-b17eefd5d1b8') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Card1TabPage()));
                                  } else if (url ==
                                      'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%20141%20%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB.png?alt=media&token=9f522e16-6069-40a2-b77d-3c72dcd160c7') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Card2TabPage()));
                                  } else if (url ==
                                      'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201413.png?alt=media&token=fd5bc6cf-e10e-4d5d-a31a-e2c913005bda') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Card3TabPage()));
                                  } else if (url ==
                                      'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201414.png?alt=media&token=794d88e5-7946-4f46-809c-1b45d0dd71e5') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Card4TabPage()));
                                  } else if (url ==
                                      'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201415.png?alt=media&token=34331bb1-b8dc-43b4-9afd-a32ae7567cd4') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Card5TabPage()));
                                  } else if (url ==
                                      'https://firebasestorage.googleapis.com/v0/b/soda-project-final.appspot.com/o/Rectangle%201416.png?alt=media&token=76101246-4371-41d4-877d-5f0e004f9e37') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Card6TabPage()));
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.37),
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.24,
                                          color: AppColor.textColor1,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 9),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.37),
                                      child: Text(
                                        discription,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.18,
                                          color: AppColor.textColor2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('찜한 코스가 없어요',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1f1e1d))),
                SizedBox(height: 10),
                Text('하트를 눌러 마음에 드는 코스를 찜해보세요.',
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
