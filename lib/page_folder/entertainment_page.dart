import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';

import '../app_color/app_color.dart';
import '../firestore_file/firestore_cafes.dart';

class EntertainmentPage extends StatefulWidget {
  const EntertainmentPage({super.key});

  @override
  State<EntertainmentPage> createState() => _EntertainmentPageState();
}

class _EntertainmentPageState extends State<EntertainmentPage> {
  @override
  Widget build(BuildContext context) {
    final FirestoreServiseEntertainment firestoreService =
        FirestoreServiseEntertainment();
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          // 데이터가 null이 아닌지 검사
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

          return Expanded(
            child: ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = sortedNotesListSmall[index];

                Map<String, dynamic> data =
                    documentSnapshot.data() as Map<String, dynamic>;

                String name = data['name'] ?? ''; // null인 경우 빈 문자열 반환
                int price = data['price'] ?? 0; // null인 경우 0 반환
                String explain = data['explain'] ?? ''; // null인 경우 빈 문자열 반환
                String location = data['location'] ?? ''; // null인 경우 빈 문자열 반환

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
          );
        } else if (snapshot.hasError) {
          // 에러가 발생한 경우 에러 메시지를 출력합니다.
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 아직 수신되지 않은 경우 로딩 표시를 표시합니다.
          return CircularProgressIndicator();
        }
      },
    );
  }
}
