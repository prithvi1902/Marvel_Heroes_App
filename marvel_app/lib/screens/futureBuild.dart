import 'package:flutter/material.dart';

class FutureBuild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FutureBuildState();
}

class FutureBuildState extends State<FutureBuild> {
  var string = "I am the last written statement";
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    printResult();
    incrementCounter();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(string),
          SizedBox(
            height: 20,
          ),
          Text(counter.toString())
        ],
      ),
    );

    //Future Builder demo
    /* return FutureBuilder(
        future: slowOperation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Center(
                child: Text(snapshot.data),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });*/
  }

  void printResult() {
    Future<String> result = slowOperation();
    result.then((result) {
      setState(() {
        string = "$result";
      });
    });
  }

  void incrementCounter() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (counter < 6) {
          counter++;
        }
      });
    });
  }

  Future<String> slowOperation() {
    Future<String> result = Future.delayed(Duration(seconds: 6), () {
      return "\"Completed slowOperation()\"";
    });
    return result;

    //FutureBuilder
    /*Future<String> result = Future.delayed(Duration(seconds: 6), () {
      return "\"Completed slowOperation\"";
    });
    return result;*/
  }
}
