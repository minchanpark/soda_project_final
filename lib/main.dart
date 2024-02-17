import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soda_project_final/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:soda_project_final/provider/appstate_provider.dart';
import 'package:soda_project_final/provider/favorite_provider.dart';
import 'page_folder/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyAppState(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
