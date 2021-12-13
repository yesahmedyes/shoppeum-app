import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FImage {
  final String link;
  final String image;

  FImage({this.link, this.image});
}

class FeaturedImages with ChangeNotifier {
  List<FImage> _images = [];

  bool get isImages {
    return _images.isNotEmpty;
  }

  List<FImage> get items {
    return [..._images];
  }

  Future<void> fetchAndSetImages() async {
    try {
      final fImages = await FirebaseFirestore.instance.collection('featured_images').get();
      _images = [];
      fImages.docs.forEach((elem) {
        _images.insert(0, FImage(image: elem.data()['imageUrl']));
      });
    } catch (error) {
      print(error);
    }
  }
}
