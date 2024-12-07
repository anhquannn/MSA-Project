
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Manufacturer_Add(),
      )));
}

class Manufacturer_Add extends StatefulWidget{
  @override
  State createState() {
    return Manufacturer_Add_State();
  }
}
class Manufacturer_Add_State extends State<Manufacturer_Add> {

  late String name;
  late String address;
  late String contact;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          titleTextStyle: const TextStyle(
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Quản Lý Cửa Hàng",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Coiny-Regular-font',
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                color: Colors.white,
                width: width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01,),
                      //Tên mã nhà sản xuất
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Tên mã nhà sản xuất",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Coiny-Regular-font'
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 3,
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 2,
                              )
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      //Địa chỉ nhà sản xuất
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Địa chỉ nhà sản xuất",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Coiny-Regular-font'
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 3,
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 2,
                              )
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      // Thông tin liên lạc
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Thông tin liên lạc",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Coiny-Regular-font'
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 3,
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 2,
                              )
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                        onChanged: (value) {
                          setState(() {
                            contact = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(94, 200, 248, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      color: Colors.black,
                                      width: 0.2
                                  )
                              )
                          ),
                          onPressed: () {
                            itemManufacturer.createManufacturer(new Manufacturer(name: name,contact: contact,address: address,ID: 0)).then((_){
                              Navigator.pop(context);

                              showMessage(context, "Thêm thành công");
                            });
                          },
                          child: const Text(
                            "Tạo nhà sản xuất",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                          )),
                      SizedBox(height: height * 0.2,),
                    ],
                  ),
                )
            ),
          ),

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
