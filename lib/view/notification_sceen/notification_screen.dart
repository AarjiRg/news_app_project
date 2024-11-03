import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/utils/color_constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      appBar: AppBar(backgroundColor: ColorConstants.mainblack,
      iconTheme: IconThemeData(color: Colors.white),
        title: Text("Notifications",style: GoogleFonts.aladin(color: Colors.white,fontSize: 30),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text("No new notifications!",style: GoogleFonts.allan(color: ColorConstants.BrightMagenta,fontSize: 20),)
          ],
        ),
      ),
    );
  }
}