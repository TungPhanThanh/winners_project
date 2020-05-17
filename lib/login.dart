import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshopping/Widget/Color_Loader.dart';
import 'package:vshopping/webview.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'V',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
          children: [
            TextSpan(
              text: 'Shopping',
              style: TextStyle(color: Colors.redAccent, fontSize: 30),
            ),
          ]),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => VShopping()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            _title(),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 20,
            ),
            ColorLoader5(
              duration: Duration(seconds: 1),
            ),
          ],
        ),
      ),
    )));
  }
}
