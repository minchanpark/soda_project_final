import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soda_project_final/firestore_file/firestore_all.dart';
import 'package:soda_project_final/firestore_file/firestore_cafes.dart';
import 'package:soda_project_final/firestore_file/firestore_entertainment.dart';
import 'package:soda_project_final/firestore_file/firestore_resturant.dart';
import 'package:soda_project_final/provider/favorite_provider.dart';
import '../../app_color/app_color.dart';

class PlacePageForCollection extends StatelessWidget {
  const PlacePageForCollection({super.key});

  @override
  Widget build(BuildContext context) {
    FirestoreSAll firestoreSAll = FirestoreSAll();

    FavoriteProvider favoriteProvider = FavoriteProvider();

    return StreamBuilder(
        stream: firestoreSAll.getNotesStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
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
          notesList = snapshot.data!.docs;

          return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                favoriteProvider = Provider.of<FavoriteProvider>(context);

                DocumentSnapshot documentSnapshot = notesList[index];
                Map<String, dynamic> data =
                    documentSnapshot.data() as Map<String, dynamic>;

                String name = data['name'] ?? ''; // null인 경우 빈 문자열 반환
                int price = data['price'] ?? 0; // null인 경우 0 반환
                String explain = data['explain'] ?? 'null'; // null인 경우 빈 문자열 반환
                String location = data['location'] ?? ''; // null인 경우 빈 문자열 반환

                bool isSelected = favoriteProvider.selectedFavoriteRestraurant
                        .contains(name) ||
                    favoriteProvider.selectedFavoriteCafe.contains(name) ||
                    favoriteProvider.selectedFavoriteEntertainment
                        .contains(name);

                double opacity = isSelected ? 1.0 : 0.1;

                return Opacity(
                  opacity: opacity,
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
                                icon: Icon(Icons.favorite),
                                style: ButtonStyle(
                                  iconColor: MaterialStatePropertyAll(
                                      AppColor.appBarColor1),
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColor.backGroundColor1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
