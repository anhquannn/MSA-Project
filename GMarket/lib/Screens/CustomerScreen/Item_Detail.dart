
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Product.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_PromoCode.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_User.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Order.dart';
import 'package:gmarket/Screens/CustomerScreen/Widget/Widget_Product_Item.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: ItemDetail(id: 1,),
    ),
  ));
}

class ItemDetail extends StatefulWidget{
  late final int? id;
  ItemDetail({
    required this.id
  });

  @override
  State<StatefulWidget> createState() {
    return ItemDetailState();
  }
}

class ItemDetailState extends State<ItemDetail>{

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold();
  }
}
