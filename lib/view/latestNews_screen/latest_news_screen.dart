import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/controller/news_category_controller.dart';
import 'package:news_app_project/utils/color_constants.dart';
import 'package:news_app_project/view/single_news_screen/single_news_screen.dart';
import 'package:provider/provider.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  String catergoryname = "everything";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchScreenContoller>().fetchcategory(catergoryname);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchprovider = context.watch<SearchScreenContoller>();

    return Scaffold(
      backgroundColor: ColorConstants.mainblack,
      appBar: AppBar(
        backgroundColor: ColorConstants.mainblack,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Latest News",
          style: GoogleFonts.aladin(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (searchprovider.isloading == true) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorConstants.BrightMagenta,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                itemCount: searchprovider.newsarticles.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white.withOpacity(0.35),
                ),
                itemBuilder: (context, index) {
                  final article = searchprovider.newsarticles[index];

               
                  if (article.urlToImage == null) {
                    return SizedBox();
                  }

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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            child: Image.network(
                              article.urlToImage.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.alfaSlabOne(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    article.description.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    article.publishedAt.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white.withOpacity(0.50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
