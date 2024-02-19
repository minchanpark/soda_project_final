import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soda_project_final/app_color/app_color.dart';
import 'package:soda_project_final/page_folder/custompage/custom_page.dart';

import '../../provider/appstate_provider.dart';

class CustomMainPage extends StatelessWidget {
  const CustomMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    MyAppState appState = Provider.of<MyAppState>(context);
    return Container(
      color: const Color(0xffFCD767),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 182, height: 112, child: Image.asset('assets/custom.png')),
          const SizedBox(height: 20),
          const Text('커스텀 하실 코스 이름을',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Pretendard Variable')),
          const Text('설정해주세요',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
          const SizedBox(height: 58),
          Container(
              width: 390,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColor.textColor4),
              child: TextField(
                controller: textEditingController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffDFDCD7)),
                    hintText: '커스텀 이름',
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
              )),
          const SizedBox(height: 69),
          SizedBox(
            width: 153,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                appState.addTrip(textEditingController.text);
                //Navigator.pushNamed(context, '/custom');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomPage()));
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                elevation: const MaterialStatePropertyAll(0),
                backgroundColor:
                    const MaterialStatePropertyAll(AppColor.textColor4),
              ),
              child: const Text(
                '시작하기',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textColor7,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
