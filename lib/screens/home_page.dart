import 'dart:ui';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_webview/models/news_card_model.dart';
import 'package:news_app_webview/screens/views/category_card_tile.dart';
import 'package:news_app_webview/screens/views/news_card_tile.dart';
import 'package:news_app_webview/services/category_list.dart';
import 'package:news_app_webview/services/network.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsCardModel> newsCardModel = new List<NewsCardModel>();
  CategoryList categoryList = new CategoryList();
  bool isLoading = true;
  String categoryName;
  String defaultCategory = 'entertainment';
  String defaultHeader = 'entertainment';

  List<String> categories = [
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  void initState() {
    super.initState();
    updateUIData(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ));
            },
            icon: Icon(
              Icons.favorite_border,
              size: 25,
            ),
          ),
        ],
        title: Text(
          'The News',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          //search button
          Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 18.0, top: 12.0, bottom: 5),
            child: Ink(
              child: DropdownSearch<String>(
                validator: (v) => v == null ? "required field" : null,
                mode: Mode.MENU,
                items: categories,
                label: "search categories *",
                showClearButton: false,
                onChanged: (String value) {
                  updateUIData(value);
                  setState(() {
                    defaultHeader = value;
                  });
                },
              ),
            ),
          ),
          //header with RichText Widget
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
                  children: [
                    TextSpan(
                        text: defaultHeader.toUpperCase(),
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.blue)),
                    TextSpan(
                        text: ' HEADLINES',
                        style: TextStyle(fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
            ),
          ),
          //categories Tab here
/*
          CategoryBar(
            categoryList: categoryList,
          ),
*/
          //ListView of categories
          Expanded(
            child: SingleChildScrollView(
              child: isLoading
                  ? LinearProgressIndicator()
                  : NewsCardTile(newsCardModel: newsCardModel),
            ),
          ),
        ],
      ),
    );
  }

  getData(String defaultCategory) async {
    NetworkService nS = new NetworkService();
    await nS.getData(category: defaultCategory);
    setState(() {
      newsCardModel = nS.newsCardList;
      isLoading = false;
    });
  }

  updateUIData(String category) {
    if (category != null) {
      setState(() {
        getData(category);
        print(category);
        return newsCardModel;
      });
    } else {
      return getData(defaultCategory);
    }
  }
}
