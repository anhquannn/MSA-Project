
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Screens/AdminScreen/Add_Product.dart';
import 'package:gmarket/Screens/CustomerScreen/Home_Screen.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Widget_Product(),
    ),
  ));
}

class Widget_Product extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_ProductSate();
  }
}
class Widget_ProductSate extends State<Widget_Product>{

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: SingleChildScrollView(
        child:Center(
          child: Container(
            width: width*0.9,
            height: height*0.9,
            child: Center(
              child: Row(
              children: [
                SizedBox(width: width*0.025,),
                Column(
                  children: [
                    SizedBox(height: height*0.025,),
                    ElevatedButton(
                      onPressed: () {
                        onPressCreateProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                        fixedSize: Size(width * 0.4, width * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.grey[300],
                        elevation: 7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Color.fromRGBO(94, 200, 248, 1),
                            size: width * 0.2,
                          ),
                          Text(
                            "Thêm sản phẩm",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Coiny-Regular-font',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.03,),
                    ElevatedButton(
                      onPressed: () {
                        onPressUpdateProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                        fixedSize: Size(width * 0.4, width * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.grey[300],
                        elevation: 7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.update,
                            color: Color.fromRGBO(94, 200, 248, 1),
                            size: width * 0.2,
                          ),
                          Text(
                            "Sửa sản phẩm",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Coiny-Regular-font',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(width: width*0.05,),
                Column(
                  children: [
                    SizedBox(height: height*0.025,),
                    ElevatedButton(
                      onPressed: () {
                        onPressGetAllProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                        fixedSize: Size(width * 0.4, width * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.grey[300],
                        elevation: 7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            color: Color.fromRGBO(94, 200, 248, 1),
                            size: width * 0.2,
                          ),
                          Text(
                            "Xem sản phẩm",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Coiny-Regular-font',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.03,),
                    ElevatedButton(
                      onPressed: () {
                        onPressGetAllProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                        fixedSize: Size(width * 0.4, width * 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.grey[300],
                        elevation: 7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Color.fromRGBO(94, 200, 248, 1),
                            size: width * 0.2,
                          ),
                          Text(
                            "Xóa sản phẩm",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Coiny-Regular-font',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
                
            )
          ),
        )


        ),
    );
  }

  Future<void> onPressCreateProduct() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Add_Product(),)
    );
  }
  Future<void> onPressUpdateProduct() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Add_Product(),)
    );
  }
  Future<void> onPressGetAllProduct() async{
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(),)
    );
  }

}

  //Tạo sản phẩm