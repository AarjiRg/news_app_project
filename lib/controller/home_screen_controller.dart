import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:news_app_project/model/newsmodel.dart';

class HomeScreenController with ChangeNotifier{
  Newscontrollmodel ? newsresponse;
  List<Source> catergory =[];
List<Article> newsmodel = [];
bool isloading = true;
  Future<void> fetchNews() async {
    isloading = false;
    notifyListeners();
    try {
    
      notifyListeners();
  var url = Uri.parse("https://newsapi.org/v2/everything?q=keyword&apiKey=2afa196e3d474af1979a56fd685ac4aa");
  var response =await http.get(url);
 if(response.statusCode == 200){
 newsresponse = newscontrollmodelFromJson(response.body);
 if(newsresponse!=null){
    newsmodel = newsresponse!.articles ?? [];
 }
 }
    } catch (e) {
      print(e);
    }
   notifyListeners();
  }


}