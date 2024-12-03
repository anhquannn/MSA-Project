
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Category_Add.dart';
import 'package:gmarket/Screens/AdminScreen/Category_List.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Widget_Category(),
    ),
  ));
}

class Widget_Category extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_Category_Sate();
  }
}
class Widget_Category_Sate extends State<Widget_Category>{

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final itemCategory=Provider.of<Category_Provider>(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: Center(
          child:Container(
            width: width*0.9,
            child: SingleChildScrollView(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onPressCreateCategory();
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
                              "Thêm loại sản phẩm",
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
                        itemCategory.getAllCategory();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Category_List(),)
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
                              "Xem loại sản phẩm",
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
            ),
          )
      ),
    );
  }
  void onPressCreateCategory() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Category_Add(),)
    );
  }

}
