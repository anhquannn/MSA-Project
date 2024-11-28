

import 'package:flutter/material.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_Add.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_Delete.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_Update.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: const Scaffold(
      body: Widget_PromoCode(),
    ),
  ));
}

class Widget_PromoCode extends StatefulWidget{
  const Widget_PromoCode({super.key});

  @override
  State<StatefulWidget> createState() {
    return Widget_PromoCode_Sate();
  }
}
class Widget_PromoCode_Sate extends State<Widget_PromoCode>{

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
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
                            onPressed: () {
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => Promocode_Add(),)
                              );
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
                                  color: const Color.fromRGBO(94, 200, 248, 1),
                                  size: width * 0.2,
                                ),
                                const Center(
                                  child: Text(
                                    "Thêm mã",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Coiny-Regular-font',
                                      color: Colors.black,
                                    ),textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: height*0.03,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Promocode_Update(),)
                              );
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
                                  color: const Color.fromRGBO(94, 200, 248, 1),
                                  size: width * 0.2,
                                ),
                                const Center(
                                  child: Text(
                                    "Sửa mã",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Coiny-Regular-font',
                                      color: Colors.black,
                                    ),textAlign: TextAlign.center,
                                  ),
                                )
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
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => Promocode_Delete(),)
                              );
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
                                  color: const Color.fromRGBO(94, 200, 248, 1),
                                  size: width * 0.2,
                                ),
                                const Center(
                                  child: Text(
                                    "Xóa mã",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Coiny-Regular-font',
                                      color: Colors.black,
                                    ),textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
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