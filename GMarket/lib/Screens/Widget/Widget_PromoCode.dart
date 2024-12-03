

import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_Add.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_List.dart';
import 'package:provider/provider.dart';

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
    final promocodeProvider=Provider.of<Promocode_Provider>(context,listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: Center(
        child: Container(
          width: width*0.9,
          child: SingleChildScrollView(
            child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        "Thêm mã\ngiảm giá",
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
              //danh sach ma
              ElevatedButton(
                onPressed: () async{
                  await promocodeProvider.getAllPromoCode();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Promocode_List(),)
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
                      color: Color.fromRGBO(94, 200, 248, 1),
                      size: width * 0.2,
                    ),
                    const Center(
                      child: Text(
                        "Xem mã\ngiảm giá",
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
        ),
      )
    );
  }
}