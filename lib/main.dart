import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(title: 'Stopwatch'),
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

  void _resume() {
    if (_timer != null && _timer.isActive) return;
    _start();
  }

  void _pause() {
    if (_timer != null && _timer.isActive) _timer.cancel();
  }

  void _start() {
    _timer = Timer.periodic(
        Duration(milliseconds: 1), (Timer timer) => _incrementCounter());
  }

  void _clear() {
    if (_timer != null && _timer.isActive) _timer.cancel();
    setState(() {
      _counter = 0;
    });
  }

  String format(int time) {
    if (time== 0) return "tap start";
    int ms = time % 1000;
    int sec = (time / 1000 % 60).toInt();
    int min = (time / 1000 / 60 % 60).toInt();
    int h = time / 1000 / 60 ~/ 60;
    String hStr = "";
    String mStr = "";
    String secStr = "";
    String msStr = ms.toString();

    if (ms >= 100)
      msStr = "$ms";
    else if (ms >= 10)
      msStr = "0$ms";
    else
      msStr = "00$ms";

    if (sec > 0 || min > 0 || h > 0) {
      if (sec >= 10)
        secStr = "$sec:";
      else
        secStr = "0$sec:";
    }

    if (min > 0 || h > 0) {
      if (min >= 10)
        mStr = "$min:";
      else
        mStr = "0$min:";
    }

    if (h > 0) hStr = "$h:";

    return "$hStr$mStr$secStr$msStr";
  }

  String _getResumeButtonTitle(int time){
   if (time==0) return "start";
  return "resume";
  }

  Timer _timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          textTheme: Theme.of(context).accentTextTheme,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Time spend:', style: Theme.of(context).textTheme.title,),
              Text(
                format(_counter),
                textScaleFactor: 1.3,
                style: Theme.of(context).textTheme.display1,
              ),
              MaterialButton(
                  child: new Text("pause"),
                  color: Colors.red,
                  onPressed: () {
                    _pause();
                  }),
              MaterialButton(
                  child: new Text(_getResumeButtonTitle(_counter)),
                  color: Colors.red,
                  onPressed: () {
                    _resume();
                  }),
              MaterialButton(
                  child: new Text("clear"),
                  color: Colors.red,
                  onPressed: () {
                    _clear();
                  }),
            ],
          ),
        ));
  }
}
