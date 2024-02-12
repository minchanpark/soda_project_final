import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../app_color/app_color.dart';
import '../firestore_file/firestore_resturant.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({super.key});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  final FirestoreServiseResturant firestoreService =
      FirestoreServiseResturant();

  int? _value = 0;
  List<String> item = ['전체', '맛집', '카페', '놀거리'];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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

          return Column(
            children: [
              Wrap(
                spacing: 20,
                children: List.generate(4, (index) {
                  return ChoiceChip(
                    label: Text(item[index]),
                    selected: index == _value,
                    labelStyle: TextStyle(
                        color: index == _value ? Colors.white : Colors.black),
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : -1;
                        if (index == 1) {
                          Expanded(
                            child: ListView.builder(
                                itemCount: notesList.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      sortedNotesListSmall[index];

                                  Map<String, dynamic> data = documentSnapshot
                                      .data() as Map<String, dynamic>;

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
                                                      const EdgeInsets.only(
                                                          top: 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                      color: AppColor
                                                          .appBarColor1),
                                                  child: Text(
                                                    '${price.toString()}원',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: -0.18,
                                                        color: AppColor
                                                            .textColor4),
                                                  ),
                                                ),
                                                const Expanded(
                                                    child: Text(' ')),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.favorite_border)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          const Text('other');
                        }
                      });
                    },
                  );
                }),
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
