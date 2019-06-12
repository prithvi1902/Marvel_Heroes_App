import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // creating an object of http

import 'data/marvelList.dart';

void main() => runApp(MarvelState());

String url = "https://simplifiedcoding.net/demos/marvel/";

Future<MarvelHeroesList> fetchMarvelHeroes() async {
  final response = await http.get('$url');

  if (response.statusCode == 200) {
    print(response.body.toString());
    return marvelHeroesListFromJson(response.body);
  } else {
    //failed to load data
    return null;
  }
}

class FetchHeroes extends State<MarvelState> {
  final saved = Set<Marvel>();
  MarvelHeroesList list = MarvelHeroesList();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

 /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Marvel Heroes"),
          ),
          body: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refresh,
              child: Container(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: fetchMarvelHeroes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.toString());
                      list = snapshot.data;
                      print(list);
                      return ListView.builder(itemBuilder: (context, i) {
                        if (i.isOdd) return Divider();

                        final index = i ~/ 2;
                        if (index < list.heroes.length) {
                          Marvel hero = list.heroes[index];
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
                          );
                        }
                      });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ))),
    );
  }

  Future<void> refresh() {
    return fetchMarvelHeroes().then((heroes) {
      heroes.heroes.add(Marvel());
      setState(() => list = heroes);
    });
  }
}

class MarvelState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FetchHeroes();
}
