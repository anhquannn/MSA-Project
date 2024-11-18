
import 'dart:convert';
import 'dart:io';
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
      theme: ThemeData.light(),
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

  late String name;
  late int price;
  late String image='';
  late int size;
  late String color;
  late String specification;
  late String description;
  late int stocknumber;
  late String stocklevel = "Low";
  late int category_id;
  late int manufaturer_id;

  late DateTime expiry;

  Category? selectedCategory;
  Manufacturer? selectedManufacturer;
  Future<List<Category>?> listCategory = categoryHttp().getAllCategory();

  late bool flagImage = false;

  @override
  void initState() {
    super.initState();
    listCategory = categoryHttp().getAllCategory();
  }

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
    return Scaffold();
  }
}
