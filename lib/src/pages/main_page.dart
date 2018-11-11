import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/main_bloc.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/commons/tags.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/pages/account_page.dart';
import 'package:cv/src/pages/home_page.dart';
import 'package:cv/src/widgets/menu_icon_button_widget.dart';
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
        heroTag: kHeroSearchFAB,
        icon: Icon(Icons.search),
        label: Text(Localization.of(context).search),
        foregroundColor: Colors.white,
        onPressed: () => _navigateToSearch(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    HomePage _homePage = HomePage();
    AccountPage _accountPage = AccountPage();

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
                  child: _homePage,
                ),
                Offstage(
                  offstage: snapshot.data != TabType.ACCOUNT_TAB,
                  child: _accountPage,
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
        primaryColor: Theme.of(context).selectedRowColor,
        textTheme: Theme.of(context).primaryTextTheme,
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
    return AppBar(
      title: Text(Localization.of(context).appName),
      centerTitle: true,
      actions: [
        MenuIconButton(),
      ],
    );
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.of(context).pushNamed(kPathSearch);
  }
}
