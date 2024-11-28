
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Category_Update.dart';
import 'package:gmarket/Screens/Widget/Widget_Category_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Category.dart';

import 'package:gmarket/Models/Category.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Category_List(),
      )));
}

class Category_List extends StatefulWidget{
  @override
  State createState() {
    return Category_List_State();
  }
}
class Category_List_State extends State<Category_List> {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemCategory=Provider.of<Category_Provider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        title: const Text("Quản Lý Cửa Hàng",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body:
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5
              ),
              itemCount: itemCategory.listCategory.length,
              itemBuilder: (context, index) {
                final cat = itemCategory.listCategory[index];
                print("${cat.description}");
                return Widget_Category_Item(
                    name: cat.name,
                    description: cat.description,
                    ID: cat.ID,
                  onTap: () {
                      itemCategory.getCategoryById(cat.ID);
                      Navigator.push(
                          context, 
                        MaterialPageRoute(builder: (context) => Category_Update( id: cat.ID,),)
                      );
                  },

                    );
              },
            )

    );

  }
  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  }
