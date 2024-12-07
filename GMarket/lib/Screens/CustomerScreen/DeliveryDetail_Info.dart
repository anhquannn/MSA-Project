import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class Delivery_Info extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Delivery_Info_State();
  }

}
class Delivery_Info_State extends State<Delivery_Info>{
  String _name="";
  String _address="";
  String _phoneNumber="";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final itemUser=Provider.of<User_Provider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          onPressed: () async {
            // loading();
            // orderProvider.clearPreviewOrder();
            // await cartItemProvider.deleteCartItem(cartItemProvider.cart!.ID!);
            // Navigator.pop(context);
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Chỉnh sửa địa chỉ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Coiny-Regular-font',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.01,),
              //Tên
              TextField(
                decoration: InputDecoration(
                  labelText: "Tên",
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Coiny-Regular-font'
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 2,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 1,
                      )
                  ),
                ),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value.toString();
                  });
                },
              ),
              SizedBox(height: height * 0.01,),
              //Dia chi
              TextField(
                decoration: InputDecoration(
                  labelText: "Địa chỉ",
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Coiny-Regular-font'
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 2,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 1,
                      )
                  ),
                ),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15
                ),
                onChanged: (value) {
                  setState(() {
                    _address = value.toString();
                  });
                },
              ),
              SizedBox(height: height * 0.01,),
              //So dien thoai
              TextField(
                decoration: InputDecoration(
                  labelText: "Số điện thoại",
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Coiny-Regular-font'
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 2,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        width: 1,
                      )
                  ),
                ),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15
                ),
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value.toString();
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
                  onPressed: () async {
                    await itemUser.updateUserInfo(_name, _phoneNumber, _address);
                    await itemUser.getUserById(itemUser.user!.ID);
                    Navigator.pop(context);
                    showMessage(context, "Cập nhật thành công");
                  },
                  child: const Text(
                    "Tạo loại sản phẩm",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Coiny-Regular-font'),
                  )),
              SizedBox(height: height * 0.2,),
            ],
          ),
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