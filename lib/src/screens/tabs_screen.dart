import 'package:flutter/material.dart';
import 'package:newsapp/src/screens/tab1_screen.dart';
import 'package:newsapp/src/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {

@override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
          create: (BuildContext context) => _NavigationModel(),
          child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.actualPage,
      onTap: (i) => navigationModel.actualPage = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados')),
      ]
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

     final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {

  int _actualPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  int get actualPage => this._actualPage;

  set actualPage(int value) {
    this._actualPage = value;
    this._pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}