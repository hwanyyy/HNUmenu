import 'package:flutter/material.dart';
import 'package:myapp/menutab.dart';

class Tabs extends StatefulWidget{
  Tabs({@required this.selected, @required this.changeIndex});

  int selected;
  final Function changeIndex;

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  Widget build(BuildContext context) {

    // wed, thu, fri tab scroll position init
    if (widget.selected == 2) {
      _controller = ScrollController(initialScrollOffset: 65.0);
    } else if (widget.selected == 3 || widget.selected == 4) {
      _controller = ScrollController(initialScrollOffset: 120.0);
    }


    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
            child: ListView(
              controller: _controller,
              padding: EdgeInsets.only(left: 35),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                MenuTab(
                  onTap: () {
                    widget.changeIndex(0);
                  },
                  isSelected: widget.selected == 0,
                  label: "Mon",
                ),
                MenuTab(
                  onTap: () {
                    widget.changeIndex(1);
                  },
                  isSelected: widget.selected == 1,
                  label: "Tue",
                ),
                MenuTab(
                  onTap: () {
                    widget.changeIndex(2);
                  },
                  isSelected: widget.selected == 2,
                  label: "Wed",
                ),
                MenuTab(
                  onTap: () {
                    widget.changeIndex(3);
                  },
                  isSelected: widget.selected == 3,
                  label: "Thu",
                ),
                MenuTab(
                  onTap: () {
                    widget.changeIndex(4);
                  },
                  isSelected: widget.selected == 4,
                  label: "Fri",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}