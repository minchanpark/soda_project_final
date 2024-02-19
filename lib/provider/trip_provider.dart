class Trip {
  String name;
  List<String> selectedRestaurants = [];
  List<int> selectedRestaurantsPrice = [];

  List<String> selectedCafes = [];
  List<int> selectedCafesPrice = [];

  List<String> selectedEntertainment = [];
  List<int> selectedEntertainmentPrice = [];

  int? totalSum;

  Trip(this.name);

  // 코스에 식당 추가
  void addRestaurant(String restaurantName) {
    selectedRestaurants.add(restaurantName);
  }

  // 코스에 카페 추가
  void addCafe(String cafeName) {
    selectedCafes.add(cafeName);
  }

  // 코스에 놀거리 추가
  void addEntertainment(String entertainmentName) {
    selectedEntertainment.add(entertainmentName);
  }
}
