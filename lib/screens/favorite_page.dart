import 'package:flutter/material.dart';
import 'package:news_app_webview/models/news_card_model.dart';
import 'package:news_app_webview/models/saved_news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatelessWidget {
  List<NewsCardModel> savedNewsCards = [
    NewsCardModel(title: '1', desc: '2', imgUrl: '3', url: '4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Articles'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // here is a builder that shows the savedNewsCards list
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: savedNewsCards.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, int i) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    var url = savedNewsCards[i].url;
                    launchUrl(url);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //news card holder
                      Padding(
                        padding: EdgeInsets.only(left: 12, right: 12, top: 20),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            color: Colors.grey.shade800,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //image holder
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${savedNewsCards[i].imgUrl}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // article title
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '${savedNewsCards[i].title}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              //article description
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '${savedNewsCards[i].desc}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Couldn not open $url';
    }
  }
}
