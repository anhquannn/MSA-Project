import 'dart:convert';

import 'package:gmarket/Screens/CustomerScreen/Order_List_Item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Category_Item extends StatelessWidget {
  final String name;
  final String description;
  final int? ID;
  final VoidCallback onTap;

  Widget_Category_Item({
    required this.name,
    required this.description,
    this.ID,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromRGBO(244, 244, 244, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child:Container(
          child: Center(
            child: Column(
              children: [
                Text(ID.toString(),
                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,),
              ],
            ),
          ),
        )

      ),
    );
  }


}
