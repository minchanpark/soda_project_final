import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/app_color/app_color.dart';

import 'firestore_file/firestore_resturant.dart';

class ShowPlaceList extends StatefulWidget {
  const ShowPlaceList({super.key});

  @override
  State<ShowPlaceList> createState() => _ShowPlaceListState();
}

class _ShowPlaceListState extends State<ShowPlaceList> {
  @override
  Widget build(BuildContext context) {
    final FirestoreServiseResturant firestoreService =
        FirestoreServiseResturant();
    int? _value = 0;
    List<String> item = ['SODA', 'CAMP', 'FUN', 'FLUTTER'];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 196 + 196,
              height: 40,
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColor.appBarColor1))),
              padding: const EdgeInsets.only(top: 0),
              child: const Text(
                '장소',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
            /*Wrap(
              spacing: 10,
              children: List<Widget>.generate(
                4,
                (index) {
                  return ChoiceChip(
                    selectedColor: const Color.fromRGBO(24, 41, 73, 1),
                    label: Text(item[index]),
                    selected: _value == index,
                    labelStyle: TextStyle(
                        color: index == _value ? Colors.white : Colors.black),
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            List<DocumentSnapshot> sortedNotesListLarge = List.from(notesList);
            //price가 큰 순서대로 listtile을 정렬
            sortedNotesListLarge.sort((a, b) {
              int priceA = a['price'];
              int priceB = b['price'];
              return priceB.compareTo(priceA);
            });

            List<DocumentSnapshot> sortedNotesListSmall = List.from(notesList);
            //price가 작은 순서대로 listtile을 정렬
            sortedNotesListSmall.sort((a, b) {
              int priceA = a['price'];
              int priceB = b['price'];
              return priceA.compareTo(priceB);
            });

            return ListView.builder(
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
                            width: 113, height: 124, child: Icon(Icons.image)),
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
                                      color: AppColor.appBarColor1),
                                  child: Text(
                                    '${price.toString()}원',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.18,
                                        color: AppColor.textColor4),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 93),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Text('No notes...');
          }
        },
      ),
    );
  }
}
