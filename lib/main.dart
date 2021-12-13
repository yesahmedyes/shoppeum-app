import 'package:flutter/material.dart';
import 'package:shoppeum/feedback/feedback.dart';
import 'package:shoppeum/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shoppeum/list/list_page.dart';
import 'package:shoppeum/misc/push_notifications.dart';
import 'package:shoppeum/models/categories.dart';
import 'package:shoppeum/models/featured_images.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) {
        PushNotificationsManager();
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => FeaturedImages()),
            ChangeNotifierProvider(create: (ctx) => CategoryData()),
          ],
          child: MaterialApp(
            title: 'Shoppeum',
            theme: ThemeData(
              primaryColor: Color.fromRGBO(219, 75, 85, 1),
              accentColor: Color.fromRGBO(223, 82, 91, 1),
              textSelectionHandleColor: Color.fromRGBO(223, 82, 91, 1),
            ),
            home: HomePage(),
            routes: {
              '/home': (ctx) => HomePage(),
              '/list': (ctx) => ListPage(),
              '/feedback': (ctx) => SendFeedback(),
            },
          ),
        );
      },
    );
  }
}
