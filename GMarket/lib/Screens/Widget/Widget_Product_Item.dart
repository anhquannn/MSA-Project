import 'dart:convert';
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


  @override
  Widget build(BuildContext context) {
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
            //Hinh anh
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Image.memory(base64Decode(image),fit: BoxFit.cover,)
                    ),
                  ],
                ),
              ),
            //Ten
            Container(
              child:  Text(
                name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16,),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Container(
              child: Text('${floatToMoney(int.parse(price.toString()) as int)} VNĐ',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16, 
                    color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,),
            ),
          ],
        ),
      ),
    );
  }


}
