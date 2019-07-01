import 'package:flutter/material.dart';
import 'package:marvel_app/data/marvelList.dart';

Set<Marvel> favouriteHeroes;

class Favourites extends StatefulWidget {
  Favourites(Set<Marvel> favoriteHeroes) {
    favouriteHeroes = favoriteHeroes;
  }

  @override
  State<StatefulWidget> createState() => FavouriteHeroes();
}

class FavouriteHeroes extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    if (favouriteHeroes != null && favouriteHeroes.isNotEmpty) {
      return Container(
        alignment: Alignment.center,
        child: ListView.builder(itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index < favouriteHeroes.length) {
            Marvel hero = favouriteHeroes.elementAt(index);
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
                Icons.favorite,
                color: Colors.red,
              ),
              onTap: (() {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "First Appearance in ${hero.firstAppearance}.",
                    ),
                    duration: Duration(seconds: 1)));
              }),
            );
          }
        }), //
      );
    } else {
      return Center(
        child: Text('You have not chosen any favourites yet!'),
      );
    }
  }
}
