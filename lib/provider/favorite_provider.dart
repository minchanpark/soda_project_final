import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> selectedFavoriteRestraurant = [];
  List<String> selectedFavoriteCafe = [];
  List<String> selectedFavoriteEntertainment = [];

  void addFavoriteRestaraurant(String favoriteName) {
    selectedFavoriteRestraurant.add(favoriteName);
    notifyListeners();
    print(selectedFavoriteRestraurant);
  }

  void deleteFavoriteRestaraurant(String favoriteName) {
    selectedFavoriteRestraurant.remove(favoriteName);
    notifyListeners();
    print(selectedFavoriteRestraurant);
  }

  void addFavoriteCafe(String favoriteName) {
    selectedFavoriteCafe.add(favoriteName);
    notifyListeners();
    print(selectedFavoriteCafe);
  }

  void deleteFavoriteCafe(String favoriteName) {
    selectedFavoriteCafe.remove(favoriteName);
    notifyListeners();
    print(selectedFavoriteCafe);
  }

  void addFavoriteEntertainment(String favoriteName) {
    selectedFavoriteEntertainment.add(favoriteName);
    notifyListeners();
    print(selectedFavoriteEntertainment);
  }

  void deleteFavoriteEntertainment(String favoriteName) {
    selectedFavoriteEntertainment.remove(favoriteName);
    notifyListeners();
    print(selectedFavoriteEntertainment);
  }
}
