import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppeum/models/categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';

class CategoryStores extends StatelessWidget {
  final cat;

  CategoryStores(this.cat);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CategoryData>(context, listen: false).getData(cat),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final List<Store> _data = snapshot.data;
        if (_data == null || _data.length == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'We are sorry, we dont have stores for this yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'But worry not, we are adding more stores daily.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(135, 135, 135, 1),
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
          children: _data.map((elem) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                height: 230,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image(
                            image: CachedNetworkImageProvider(elem.background),
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 70,
                                    width: 160,
                                    color: Colors.white,
                                    child: Image(image: CachedNetworkImageProvider(elem.logo)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                width: double.infinity,
                                height: 60,
                                color: Color.fromRGBO(255, 255, 255, 0.95),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      elem.offer,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color.fromRGBO(35, 35, 35, 1),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      elem.title.length > 30 ? elem.title.substring(0, 30) : elem.title,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color.fromRGBO(130, 130, 130, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Color.fromRGBO(223, 82, 91, 1), Color.fromRGBO(223, 82, 91, 1), Colors.white, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.30, 0.30, 1],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 33),
                          Container(
                            height: 70,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Color.fromRGBO(90, 90, 90, 0.4), blurRadius: 1.0, spreadRadius: 0, offset: Offset(0, 1.5)),
                              ],
                              color: Colors.white,
                            ),
                            child: Image(
                              image: CachedNetworkImageProvider(elem.logo),
                              width: 100,
                            ),
                          ),
                          SizedBox(height: 11),
                          Text(
                            elem.name,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            elem.offer,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              FlutterClipboard.copy(elem.code).then((value) {
                                Navigator.of(ctx).pop();
                                final snackBar = SnackBar(content: Text('Discount code copied to clipboard.'), duration: Duration(seconds: 2));
                                Scaffold.of(context).showSnackBar(snackBar);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                              decoration: BoxDecoration(color: Color.fromRGBO(208, 208, 208, 0.23), borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    elem.code,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Color.fromRGBO(55, 55, 55, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Icon(Icons.copy, size: 22),
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
          }).toList(),
        );
      },
    );
  }
}
