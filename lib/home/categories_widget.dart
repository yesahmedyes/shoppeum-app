import 'package:flutter/material.dart';
import 'package:shoppeum/widgets/category_stores.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  List<String> _categories = ["Popular", "Home & Furniture", "Groceries", "Health & Beauty", "Fashion", "Electronics"];
  String active = "Popular";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _categories.map((cat) {
                return active == cat
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(219, 75, 85, 0.055)),
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(219, 75, 85, 0.05),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: Color.fromRGBO(208, 54, 65, 1),
                            letterSpacing: 0.9,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : FlatButton(
                        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: Color.fromRGBO(110, 110, 110, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            active = cat;
                          });
                        },
                      );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 4),
        CategoryStores(active),
        SizedBox(height: 16),
      ],
    );
  }
}
