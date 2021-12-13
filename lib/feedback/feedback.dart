import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: MyForm(),
        ),
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _messageFocus = FocusNode();

  String name, email, message;

  void _submitFeedback(ctx) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(ctx).unfocus();
      FirebaseFirestore.instance.collection("feedback").add({
        'name': name,
        'email': email,
        'message': message,
      }).then((_) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text('Feedback submitted successfully'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
            'We would love to here from you',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: _name,
            focusNode: _nameFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocus);
            },
            cursorColor: Color.fromRGBO(223, 82, 91, 1),
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromRGBO(45, 45, 45, 1),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (val) {
              name = val;
              _name.clear();
            },
            decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(145, 145, 145, 0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(145, 145, 145, 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(25, 25, 25, 0.4),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 18, bottom: 18, left: 20),
              hintStyle: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color.fromRGBO(145, 145, 145, 1),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: _email,
            focusNode: _emailFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_messageFocus);
            },
            cursorColor: Color.fromRGBO(223, 82, 91, 1),
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromRGBO(45, 45, 45, 1),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter an email';
              }
              if (!val.contains("@")) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
              _email.clear();
            },
            decoration: InputDecoration(
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(145, 145, 145, 0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(145, 145, 145, 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(25, 25, 25, 0.4),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 18, bottom: 18, left: 20),
              hintStyle: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color.fromRGBO(145, 145, 145, 1),
              ),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            minLines: 5,
            maxLines: 10,
            controller: _message,
            focusNode: _messageFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            cursorColor: Color.fromRGBO(223, 82, 91, 1),
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color.fromRGBO(45, 45, 45, 1),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
            onSaved: (val) {
              message = val;
              _message.clear();
            },
            decoration: InputDecoration(
              hintText: 'Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(145, 145, 145, 0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(145, 145, 145, 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Color.fromRGBO(25, 25, 25, 0.4),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 18, bottom: 18, left: 20),
              hintStyle: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color.fromRGBO(145, 145, 145, 1),
              ),
            ),
          ),
          SizedBox(height: 22),
          RaisedButton(
            child: Text('Submit'),
            color: Color.fromRGBO(219, 75, 85, 1),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            onPressed: () => _submitFeedback(context),
          )
        ],
      ),
    );
  }
}
