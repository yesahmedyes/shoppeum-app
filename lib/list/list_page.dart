import 'package:flutter/material.dart';
import 'package:shoppeum/widgets/category_stores.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isSearchSelected = false;
  FocusNode _focus = new FocusNode();
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        isSearchSelected = true;
      });
    } else {
      setState(() {
        isSearchSelected = false;
      });
    }
  }

  void _onSearchSubmitted(String val) {
    setState(() {
      _controller.text = val;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSearchSelected ? Color.fromRGBO(25, 25, 25, 0.4) : Color.fromRGBO(145, 145, 145, 0.4),
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focus,
                  cursorColor: Color.fromRGBO(223, 82, 91, 1),
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(45, 45, 45, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none),
                  decoration: InputDecoration(
                    focusColor: Colors.red,
                    icon: SizedBox(
                      width: 28,
                      height: 25,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 25,
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: Color.fromRGBO(165, 165, 165, 1),
                        ),
                        onPressed: () {
                          return _onSearchSubmitted(_controller.text);
                        },
                      ),
                    ),
                    hintText: 'Search for anything...',
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(145, 145, 145, 1),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onSubmitted: (val) => _onSearchSubmitted(val),
                ),
              ),
            ),
            CategoryStores(_controller.text),
          ],
        ),
      ),
    );
  }
}
