import 'package:flutter/material.dart';

import 'package:marvel_app/data/marvelList.dart';

class SingleHero extends StatelessWidget {
  static List<Marvel> marvel = <Marvel>[
    Marvel(
        name: "Hulk",
        realName: "Eric Bana",
        team: "Avengers",
        firstAppearance: "1960",
        createdBy: "David Banner",
        publisher: "Marvel Comics",
        imageUrl:
            "https://imgix.bustle.com/uploads/image/2018/5/17/19fdcf46-db4b-4251"
            "-9214-85eb8c48350d-hulk-3.jpg",
        bio:
            "\r\n\t\tBruce is a geneticist working with colleague and girlfriend "
            "Betty Ross, within the Berkeley Biotechnology Institute on "
            "nanomed research to achieve instantaneous cell repair by using "
            "low-level gamma radiation exposure to turn on the nanomeds once "
            "they are introduced into a living organism, planning to use it "
            "to cure all from sicknesses such as cancer and Alzheimer's.\r\n\t\t")
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          marvel[0].name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        //Spacer(flex: 1) //for rows
        Container(
            width: 190.0,
            height: 190.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(marvel[0]?.imageUrl)))),
      ],
    ));
  }
}
