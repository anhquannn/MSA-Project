
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Product_Add.dart';
import 'package:gmarket/Screens/AdminScreen/Product_List.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: const Scaffold(
      body: Widget_Product(),
    ),
  ));
}

class Widget_Product extends StatefulWidget{
  const Widget_Product({super.key});

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

    final itemProvider=Provider.of<ProductProvider>(context);
    final itemCategory=Provider.of<Category_Provider>(context,listen: false);
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: Container(
        child:Center(
          child: Container(
              width: width*0.9,
              height: height*0.9,
            child: Center(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thêm sản phẩm
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Add_Product(),)
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
                            "Thêm sản phẩm",
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
                  // Xem sản phẩm
                  ElevatedButton(
                    onPressed: () async{
                      loading();
                      await itemCategory.getAllCategory();
                      await itemProvider.getAllProduct();
                      await itemManufacturer.getAllManufacturer();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Product_List(),)
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
                            "Xem sản phẩm",
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

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}
