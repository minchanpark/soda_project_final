import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_color/app_color.dart';
import '../../provider/appstate_provider.dart';
import '../../provider/trip_provider.dart';

class MyCustomInMyPage extends StatelessWidget {
  const MyCustomInMyPage({super.key});

  void showOverlay(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 90,
        left: 10.0,
        right: 10.0,
        child: Material(
          elevation: 0,
          child: Container(
            width: 393,
            height: 58,
            padding: const EdgeInsets.all(20),
            color: AppColor.backGroundColor2,
            child: const Row(
              children: [
                Text('정상적으로 삭제되었습니다',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.24)),
                Expanded(child: Text('')),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  double calculateHeight(int itemCount) {
    double itemHeight = 25.0; // 각 항목의 높이
    double separatorHeight = 0; // 항목 사이의 구분선 높이 (필요한 경우)
    int separatorCount = itemCount; // 구분선의 총 개수

    // 전체 높이 = (항목의 높이 * 항목의 개수) + (구분선의 높이 * 구분선의 개수)
    return (itemHeight * itemCount) + (separatorHeight * separatorCount);
  }

  @override
  Widget build(BuildContext context) {
    MyAppState appState = Provider.of<MyAppState>(context);
    Trip? tripInstance = appState.trip;

    tripInstance?.totalSum ??= 0;

    if (tripInstance != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.textColor4,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/custom');
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
              const SizedBox(width: 100),
              const Text(
                '나의 커스텀',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: -0.49,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: AppColor.textColor4),
          child: Column(
            children: [
              const Divider(),
              const SizedBox(height: 0),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.35),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: appState.trips.length,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, index) {
                      Trip trip = appState.trips[index];
                      return Card(
                        elevation: 0,
                        color: AppColor.backGroundColor2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Positioned(
                                top: 11,
                                left: 127,
                                child: IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                          elevation: 0,
                                          child: SizedBox(
                                            width: 272,
                                            height: 100,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const SizedBox(height: 25),
                                                const Text(
                                                  '삭제하시겠습니까?',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3,
                                                      color:
                                                          AppColor.textColor1),
                                                ),
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                        child: Text('')),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.3,
                                                            color: Color(
                                                                0xff2247cc)),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        appState.deleteTrip(
                                                            trip.name);
                                                        showOverlay(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 1.3,
                                                            color: AppColor
                                                                .textColor1),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 27)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                              const SizedBox(
                                width: 172,
                                height: 154,
                                child: Icon(Icons.image),
                              ),
                            ]),
                            GestureDetector(
                              onTap: () {
                                //
                                showModalBottomSheet<void>(
                                  backgroundColor: AppColor.textColor4,
                                  context: context,
                                  builder: (BuildContext context) {
                                    if (trip.selectedRestaurants.isNotEmpty ||
                                        trip.selectedCafes.isNotEmpty ||
                                        trip.selectedEntertainment.isNotEmpty) {
                                      return SingleChildScrollView(
                                        // SingleChildScrollView 추가
                                        padding:
                                            const EdgeInsets.only(left: 150),
                                        child: Column(
                                          children: [
                                            if (trip
                                                .selectedRestaurants.isNotEmpty)
                                              SizedBox(
                                                height: calculateHeight(trip
                                                    .selectedRestaurants
                                                    .length),
                                                child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                                                  itemCount: trip
                                                      .selectedRestaurants
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(
                                                      trip.selectedRestaurants[
                                                          index],
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    );
                                                  },
                                                ),
                                              ),
                                            if (trip.selectedCafes.isNotEmpty)
                                              SizedBox(
                                                height: calculateHeight(
                                                    trip.selectedCafes.length),
                                                child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                                                  itemCount:
                                                      trip.selectedCafes.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(
                                                      trip.selectedCafes[index],
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    );
                                                  },
                                                ),
                                              ),
                                            if (trip.selectedEntertainment
                                                .isNotEmpty)
                                              SizedBox(
                                                height: calculateHeight(trip
                                                    .selectedEntertainment
                                                    .length),
                                                child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                                                  itemCount: trip
                                                      .selectedEntertainment
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(
                                                      trip.selectedEntertainment[
                                                          index],
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    );
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }

                                    return Container();
                                  },
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 12),
                                child: Text(
                                  trip.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.appBarColor1,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    width: 80,
                                    height: 23,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      '${trip.totalSum.toString()}원~',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.textColor4,
        ),
        body: Container(
          decoration: BoxDecoration(color: AppColor.textColor4),
          child: const Center(
              child: Text(
            '커스텀 페이지에서 코스를 먼저 만들어주세요',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
        ),
      );
    }
  }
}
