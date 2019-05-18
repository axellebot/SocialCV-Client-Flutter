import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/src/ui/commons/tags.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/pages/account_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/home_page.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/menu_button_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String _tag = '$_MainPageState';
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return Scaffold(
      appBar: AppBar(
        title: Text(CVLocalizations.of(context).appName),
        centerTitle: true,
        actions: [
          MenuButton(),
        ],
      ),
      body: _children.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: kHeroSearchFAB,
        icon: Icon(Icons.search),
        label: Text(CVLocalizations.of(context).search),
        foregroundColor: Colors.white,
        onPressed: () => navigateToSearch(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          ///sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,

          ///sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).selectedRowColor,
          textTheme: Theme.of(context).primaryTextTheme,
        ),

        ///sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.homeOutline),
              activeIcon: Icon(MdiIcons.home),
              title: Text(CVLocalizations.of(context).homeCTA),
            ),
            const BottomNavigationBarItem(
              ///Fake item
              icon: SizedBox(),
              title: SizedBox(),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountOutline),
              activeIcon: Icon(MdiIcons.account),
              title: Text(CVLocalizations.of(context).accountCTA),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
