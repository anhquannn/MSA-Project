
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:gmarket/Http/PromoCode.dart';
import 'package:gmarket/Models/Promocode.dart';
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
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: test(),
      )));
}

class test extends StatefulWidget{

  @override
  State createState() {
    return Promocode_Update_State();
  }
}

class Promocode_Update_State extends State<test> {
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController discounttype = TextEditingController();
  TextEditingController discountpercentage = TextEditingController();
  TextEditingController minimumordervalue = TextEditingController();
  TextEditingController startdate= TextEditingController();
  TextEditingController enddate= TextEditingController();
  int?id;

  Future getData(int id) async {
    final pc=await promoCodeHttp().getPromoCodeById(id);
    if(pc!=null){
      setState(() {
        name.text = pc.name.toString();
        code.text = pc.code!;
        description.text = pc.description.toString();
        startdate.text = pc.startdate.toString();
        enddate.text = pc.enddate.toString();
        status.text = pc.status.toString();
        discounttype.text = pc.discounttype!;
        minimumordervalue.text = int.parse(pc.minimumordervalue as String).toString();
        minimumordervalue.text = int.parse(pc.discountpercentage as String).toString();
      });
    }
    else{
      print("Không thể lấy PromoCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            setState(()  async{
              id=int.parse(value);
              await getData(int.parse(value));
            });
          },
          decoration: InputDecoration(
            hintText: "Tìm kiếm Id",
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
              borderSide: const BorderSide(
                  width: 4,
                  color: Color.fromRGBO(94, 200, 248, 1)
              ),
            ),
            prefixIcon: Icon(Icons.search, color: Colors.white,),
          ),
        ),
      ),
      body:Center(
    )
    );
  }
}

