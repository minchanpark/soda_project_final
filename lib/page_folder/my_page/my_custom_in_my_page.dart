import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_color/app_color.dart';
import '../../provider/appstate_provider.dart';
import '../../provider/trip_provider.dart';

class MyCustomInMyPage extends StatefulWidget {
  const MyCustomInMyPage({super.key});

  @override
  State<MyCustomInMyPage> createState() => _MyCustomInMyPageState();
}

class _MyCustomInMyPageState extends State<MyCustomInMyPage> {
  @override
  Widget build(BuildContext context) {
    MyAppState appState = Provider.of<MyAppState>(context);
    Trip? tripInstance = appState.trip;

    tripInstance?.totalSum ??= 0;

    if (tripInstance != null) {
      return Scaffold(
        appBar: AppBar(
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
        body: Column(
          children: [
            const Divider(),
            const SizedBox(height: 0),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      builder: (BuildContext context) => Dialog(
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
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    color: AppColor.textColor1),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 12),
                            child: Text(
                              trip.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.24,
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
                                      borderRadius: BorderRadius.circular(13)),
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
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
            child: Text(
          '커스텀 페이지에서 코스를 만들어주세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )),
      );
    }
  }
}
