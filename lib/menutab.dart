import 'package:flutter/material.dart';

class MenuTab extends StatelessWidget{
  MenuTab({@required this.isSelected, @required this.label, @required this.onTap});

  final bool isSelected;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(right: 45),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat-Medium',
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.grey),
          ),
        ));
  }
}