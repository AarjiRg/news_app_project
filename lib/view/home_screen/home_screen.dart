import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/controller/home_screen_controller.dart';
import 'package:news_app_project/controller/news_category_controller.dart';
import 'package:news_app_project/utils/color_constants.dart';
import 'package:news_app_project/view/latestNews_screen/latest_news_screen.dart';
import 'package:news_app_project/view/notification_sceen/notification_screen.dart';
import 'package:news_app_project/view/single_news_screen/single_news_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String catergoryname = "all";
  List<String> catergory=[
    "all",
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",];
    
      get index => catergory;
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().fetchNews();
      await context.read<SearchScreenContoller>().fetchcategory(catergoryname);
      WidgetsBinding.instance.addPostFrameCallback((_) {
      int selectedIndex = catergory.indexOf(catergoryname);
      _scrollToSelectedCategory(selectedIndex);
    });
    });
    super.initState();
  }
   ScrollController _scrollController = ScrollController();
   void _scrollToSelectedCategory(int index) {
    double itemWidth = 100.0;
    double scrollPosition = index * (itemWidth + 20); 
    _scrollController.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
   final searchprovider = context.watch<SearchScreenContoller>();
    final providerobj = context.watch<HomeScreenController>();
    
    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      appBar: AppBar(
        backgroundColor: ColorConstants.mainblack,
        centerTitle: true,
        title: Text("InstaNews", style: GoogleFonts.aladin(color: Colors.white)),
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
            },
            child: Icon(Icons.notifications_outlined, color: Colors.white)),
          SizedBox(width: 20),
        ],
      ),
      body: 
          SingleChildScrollView(
              child: Expanded(
                child: Builder( 
                  builder: (context) {
                    if(searchprovider.isloading == true){
                return Center(child: CircularProgressIndicator(
                  color: ColorConstants.BrightMagenta,
                ));
                    }
                    return Column(
                      children: [
                        Divider(
                          color: Colors.grey.withOpacity(.20),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Builder(
                              builder: (context) {
                                
                                return ListView.separated(
                                  controller: _scrollController, 
                                 
                
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      InkWell(
                                      onTap: () {
                                        catergoryname = catergory[index];
                                        context.read<SearchScreenContoller>().fetchcategory(catergoryname);
                                         _scrollToSelectedCategory(index);
                                         setState(() {
                                           
                                         });
                                      },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                             color: catergoryname == catergory[index] ? ColorConstants.BrightMagenta : ColorConstants.mainblack,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: catergoryname == catergory[index]?Colors.transparent : ColorConstants.BrightMagenta.withOpacity(.40)
                                            )
                                          ),
                                         
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                            catergory[index].toString(),
                                              style: GoogleFonts.adamina(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(width: 20),
                                  itemCount:catergory.length,
                                );
                              }
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: searchprovider.newsarticles.map((article) {
                            return Builder(
                              builder: (BuildContext context) {
                                
                                return InkWell(
                                  onTap: () {
                                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleNewsScreen(
                            imgurl: article.urlToImage!,
                            newstitle: article.title!,
                            newsauthor: article.author!,
                            newsurl: article.url!,
                            newsdiscription: article.description!,
                            newstime: article.publishedAt.toString(),
                          ),
                        ),
                      );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(article.urlToImage.toString()), 
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          article.title ?? 'No Title',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            backgroundColor: Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest News",
                                style: GoogleFonts.adamina(color: Colors.white, fontSize: 30),
                              ),
                              InkWell(
                                   onTap: () {
                                    
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LatestNewsScreen(),));
                                      },
                                child: Text(
                                  "See more",
                                  style: GoogleFonts.zeyada(color: ColorConstants.BrightMagenta, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 20,),
                        Builder(
                          builder: (context ) {
                            if(searchprovider.isloading == true){
                    return CircularProgressIndicator();
                            }
                            return ListView.separated(
                              shrinkWrap: true, 
                              physics: NeverScrollableScrollPhysics(), 
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  
                                   Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleNewsScreen(
                             imgurl: searchprovider.newsarticles[index].urlToImage!,
                            newstitle: searchprovider.newsarticles[index].title!,
        newsauthor: searchprovider.newsarticles[index].author!,
        newsurl: searchprovider.newsarticles[index].url!,
        newsdiscription: searchprovider.newsarticles[index].description!,
        newstime: searchprovider.newsarticles[index].publishedAt.toString(),
                          ),
                        ),
                      );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                    
                                      width: double.infinity,
                                      color: Colors.grey.withOpacity(0.10),
                                      child: Row(
                                        
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                            height: 200,
                                            width: 200,
                                            
                                            decoration: BoxDecoration( 
                                              image: DecorationImage(image: NetworkImage(searchprovider.newsarticles[index].urlToImage.toString()),fit: BoxFit.cover),
                                            
                                            ),
                                            ),
                                          ),
                                         Expanded( 
                                           child: Align(
                                            alignment: Alignment.topCenter,
                                             child: Column(
                                               children: [
                                                 Text(
                                                  searchprovider.newsarticles[index].title.toString(),
                                                   softWrap: true, 
                                                   overflow: TextOverflow.visible, 
                                                   style: GoogleFonts.alfaSlabOne(
                                      color: Colors.white,
                                    ),
                                                 ),
                                                 Text(
                                                  searchprovider.newsarticles[index].description.toString(),
                                                   softWrap: true, 
                                                   overflow: TextOverflow.visible, 
                                                   style: TextStyle(
                                                     fontSize: 16.0,
                                                     color: Colors.white
                                                   ), 
                                                 ),
                                               ],
                                             ),
                                           ),
                                         )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: 20,
                            );
                          }
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
    );
  }
}
