import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/base/BaseView.dart';
import 'package:tv/model/Genres.dart';
import 'package:tv/module/browse/browseview.dart';
import 'package:tv/module/home/HomeNavigator.dart';
import 'package:tv/module/home/homeviewmodel.dart';
import 'package:tv/module/home2/home2view.dart';
import 'package:tv/module/search/searchview.dart';
import 'package:tv/module/watchlist/watchlistview.dart';

class HomeView extends StatefulWidget {
  static const String RouteName="tv";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseView<HomeViewModel,HomeView>
implements HomeNavigator{
  int carrentindex=0;
  List<Widget> screens=[
    home2view(),
    searchview(),
    browseview(),
    watchlistview()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => model,
      child: Scaffold(
        body: screens[carrentindex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: carrentindex,
          onTap: (index) {
            carrentindex = index;
            setState(() {});
          },

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
            BottomNavigationBarItem(
                icon: Icon(Icons.open_in_browser_rounded), label: "BROWSE"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "WATCHLIST"),
          ],
        ),
      ),
    );
  }

  @override
  viewmodel() {
  return HomeViewModel();
  }}

