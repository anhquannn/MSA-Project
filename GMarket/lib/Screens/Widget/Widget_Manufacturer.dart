
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Manufacturer_Add.dart';
import 'package:gmarket/Screens/AdminScreen/Manufacturer_List.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Widget_Manufacturer(),
    ),
  ));
}

class Widget_Manufacturer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_Manufacturer_Sate();
  }
}
class Widget_Manufacturer_Sate extends State<Widget_Manufacturer>{

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: Center(
          child:Container(
            width: width*0.9,
            child: SingleChildScrollView(
                child: Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: width*0.025,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Manufacturer_Add(),)
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
                                "Thêm nhà sản ",
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
                      ElevatedButton(
                        onPressed: () {
                          itemManufacturer.getAllManufacturer();
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Manufacturer_List(),)
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
                              Icons.list,
                              color: const Color.fromRGBO(94, 200, 248, 1),
                              size: width * 0.2,
                            ),
                            const Center(
                              child: Text(
                                "Xem nhà sản xuất",
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
                  ),
                )
            ),
          )


      ),
    );
  }

  }

