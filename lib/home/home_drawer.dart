import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 75),
                Text(
                  'Welcome to Shoppeum',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'We are adding new and cool features very soon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(100, 100, 100, 1), fontFamily: 'Roboto'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Color.fromRGBO(200, 200, 200, 1)),
                FlatButton.icon(
                  padding: EdgeInsets.only(top: 16, left: 12, bottom: 12, right: 100),
                  icon: Icon(
                    Icons.share_outlined,
                    color: Color.fromRGBO(175, 175, 175, 1),
                  ),
                  label: Text(
                    '   Tell a Friend',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                  ),
                  onPressed: () {
                    Share.share(
                      "Did you know that there is an app called Shoppeum via which you get access to exclusive discount codes for the best online stores? Check it out here: ",
                    );
                  },
                ),
                FlatButton.icon(
                  padding: EdgeInsets.only(top: 8, left: 12, bottom: 20, right: 50),
                  icon: Icon(
                    Icons.help_outline,
                    color: Color.fromRGBO(175, 175, 175, 1),
                  ),
                  label: Text(
                    '   Help and Feedback',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color.fromRGBO(65, 65, 65, 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/feedback');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
