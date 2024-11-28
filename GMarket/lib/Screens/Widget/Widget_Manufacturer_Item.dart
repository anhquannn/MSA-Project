import 'dart:convert';

import 'package:gmarket/Screens/CustomerScreen/Order_List_Item.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Manufacturer_Item extends StatelessWidget {
  final String name;
  final String address;
  final String contact;
  final int? ID;
  final VoidCallback onTap;

  Widget_Manufacturer_Item({
    required this.name,
    required this.address,
    required this.contact,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(address,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,),
            Text(contact,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,),
          ],
        ),

      ),
    );
  }


}
