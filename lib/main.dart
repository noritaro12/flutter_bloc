import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';


class CounterBloc {
  final _actionController = StreamController<void>();
  Sink<void> get sink {
    return _actionController.sink;
  }

  final _countController = StreamController<int>();
  Stream<int> get stream {
    return _countController.stream;
  }

  int _count = 0;

  CounterBloc() {
    _actionController.stream.listen((_) {
      _count++;
      _countController.sink.add(_count);
    });
  }

  void dispose() {
    _actionController.close();
    _countController.close();
  }
}



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<CounterBloc>(
        create: (context)=>CounterBloc(),
        dispose: (context, bloc)=>bloc.dispose(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      )//,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);
     return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: counterBloc.stream,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot?.data ?? 100}',
                  style: Theme.of(context).textTheme.display1,
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()=> counterBloc.sink.add(null),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




