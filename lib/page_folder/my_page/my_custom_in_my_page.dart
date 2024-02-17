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

    if (appState.trip != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            '나의 커스텀',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              height: 1.0,
              letterSpacing: -0.49,
            ),
          ),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1 / 1.35),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: appState.trips.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Card(
                  elevation: 0,
                  color: AppColor.backGroundColor2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Stack(children: [
                        SizedBox(
                          width: 172,
                          height: 154,
                          child: Icon(Icons.image),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 12),
                        child: Text(
                          tripInstance!.name,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                '${tripInstance.totalSum.toString()}원~',
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
                ),
              );
            }),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
      );
    }
  }
}
