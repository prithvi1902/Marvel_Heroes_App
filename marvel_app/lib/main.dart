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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
  }

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
                      bool isAlreadySaved = saved.contains(list.heroes[index]);
                      Marvel hero = list.heroes[index];
                      return ListTile(
                          title: Text(hero.name),
                          subtitle: Text(hero.realName),
                          leading: Container(
                            child: Image.network(hero.imageUrl),
                          ),
                          /*trailing: Icon(
                            isAlreadySaved
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isAlreadySaved ? Colors.red : null,
                          ),*/
                          /*onTap: () {
                            setState(() {
                              if (isAlreadySaved) {
                                saved.remove(hero);
                              } else {
                                saved.add(hero);
                              }
                            });
                          }*/);
                    }
                  });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          )),
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

/*Widget _buildRow(Marvel hero, bool isAlreadySaved) {
    return Scaffold(
      body: ListTile(
        title: Text(hero.name),
        subtitle: Text(hero.realName),
        leading: Container(
          child: Image.network(hero.imageUrl),
        ),
        trailing: Icon(
          isAlreadySaved ? Icons.favorite : Icons.favorite_border,
          color: isAlreadySaved ? Colors.red : null,
        ),
        onTap: () {
          {
            if (isAlreadySaved) {
              saved.remove(hero);
            } else {
              saved.add(hero);
            }
          }
        },
      ),
    );
  }*/

/*void main() => runApp(FetchHeroes(post: fetchPost()));

Future<Post> fetchPost() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    //failed to load data
    return null;
  }
}

class FetchHeroes extends StatelessWidget {
  final Future<Post> post;

  FetchHeroes({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Marvel Heroes'),
        ),
        body: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListTile(
                  leading: Icon(Icons.album),
                  trailing: Text(snapshot.data.id.toString()),
                  title: Text(snapshot.data.title));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['userId'], json['id'], json['title'], json['body']);
  }
}*/
