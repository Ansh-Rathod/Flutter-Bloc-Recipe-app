import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:racipi/screens/home/bloc/home_screen_bloc.dart';
import 'package:racipi/screens/home/home_screen.dart';
import 'package:racipi/screens/more/more.dart';
import 'package:racipi/screens/saved/saved_screen.dart';
import 'package:racipi/screens/searchpage/cubit/search_page_cubit.dart';
import 'package:racipi/screens/searchpage/search_page.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => NavScreen(),
    );
  }

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => HomeScreenBloc()..add(LoadHomeScreen()),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => SearchPageCubit(),
      child: SearchPage(),
    ),
    SavedScreen(),
    More(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.home),
        activeColorPrimary: Colors.green,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.search),
        activeColorPrimary: Colors.green,
        title: ("Search"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        icon: Icon(Icons.bookmark_outline),
        activeColorPrimary: Colors.green,
        title: ("Bookmarks"),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.list),
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.green,
        title: ("more"),
      ),
    ];
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style11,
      ),
    );
  }
}
