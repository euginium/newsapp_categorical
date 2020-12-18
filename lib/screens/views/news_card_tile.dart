import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_webview/models/news_card_model.dart';
import 'package:news_app_webview/models/saved_news_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app_webview/screens/favorite_page.dart';

class NewsCardTile extends StatefulWidget {
  NewsCardTile({this.newsCardModel});

  final List<NewsCardModel> newsCardModel;
  final saved = Set<NewsCardModel>();

  @override
  _NewsCardTileState createState() => _NewsCardTileState();
}

class _NewsCardTileState extends State<NewsCardTile> {
  Widget _buildRow(NewsCardModel nCM) {
    final alreadySaved = widget.saved.contains(nCM);
    return GestureDetector(
      child: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        size: 15,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            widget.saved.remove(nCM);
          } else {
            widget.saved.add(nCM);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.newsCardModel.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, int i) {
        return InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            var url = widget.newsCardModel[i].url;
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
                                "${widget.newsCardModel[i].imgUrl}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // article title
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${widget.newsCardModel[i].title}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                      ),
                      //article description
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${widget.newsCardModel[i].desc}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //favorite icon holder
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Ink(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.0, bottom: 12),
                        child: _buildRow(widget.newsCardModel[i]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
