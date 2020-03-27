import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myapp/data.dart';
import 'package:myapp/tabs.dart';

import 'carousel.dart';

class Date extends StatefulWidget{

  Date({Key key, @required this.mon, @required this.tue, @required this.wed, @required this.thu, @required this.fri}) : super(key : key);

  final Future<List<Menu>> mon;
  final Future<List<Menu>> tue;
  final Future<List<Menu>> wed;
  final Future<List<Menu>> thu;
  final Future<List<Menu>> fri;

  _DateState createState() => _DateState();
}

class _DateState extends State<Date>{

  int selected = (DateTime.parse(DateTime.now().toString()).weekday)-1;

  void changeIndex(int index) {
    if (selected == index) {
      return;
    }
    setState(() {
      selected = index;
    });
  }

  Future<List<Menu>> getFuture() {
    if (selected == 0) {
      return widget.mon;
    } else if (selected == 1) {
      return widget.tue;
    } else if (selected == 2) {
      return widget.wed;
    } else if (selected == 3) {
      return widget.thu;
    } else if (selected == 4) {
      return widget.fri;
    } else
    return widget.mon;
  }

  @override
  Widget build(BuildContext context) {

    // sat, sun -> mon
    if (selected > 4) {
      selected = 0;
      changeIndex(0);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child:  Column(
        children: <Widget>[
          Tabs(
            selected: selected,
            changeIndex: this.changeIndex,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 1.45,
              child: FutureBuilder(
                  key: UniqueKey(),
                  future: getFuture(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Menu>> snapshot) {
                    return Carousel(
                        data: snapshot.data, loading: !snapshot.hasData);
                  }))
        ],
      ),
    );
  } 

}