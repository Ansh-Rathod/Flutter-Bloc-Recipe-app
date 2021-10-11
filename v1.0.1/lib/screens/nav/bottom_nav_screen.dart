import 'package:bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipia/screens/favorite_screen/favorite_screen.dart';
import 'package:recipia/screens/home_screen/bloc/homerecipes_bloc.dart';
import 'package:recipia/screens/home_screen/homee_screen.dart';
import 'package:recipia/screens/more/more.dart';
import 'package:recipia/screens/search_page/cubit/search_page_cubit.dart';
import 'package:recipia/screens/search_page/search_page.dart';

class BottomNavView extends StatefulWidget {
  @override
  _BottomNavViewState createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  late PersistentTabController _controller;

  final List<Widget> _widgetOptions = <Widget>[
    BlocProvider(
      create: (context) => HomeRecipesBloc(),
      child: const HomeRecipeScreen(),
    ),
    BlocProvider(
      create: (context) => SearchPageCubit(),
      child: const SearchPage(),
    ),
    const FavoriteScreen(),
    const More(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          CupertinoIcons.home,
        ),
        activeColorPrimary: Colors.redAccent,
        title: ("Home"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        iconSize: 20,
        icon: const Icon(
          CupertinoIcons.search,
        ),
        activeColorPrimary: Colors.redAccent,
        title: ("Search"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: const Icon(
          CupertinoIcons.heart_fill,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.redAccent,
        title: ("Favorite"),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey.shade600,
        icon: Icon(
          Icons.list,
        ),
        iconSize: 20,
        activeColorPrimary: Colors.redAccent,
        title: ("More"),
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        this.context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
