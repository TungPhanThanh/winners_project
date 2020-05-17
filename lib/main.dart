import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
