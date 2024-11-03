import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:news_app_project/model/newsmodel.dart';
class SearchScreenContollertwo with ChangeNotifier{
  Newscontrollmodel? newsResModel;
    List<Article> newsarticles = [];
    bool isloading = false;
  Future<void> onsearch(String keyword) async {
    isloading = true;
    notifyListeners();
    var url = Uri.parse("https://newsapi.org/v2/everything?q=$keyword&apiKey=2afa196e3d474af1979a56fd685ac4aa");
  var Newsresponse = await http.get(url);
  if(Newsresponse.statusCode == 200){
newsResModel = newscontrollmodelFromJson(Newsresponse.body);
  }
  if(newsResModel!=null){
newsarticles = newsResModel!.articles??[];
  }
  isloading = false;
  notifyListeners();
  }
}