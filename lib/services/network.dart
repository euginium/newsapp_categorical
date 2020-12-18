import 'dart:convert';
import 'package:news_app_webview/models/news_card_model.dart';
import 'package:http/http.dart' as http;

const String api_key = 'ba19e35d38f748eaa503a57ab37b1b72';

class NetworkService {
  List<NewsCardModel> newsCardList = [];

  Future getData({String category}) async {
    try {
      http.Response response = await http.get(
          'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=${api_key}');
      var results = response.body;
      var decode = jsonDecode(results);
      for (var element in decode['articles']) {
        NewsCardModel ncm = new NewsCardModel(
          title: element['title'],
          imgUrl: element['urlToImage'],
          desc: element['description'],
          url: element['url'],
          sourceName: element['source']['name'],
        );
        newsCardList.add(ncm);
      }
    } catch (e) {
      print(e);
    }
  }
}
