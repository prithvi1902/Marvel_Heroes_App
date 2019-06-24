import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; // creating an object of http
import 'package:marvel_app/data/marvelList.dart';
import 'package:marvel_app/screens/home.dart';
import 'package:marvel_app/screens/singleHero.dart';


class MarvelState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FetchHeroes();
}

class FetchHeroes extends State<MarvelState> {
  final saved = Set<Marvel>();

  MarvelHeroesList list = MarvelHeroesList(heroes: SingleHero.marvel); //create an object

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<
      RefreshIndicatorState>(); //key used to denote the refresh indicator

  //To show data at the start
  /*  @override
    void initState() {
      super.initState();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    }*/

  Future<void> refresh() {
    return fetchMarvelHeroes().then((heroes) {
      setState(() => list = heroes);
    });
  }

  @override
  Widget build(BuildContext context) {
  /*  actions: <Widget>[
      new IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () {
            refreshIndicatorKey.currentState.show();
          }),
    ],*/
    bool isAlreadySaved;
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: refresh,
      child: Container(
        alignment: Alignment.center,
        child: ListView.builder(itemBuilder: (context, i) {
          if (list != null) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;
            if (index < list.heroes.length) {
              Marvel hero = list.heroes[index];
              isAlreadySaved = Home.savedHeroes.contains(hero);
              return ListTile(
                title: Text(hero.name),
                subtitle: Text(hero.realName),
                leading: Container(
                  child: FadeInImage.assetNetwork(
                    //specify in .yaml
                    placeholder: 'assets/loading.gif',
                    image: hero.imageUrl,
                    placeholderScale: 4,
                  ),
                ),
                trailing: Icon(
                  isAlreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: isAlreadySaved ? Colors.red : null,
                ),
                onTap: (() {
                  setState(() {
                    isAlreadySaved = Home.savedHeroes.contains(hero);
                    if (isAlreadySaved) {
                      Home.savedHeroes.remove(hero);
                    } else {
                      Home.savedHeroes.add(hero);
                    }
                  });
                }),
              );
            }
          } else {
            Text("Please wait till we load data!");
          }
        }), //
      ),
    );
  }
}

String url = "https://simplifiedcoding.net/demos/marvel/";

Future<MarvelHeroesList> fetchMarvelHeroes() async {
  final response = await http.get('$url');

  if (response.statusCode == 200) {
    return marvelHeroesListFromJson(response.body);
  } else {
    //failed to load data
    return null;
  }
}