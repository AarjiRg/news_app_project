import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/controller/search_screen_controller/search_screen_controlller.dart';
import 'package:news_app_project/utils/color_constants.dart';
import 'package:news_app_project/view/single_news_screen/single_news_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchprovider = context.watch<SearchScreenContollertwo>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainblack,
        appBar: AppBar(
          backgroundColor: ColorConstants.mainblack,
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SearchBar(
                  side: MaterialStatePropertyAll(BorderSide(
                      color: ColorConstants.BrightMagenta.withOpacity(0.70))),
                  textStyle: MaterialStatePropertyAll(
                      const TextStyle(color: Colors.white)),
                  backgroundColor: MaterialStatePropertyAll(
                      Colors.grey.withOpacity(0.10)),
                  hintStyle: MaterialStatePropertyAll(TextStyle(
                      color: Colors.white.withOpacity(0.20))),
                  hintText: "Search news...",
                  controller: controller,
                  leading: IconButton(
                    onPressed: () {
                    
                      context.read<SearchScreenContollertwo>().onsearch(controller.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: ColorConstants.BrightMagenta,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: searchprovider.isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.BrightMagenta,
                  ),
                )
              : searchprovider.newsarticles.isEmpty
                  ? Center(
                      child: Text(
                        "Find News",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.BrightMagenta,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: searchprovider.newsarticles.length,
                      itemBuilder: (context, index) {
                        final article = searchprovider.newsarticles[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 200,
                                    width: 200,
                                    child: article.urlToImage != null
                                        ? Image.network(
                                            article.urlToImage!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              );
                                            },
                                          )
                                        : const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title ?? "No Title",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aladin(
                                              color: Colors.white, fontSize: 15),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          article.description ?? "No Description",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: GoogleFonts.aladin(
                                              color: Colors.white, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.withOpacity(.45),
                      ),
                    ),
        ),
      ),
    );
  }
}
