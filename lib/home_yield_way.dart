import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //add data to the stream.
  Stream<String> increment() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield DateTime.now().toString().substring(10, 19);
    }
  }

  @override
  void initState() {
    increment();
  }

  @override
  Widget build(BuildContext context) {
    //define stream builder to build something.
    final streamOutPut = StreamBuilder(
        stream: increment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator.adaptive(
              backgroundColor: Colors.black,
            );
          } else if (snapshot.hasError) {
            return SnackBar(
                content: Text(
              'Has an Error',
              style: TextStyle(color: Colors.red),
            ));
          }
          return Text(
            '${snapshot.data}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          );
        });

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Timer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              streamOutPut
            ],
          ),
        ),
      ),
    );
  }
}
