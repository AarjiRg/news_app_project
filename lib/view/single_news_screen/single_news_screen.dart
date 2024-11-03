import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/utils/color_constants.dart';


class SingleNewsScreen extends StatefulWidget {
  const SingleNewsScreen({super.key, required this.imgurl, required this.newstitle, required this.newsauthor, required this.newsurl, required this.newsdiscription, required this.newstime});
final String imgurl;
final String newstitle;
final String newsauthor;
final String newsurl;
final String newsdiscription;
final String newstime;
  @override
  State<SingleNewsScreen> createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: ColorConstants.mainblack,
        title: Text("InstaNews", style: GoogleFonts.aladin(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 500,
                
                  decoration: BoxDecoration(
         color: ColorConstants.BrightMagenta,
                  ),
                 child: Image.network(widget.imgurl,fit: BoxFit.cover,),
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                      ColorConstants.mainblack,
                      Colors.transparent
                    ])
                  ),
                  child:
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.newstitle,style: GoogleFonts.allan(color: Colors.white,fontSize: 45),),
                      ),
                    ))
        
                ),
               
                Positioned(
                  top: 4,
                  right: 4,
                  child:
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children:[
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: ColorConstants.BrightMagenta,
                      ) ,
                      Positioned(
                        top: 3,
                        bottom: 3,
                        left: 3,
                        right: 3,
                        child: CircleAvatar(
                        radius: 26,
                        backgroundColor: ColorConstants.mainblack,
                        child: Center(child: InkWell
                        (
                         
                          child: Icon(Icons.share,color: ColorConstants.BrightMagenta,))),
                                          ),
                      ),
                    ]
                  ),
                ))
              ],
            ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.newsdiscription,style: GoogleFonts.afacad(color: Colors.white,fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.newsauthor,style: GoogleFonts.afacad(color: Colors.white.withOpacity(0.70),fontSize: 14),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.newstime,style: GoogleFonts.afacad(color: Colors.white.withOpacity(0.70),fontSize: 12),),
                Container(
                      height: 40,
                      
                      decoration: BoxDecoration(
                        color: ColorConstants.mainblack,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1,color: ColorConstants.BrightMagenta)
                      ),
                      
                     child: Center(child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: InkWell(
                        onTap: () {
                          
                        },
                        child: Text("READ MORE ",style: GoogleFonts.alike(color: ColorConstants.BrightMagenta),)),
                     )),
                    ),
              ],
            ),
          )
          ],
        
        ),
      ),
    );
  }
} 