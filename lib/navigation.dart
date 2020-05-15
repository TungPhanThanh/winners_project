import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller);

  final InAppWebViewController controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.showUserAgent:
            _onShowHomePage(controller, context);
            break;
          case MenuOptions.listCookies:
            _onListCookies(controller, context);
            break;
          case MenuOptions.clearCookies:
            _onClearCookies(context);
            break;
          case MenuOptions.addToCache:
            _onAddToCache(controller, context);
            break;
          case MenuOptions.listCache:
            _onListCache(controller, context);
            break;
          case MenuOptions.clearCache:
            _onClearCache(controller, context);
            break;
          case MenuOptions.navigationDelegate:
//            _onChangeIdPassword(controller, context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.showUserAgent,
          child: const Text('VShopping Home Page'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCookies,
          child: Text('List cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.addToCache,
          child: Text('Add to cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.listCache,
          child: Text('List cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCache,
          child: Text('Clear cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.navigationDelegate,
          child: Text('Navigation Delegate'),
        ),
      ],
    );
  }

  void _onShowHomePage(
      InAppWebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    await controller.loadUrl(url: "https://viet-winners.daboryhost.com/");
  }

  void _onListCookies(
      InAppWebViewController controller, BuildContext context) async {
    final String cookies =
        await controller.evaluateJavascript(source: """document.cookie""");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  void _onAddToCache(
      InAppWebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        source:
        """caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";""");
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  void _onListCache(
      InAppWebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        source: """caches.keys()
            .then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))
            .then((caches) => alert('caches'))""");
  }

  void _onClearCache(
      InAppWebViewController controller, BuildContext context) async {
    await controller.clearCache();
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text("Cache cleared."),
    ));
  }

  void _onClearCookies(BuildContext context) async {
    final String hadCookies = cookieManager.toString();
    cookieManager.deleteAllCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (hadCookies == null) {
      message = 'There are no cookies.';
    }
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }
}
