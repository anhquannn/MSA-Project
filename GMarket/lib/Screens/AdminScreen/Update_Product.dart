
import 'dart:convert';
import 'dart:io';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Update_Product.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Category.dart';
import 'package:gmarket/Http/Manufaturer.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Add_Product(),
      )));
}

class Add_Product extends StatefulWidget{
  @override
  State createState() {
    return Add_Product_State();
  }
}
class Add_Product_State extends State<Add_Product> {
  int? searchId;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          // Mũi tên quay lại màu trắng
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước đó
          },
        ),
        title: TextField(
          onSubmitted: (value) {
            setState(() {
              searchId=int.tryParse(value);
            });
          },
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromRGBO(94, 200, 248, 1),
                width: 3,
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 4,
                color: Color.fromRGBO(94, 200, 248, 1)
              ),
            ),
            prefixIcon: Icon(Icons.search, color: Colors.white,),
          ),
        ),
      ),
     // body: searchId!=null? Widget_Update_Product(id: searchId,): null

    );
  }
}