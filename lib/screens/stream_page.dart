import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final imageStream = new StreamController<String>();
  @override
  void dispose() {
    imageStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba de Stream'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens_sharp),
        onPressed: () {
          imageStream.sink.add('https://picsum.photos/200/300');
        },
      ),
      body: Center(
        child: StreamBuilder(
          stream: imageStream.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return LoadingWidget();
            } else return Container(
              height: 300,
              width: double.infinity,
              child: FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(snapshot.data),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Esperando acción'),
        SizedBox(height: 30),
        CircularProgressIndicator(),
      ],
    );
  }
}
