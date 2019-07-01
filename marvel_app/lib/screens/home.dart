import 'package:flutter/material.dart';
import 'package:marvel_app/data/marvelList.dart';
import 'package:marvel_app/screens/favourites.dart';
import 'package:marvel_app/screens/futureBuild.dart';

import 'package:marvel_app/screens/heroes.dart';
import 'package:marvel_app/screens/singleHero.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen> {
  final widgetOptions = [
    SingleHero(),
    MarvelState(),
    Favourites(savedHeroes),
    FutureBuild()
  ];
  int _selectedIndex = 0;
  static Set<Marvel> savedHeroes = Set();

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // The scaffold will expand to fill the available space.
        appBar: AppBar(
          title: Text("Marvel Heroes"),
        ),
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text('Home'), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text('Heroes'), icon: Icon(Icons.face)),
            BottomNavigationBarItem(
                title: Text('Favourites'), icon: Icon(Icons.favorite)),
            BottomNavigationBarItem(
                title: Text('Future'), icon: Icon(Icons.beenhere))
          ],
          selectedItemColor: Colors.cyan,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

/* actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
//                  refreshIndicatorKey.currentState.show();
                }),
          ],*/
