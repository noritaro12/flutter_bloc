// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MaterialApp(
        home: ParentWidget(),
        title: 'provider examples',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 48.0),
          ),
        ),
      ),
    );

class HomeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: MyAuthPage(),
//      home: MyFirestorePage(),
      home: ParentWidget(),
    );
  }
}


class CountData extends ChangeNotifier{
  int count =0;

  void increment(){
    count +=1;

    notifyListeners();
  }
}

class ParentWidget extends StatelessWidget{

  final data = CountData();
  @override
  Widget build(BuildContext context) {

      return Provider<CountData>.value(
        value: data,
        child: Container(
          child: Childwidget(),
        ),
      );

  }
}

class Childwidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final CountData data = Provider.of<CountData>(context);
    return Column(
      children: [
        Text('count is ${data.count.toString()}'),
        RaisedButton(
          child: Text("Count up"),
          onPressed: (){
            data.increment();
          },
        )
      ],
    );

  }
}

