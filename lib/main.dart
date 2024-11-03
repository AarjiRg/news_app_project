import 'package:flutter/material.dart';
import 'package:news_app_project/controller/home_screen_controller.dart';
import 'package:news_app_project/controller/news_category_controller.dart';
import 'package:news_app_project/controller/search_screen_controller/search_screen_controlller.dart';
import 'package:news_app_project/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:provider/provider.dart';


void main(){
runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController(),),
        ChangeNotifierProvider(create: (context) => SearchScreenContoller(),), 
         ChangeNotifierProvider(create: (context) => SearchScreenContollertwo(),), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
      ),
    );
  }
}