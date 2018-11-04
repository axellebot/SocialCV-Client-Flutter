import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/main_bloc.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/pages/account_page.dart';
import 'package:cv/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building MainPage');
    return Scaffold(
      appBar: _buildAppBar(context, true),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.search),
        label: Text(Localization.of(context).search),
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Colors.white,
        onPressed: () => _fabPressed(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    return StreamBuilder<TabType>(
      stream: _mainBloc.tabStream,
      builder: (BuildContext context, AsyncSnapshot<TabType> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Stack(
              children: <Widget>[
                Offstage(
                  offstage: snapshot.data != TabType.HOME_TAB,
                  child: HomePage(),
                ),
                Offstage(
                  offstage: snapshot.data != TabType.ACCOUNT_TAB,
                  child: AccountPage(),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Theme.of(context).primaryColor,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(color: Colors.white),
            ),
      ), // sets the inactive color of the `BottomNavigationBar`
      child: StreamBuilder(
        stream: _mainBloc.tabStream,
        builder: (BuildContext context, AsyncSnapshot<TabType> snapshot) {
          var index = 0;
          if (snapshot.hasData) {
            if (snapshot.data == TabType.HOME_TAB) index = 0;
            if (snapshot.data == TabType.ACCOUNT_TAB) index = 2;
          }
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (index) {
              if (index == 0) {
                _mainBloc.changeTab(TabType.HOME_TAB);
              } else if (index == 2) {
                _mainBloc.changeTab(TabType.ACCOUNT_TAB);
              }
            },
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.homeOutline),
                activeIcon: Icon(MdiIcons.home),
                title: Text(Localization.of(context).home),
              ),
              const BottomNavigationBarItem(
                // Fake item
                icon: SizedBox(),
                title: SizedBox(),
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.accountOutline),
                activeIcon: Icon(MdiIcons.account),
                title: Text(Localization.of(context).account),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool authenticated) {
    final List<Widget> actions = List();
    if (authenticated) {
      actions.add(PopupMenuButton<String>(
          // overflow menu
          icon: const Icon(Icons.more_vert),
          onSelected: (menu) {
            switch (menu) {
              case "settings":
                _navigateToSettings(context);
                break;
              case "login":
                _navigateToLogin(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: "settings",
                child: Text(
                  Localization.of(context).settings,
                ),
              ),
              PopupMenuItem<String>(
                value: "login",
                child: Text(
                  Localization.of(context).login,
                ),
              )
            ];
          }));
    }

    return AppBar(
      title: Text(Localization.of(context).appName),
      centerTitle: true,
      actions: actions,
    );
  }

  void _fabPressed(BuildContext context) {
    Navigator.of(context).pushNamed('/search');
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed('/settings');
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/login');
  }
}
