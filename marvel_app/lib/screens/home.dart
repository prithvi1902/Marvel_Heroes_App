import 'package:flutter/material.dart';
import 'package:marvel_app/data/marvelList.dart';
import 'package:marvel_app/screens/favourites.dart';

import 'package:marvel_app/screens/heroes.dart';
import 'package:marvel_app/screens/singleHero.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<HomeScreen> {
  final widgetOptions = [SingleHero(), MarvelState(), Favourites(savedHeroes)];
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
        appBar: AppBar(
          title: Text("Marvel Heroes"),
        ),
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text('Home'), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text('Heroes'), icon: Icon(Icons.face)),
            BottomNavigationBarItem(
                title: Text('Favourites'), icon: Icon(Icons.favorite))
          ],
          selectedItemColor: Colors.cyan,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

/*
class MarvelApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "StatelessWidget",
        home:MarvelState()
    );
  }
}*/
