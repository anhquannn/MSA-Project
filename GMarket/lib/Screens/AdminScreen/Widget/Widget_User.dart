
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Widget_User(),
    ),
  ));
}

class Widget_User extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_User_Sate();
  }
}
class Widget_User_Sate extends State<Widget_User>{

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: SingleChildScrollView(
          child:Center(
            child: Container(
              // color: Color.fromRGBO(0, 0, 0, 1),
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
                            onPressed: onPressCreateProduct,
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
                                  "Xóa người dùng",
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
}

//Tạo sản phẩm
Future<void> onPressCreateProduct() async{

}