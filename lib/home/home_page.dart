import 'package:flutter/material.dart';
import 'package:shoppeum/home/categories_widget.dart';
import 'package:shoppeum/home/fimage_widget.dart';
import 'package:shoppeum/home/home_drawer.dart';
import 'package:shoppeum/home/search_widget.dart';
import 'package:shoppeum/models/featured_images.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'shoppeum',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Jellee', fontSize: 20, letterSpacing: 0.5),
        ),
        centerTitle: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/menu.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SearchBar()),
            FutureBuilder(
              future: Provider.of<FeaturedImages>(context, listen: false).fetchAndSetImages(),
              builder: (ctx, future) {
                if (future.connectionState != ConnectionState.done) {
                  return SizedBox(height: 10);
                }
                final _images = Provider.of<FeaturedImages>(context).items;
                return FImageWidget(_images);
              },
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text(
                'Categories',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Color.fromRGBO(60, 60, 60, 1),
                ),
              ),
            ),
            CategoriesWidget(),
          ],
        ),
      ),
      drawer: HomeDrawer(),
      drawerEdgeDragWidth: 30,
    );
  }
}
