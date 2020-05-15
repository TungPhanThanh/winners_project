import 'package:flutter/material.dart';
import 'package:vshopping/Prefs/preference.dart';
import 'package:vshopping/login.dart';
import 'package:vshopping/screen/splash.dart';
import 'package:vshopping/webview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
//
//StreamBuilder(
//builder: (context, snapshot) {
//String stringValue;
//Prefs.id.then((value) => {
//stringValue = value,
//print("ID at start: " + stringValue),
//if (stringValue.length > 0) {
//snapshot.hasData == true,
//}else{
//snapshot.hasData == false,
//}
//});
//if (snapshot.hasData) {
//return VShopping();
//} else {
//return Login();
//}
//},
//),
