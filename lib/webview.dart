import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Prefs/preference.dart';

class VShopping extends StatefulWidget {
  @override
  _VShoppingState createState() => new _VShoppingState();
}

class _VShoppingState extends State<VShopping> {
  var _count = 1;
  CookieManager _cookieManager = CookieManager.instance();
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

  Future<bool> _onBackPressed() async {
    if (webView != null) {
      if (await webView.canGoBack()) {
        // get the webview history
        WebHistory webHistory = await webView.getCopyBackForwardList();
        // if webHistory.currentIndex corresponds to 1 or 0
            if (webHistory.currentIndex < 1) {
              // then it means that we are on the first page
              // so we can exit
            return AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              tittle: 'VShopping',
              desc: 'Do you want to exit',
              btnCancelOnPress: () {},
              btnOkOnPress: () => exit(0),
            ).show();
            }else{
              webView.goBack();
              return false;
            }
        }
      }
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
                            domStorageEnabled: true,
                            databaseEnabled: true,
                          ),
                          ios: IOSInAppWebViewOptions(),
                          crossPlatform: InAppWebViewOptions(
                            useShouldOverrideUrlLoading: true,
                            horizontalScrollBarEnabled: true,
                            verticalScrollBarEnabled: true,
                            disableHorizontalScroll: false,
                            debuggingEnabled: true,
                            cacheEnabled: true,
                            clearCache: true,
                            javaScriptEnabled: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                          ),
                        ),
                        shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) {
                          if(Uri.parse(url).host == "www.facebook.com"){
                            return controller.loadUrl(url: url);
                          } return controller.goBack();
                        },
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart: (InAppWebViewController controller, String url) {

                        },
                        onLoadStop: (InAppWebViewController controller, String url) async {
                          this.url = url;
                          if(url.contains("tel:")) {
                            _launchURL(url);
                          }
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
