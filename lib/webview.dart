import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vshopping/navigation.dart';

import 'Prefs/preference.dart';

class VShopping extends StatefulWidget {
  @override
  _VShoppingState createState() => new _VShoppingState();
}

class _VShoppingState extends State<VShopping> {
  var _count = 1;
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      tittle: 'VShopping',
      desc: 'Do you want to exit',
      btnCancelOnPress: () {},
      btnOkOnPress: () => exit(0),
    ).show();
  }

//  title: new Text('VShopping'),
//  content: new Text('Do you want to exit '),
//  actions: <Widget>[
//  new InkWell(
//  onTap: () => Navigator.of(context).pop(false),
//  child: Text("NO"),
//  ),
//  SizedBox(height: 50),
//  new InkWell(
//  onTap: () => Navigator.of(context).pop(true),
//  child: Text("YES"),
//  ),
//  ],

  void _autoLogin(
      InAppWebViewController controller, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('ID') ?? "";
    String password = prefs.getString("PASSWORD") ?? "";
    print("ID/PW: " + id + "/" + password);
    if (_count == 1) {
      await controller.evaluateJavascript(
          source: """javascript:if (document.URL.includes(\"login.php\")) {
        var selectElementName = document.querySelector('#login_id');
            if(selectElementName){
               selectElementName.value =  \"""" +
              id +
              """\";}
        var selectElementpassword = document.querySelector('#login_pw');
            if(selectElementpassword){
               selectElementpassword.value =  \"""" +
              password +
              """\";}
        var selectElementbutton = document.querySelector('#btnLogin');
            if(selectElementbutton){selectElementbutton.click();}
        }""");
      _count++;
    } else {
      await controller.evaluateJavascript(
          source: """javascript:if (document.URL.includes(\"login.php\")) {
        var selectElementName = document.querySelector('#login_id');
            if(selectElementName){
               selectElementName.value =  \"""" +
              id +
              """\";}
        var selectElementpassword = document.querySelector('#login_pw');
            if(selectElementpassword){
               selectElementpassword.value =  \"""" +
              password +
              """\";}}""");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: MaterialApp(
          home: SafeArea(child: Scaffold(
//            appBar: AppBar(
//              title: const Text('Winners200513-02'),
//              actions: <Widget>[SampleMenu(webView)],
//              backgroundColor: Colors.red,
//            ),
            body: Container(
                child: Column(children: <Widget>[
                  Container(
                      child: progress < 1.0
                          ? LinearProgressIndicator(
                        value: progress,
                      )
                          : Container()),
                  Expanded(
                    child: Container(
                      child: InAppWebView(
                        initialUrl: "https://viet-winners.daboryhost.com/",
                        initialHeaders: {},
                        initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                            builtInZoomControls: true,
                          ),
                          ios: IOSInAppWebViewOptions(),
                          crossPlatform: InAppWebViewOptions(
                            userAgent: "Mozilla/5.0 (Linux; Android 5.1.1; Nexus 5 Build/LMY48B; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.65 Mobile Safari/537.36",
                            disableHorizontalScroll: false,
                            debuggingEnabled: true,
                            cacheEnabled: true,
                            clearCache: true,
                            javaScriptEnabled: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                          ),
                        ),
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart:
                            (InAppWebViewController controller, String url) {
                          String stringValue;
                          Prefs.id.then((value) => {
                            setState(() {
                              stringValue = value;
                              print("ID : " + stringValue);
                              this.url = url;
                              print('Page started loading: $url');
                              print('Page started friendlychat');
                            })
                          });
                        },
                        onLoadStop:
                            (InAppWebViewController controller, String url) async {
                          setState(() {
                            _autoLogin(controller, context);
                            this.url = url;
                            print('Page finished loading: $url');
                            print('count login page:  $_count');
                          });
                        },
                        onProgressChanged:
                            (InAppWebViewController controller, int progress) {
                          setState(() {
                            this.progress = progress / 100;
                          });
                        },
                      ),
                    ),
                  ),
//              Container(
//                color: Colors.red,
//                height: 50.0,
//                child: ButtonBar(
//                  alignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    IconButton(
//                      icon: const Icon(Icons.arrow_back_ios),
//                      color: Colors.white,
//                      onPressed: () {
//                        if (webView != null) {
//                          webView.goBack();
//                        }
//                      },
//                    ),
//                    IconButton(
//                      icon: const Icon(Icons.arrow_forward_ios),
//                      color: Colors.white,
//                      onPressed: () {
//                        if (webView != null) {
//                          webView.goForward();
//                        }
//                      },
//                    ),
//                    IconButton(
//                      icon: const Icon(Icons.replay),
//                      color: Colors.white,
//                      onPressed: () {
//                        if (webView != null) {
//                          webView.reload();
//                        }
//                      },
//                    ),
//                  ],
//                ),
//              ),
                ])),
          ),)
        ));
  }
}
