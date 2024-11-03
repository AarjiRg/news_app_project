import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/utils/color_constants.dart';
import 'package:news_app_project/view/home_screen/home_screen.dart';
import 'package:news_app_project/view/search_screen/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {

  int _currentIndex = 0;
  late PageController _pageController ;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
         HomeScreen(),
         SearchScreen(),
          Container(color: Colors.green,),
    
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        
        backgroundColor: Colors.black,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[

          BottomNavyBarItem(
          inactiveColor: Colors.white,
            activeColor: ColorConstants.BrightMagenta,
            title: Text('Home',style: GoogleFonts.aladin(fontSize: 18),),
            icon: Icon(Icons.home,size: 30,)
          ),
          BottomNavyBarItem(
            inactiveColor: Colors.white,
              activeColor: ColorConstants.BrightMagenta,
            title: Text('Explore',style: GoogleFonts.aladin(fontSize: 18),),
            icon: Icon(Icons.explore,size: 30,)
          ),
          
        ],
      ),
    );
  }
}