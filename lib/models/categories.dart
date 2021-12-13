import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String background;
  final String logo;
  final String name;
  final String link;
  final String title;
  final String offer;
  final String code;

  Store({this.name, this.title, this.logo, this.background, this.link, this.offer, this.code});
}

class CategoryData with ChangeNotifier {
  Map<String, List<Store>> _data = {};

  Future<List<Store>> getData(String query) async {
    query = query.toLowerCase().trim();
    print(query);
    if (_data.keys.contains(query) && _data[query].isNotEmpty) {
      return _data[query];
    }
    List<Store> returned = [];
    try {
      final stores = await FirebaseFirestore.instance.collection('stores').where('query', arrayContains: query).get();
      stores.docs.forEach((elem) {
        print(elem.data());
        returned.insert(
          0,
          Store(
              name: elem.data()['name'],
              title: elem.data()['title'],
              logo: elem.data()['logo'],
              background: elem.data()['background'],
              link: elem.data()['link'],
              offer: elem.data()['offer'],
              code: elem.data()['code']),
        );
      });
    } catch (err) {
      print(err);
    }
    _data[query] = returned;
    return returned;
  }
}
