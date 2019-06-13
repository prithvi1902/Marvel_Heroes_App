import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // creating an object of http

import 'data/marvelList.dart';

void main() => runApp(MarvelState());

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

class FetchHeroes extends State<MarvelState> {
  final saved = Set<Marvel>();
  static List<Marvel> marvel = <Marvel>[
    Marvel(
        name: "Hulk",
        realName: "Eric Bana",
        team: "Avengers",
        firstAppearance: "1960",
        createdBy: "David Banner",
        publisher: "Marvel Comics",
        imageUrl:
        "https://imgix.bustle.com/uploads/image/2018/5/17/19fdcf46-db4b-4251-9214-85eb8c48350d-hulk-3.jpg",
        bio:
        "\r\n\t\tBruce is a geneticist working with colleague and girlfriend Betty Ross, within the Berkeley Biotechnology Institute on nanomed research to achieve instantaneous cell repair by using low-level gamma radiation exposure to turn on the nanomeds once they are introduced into a living organism, planning to use it to cure all from sicknesses such as cancer and Alzheimer's.\r\n\t\t")
  ];
  MarvelHeroesList list = MarvelHeroesList(heroes: marvel); //create an object

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Set<Marvel> savedHeroes = Set();

  //To show data at the start
  /*  @override
    void initState() {
      super.initState();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
    }*/

  @override
  Widget build(BuildContext context) {
    bool isAlreadySaved = false;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Marvel Heroes"),
            actions: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                  onPressed: () {
                    refreshIndicatorKey.currentState.show();
                  }),
            ],
          ),
          body: /*RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refresh,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  child:*/ ListView.builder(itemBuilder: (context, i) {
                    if (list != null) {
                      if (i.isOdd) return Divider();
                      final index = i ~/ 2;
                      if (index < list.heroes.length) {
                        Marvel hero = list.heroes[index];
                        isAlreadySaved = savedHeroes.contains(hero);
                        return ListTile(
                          title: Text(hero.name),
                          subtitle: Text(hero.realName),
                          leading: Container(
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.gif',
                              //specify in .yaml
                              image: hero.imageUrl,
                              placeholderScale: 4,
                            ),
                          ),
                          trailing: Icon(
                            Icons.favorite_border,
                            color: isAlreadySaved? Colors.red: null,),
                          onTap: (() {
                            setState(() {
                              if (isAlreadySaved) {
                                savedHeroes.add(hero);
                              } else {
                                savedHeroes.remove(hero);
                              }
                            });
                          }),
                        );
                      }
                    } else {
                      Text("Please wait till we load data!");
                    }
                  }/*), //
                ),
              )*/)),
    );
  }

  Future<void> refresh() {
    return fetchMarvelHeroes().then((heroes) {
      setState(() => list = heroes);
    });
  }
}

class MarvelState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FetchHeroes();
}
