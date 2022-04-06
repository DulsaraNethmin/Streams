import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //create object from stream controller
  StreamController _counter_controller = StreamController();

  //add data to the stream.
  void increment() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      _counter_controller.sink.add(DateTime.now().toString().substring(10, 19));
    }
  }

  //close the stream
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _counter_controller.close();
  }

//call the stream
  @override
  void initState() {
    increment();
  }

  @override
  Widget build(BuildContext context) {
    //define stream builder to build something.
    final streamOutPut = StreamBuilder(
        stream: _counter_controller.stream,
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
