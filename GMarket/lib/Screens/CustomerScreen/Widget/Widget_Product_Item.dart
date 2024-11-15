import 'dart:convert';

import 'package:gmarket/Screens/CustomerScreen/ItemDetail.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetProductItem extends StatelessWidget {
  final String name;
  final String image;
  final int? price;
  final int? id;
  final VoidCallback onTap;

  WidgetProductItem({
    required this.name,
    required this.image,
    required this.price,
    this.id,
    required this.onTap,
  });

  get child => null;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String floatToMoney(int price){
      NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN'); // Định dạng tiền tệ cho Việt Nam
      String formattedAmount = formatter.format(price);
      return formattedAmount;
    }
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Expanded(
                  child: Center(
              child: Container(
                  color: Colors.black,
                  child: Image.memory(base64Decode(image),fit: BoxFit.cover,)
              ),
                  )
                ),
              ),
              Container(
                child:  Text(
                  name,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Container(
                child: Text('${floatToMoney(price!)} VNĐ',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,),
              ),
            ],
          ),
      ),
    );
  }


}
