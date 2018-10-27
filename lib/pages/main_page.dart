import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:cv/localizations/localization.dart';
import 'package:cv/pages/account_page.dart';
import 'package:cv/pages/home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const _TAB_HOME_INDEX = 0;
  static const _TAB_ACCOUNT_INDEX = 2;

  int currentIndex = 0;

  void _selectTab(int index) {
    if (index == _TAB_HOME_INDEX || index == _TAB_ACCOUNT_INDEX) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).appName),
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.search),
        label: Text(Localization.of(context).search),
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Colors.white,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: currentIndex != _TAB_HOME_INDEX,
            child: TickerMode(
              enabled: currentIndex == _TAB_HOME_INDEX,
              child: HomePage(),
            ),
          ),
          Offstage(
            offstage: currentIndex != _TAB_ACCOUNT_INDEX,
            child: TickerMode(
              enabled: currentIndex == _TAB_ACCOUNT_INDEX,
              child: AccountPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Theme.of(context).primaryColor,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(color: Colors.white70),
            ),
      ), // sets the inactive color of the `BottomNavigationBar`
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _selectTab,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            title: Text(Localization.of(context).home),
          ),
          const BottomNavigationBarItem(
            // Fake item
            icon: SizedBox(),
            title: SizedBox(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            activeIcon: Icon(Icons.account_circle),
            title: Text(Localization.of(context).account),
          ),
        ],
      ),
    );
  }
}
