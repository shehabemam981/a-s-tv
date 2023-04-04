import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tv/module/browse/mycategory.dart';
import 'package:tv/module/home/homeview.dart';
import 'package:tv/module/home2/detailsscreen.dart';
import 'package:tv/shared/styles/themes.dart';
import 'model/Results.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
    Hive.registerAdapter(ResultsAdapter());

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.RouteName ,
      theme:themes.darktheme,
      themeMode: ThemeMode.dark,
      routes: {
        HomeView.RouteName:(c)=>HomeView(),
        mycategory.RouteName:(c)=>mycategory(),
        detailsscreen.RouteName:(c)=>detailsscreen(),
      },
    );
  }}