import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_webview/services/category_list.dart';
import 'package:news_app_webview/screens/home_page.dart';

class CategoryBar extends StatelessWidget {
  CategoryBar({this.categoryList, this.changeCategory});

  final CategoryList categoryList;
  Future<dynamic> changeCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.categoryModel.length,
        itemBuilder: (context, int i) {
          return Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Ink(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.multiply),
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${categoryList.categoryModel[i].imgUrl}'),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${categoryList.categoryModel[i].categoryName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  getCategoryName(String category, int i) {
    category = categoryList.categoryModel[i].categoryName.toLowerCase();
    print(category);
    return category;
  }
}
