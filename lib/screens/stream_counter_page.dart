import 'dart:async';

import 'package:flutter/material.dart';

class StreamCounterPage extends StatefulWidget {
  @override
  _StreamCounterPageState createState() => _StreamCounterPageState();
}

class _StreamCounterPageState extends State<StreamCounterPage> {
  final intStream = new StreamController<int>();
  int couter = -1;
  @override
  void dispose() {
    intStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba de Stream'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          couter++;
          intStream.sink.add(couter);
        },
      ),
      body: Center(
        child: StreamBuilder(
          stream: intStream.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return _LoadingWidget();
            } else return Container(
              height: 300,
              width: double.infinity,
              child: Center(
                child: Text(
                  '${snapshot.data}',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Presione el boton...'),
        SizedBox(height: 30),
        CircularProgressIndicator(),
      ],
    );
  }
}
