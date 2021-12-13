import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FImageWidget extends StatefulWidget {
  final List _images;

  FImageWidget(this._images);

  @override
  _FImageWidgetState createState() => _FImageWidgetState();
}

class _FImageWidgetState extends State<FImageWidget> {
  final PageController controller = PageController();
  double currentPage = 0.0;
  int n;
  bool isSet = false;

  void _changePage() {
    setState(() {
      currentPage = controller.page;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_changePage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    n = this.widget._images.length;
    if (n != null && isSet == false) {
      Timer.periodic(new Duration(seconds: 4), (time) {
        if (controller.hasClients) {
          controller.animateToPage((currentPage.toInt() + 1) % n, duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
      });
      isSet = true;
    }
  }

  @override
  void dispose() {
    controller.removeListener(_changePage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: (MediaQuery.of(context).size.width - 32) * 0.379,
              child: PageView(
                controller: controller,
                children: this
                    .widget
                    ._images
                    .map(
                      (img) => Image(
                        image: CachedNetworkImageProvider(img.image),
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < this.widget._images.length; i++)
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  height: 5,
                  width: i == currentPage.toInt() ? 11 : 5.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: i == currentPage.toInt() ? Color.fromRGBO(130, 130, 130, 1) : Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                onTap: () {
                  controller.animateToPage(i, duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
              ),
          ],
        )
      ],
    );
  }
}
