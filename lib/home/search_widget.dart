import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isSearchSelected = false;
  FocusNode _focus = new FocusNode();
  final _controller = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
          decoration: TextDecoration.none,
        ),
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
                Navigator.of(context).pushNamed('/list', arguments: _controller);
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
        onSubmitted: (_) {
          Navigator.of(context).pushNamed('/list', arguments: _controller);
        },
      ),
    );
  }
}
