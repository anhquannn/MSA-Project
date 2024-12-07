import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/DeliveryDetail.dart';
import 'package:gmarket/Provider/DeliveryDetail_Provider.dart';
import 'package:provider/provider.dart';

class DeliveryDetail_Add extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DeliveryDetail_Add_State();
  }

}
class DeliveryDetail_Add_State extends State<DeliveryDetail_Add>{
  String name="";
  String address="";
  String phoneNumber="";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final deliveryDetailProvider = Provider.of<DeliveryDetail_Provider>(context,listen: false);

    return Scaffold(
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
        title: const Text("Thêm địa chỉ",
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
          width: width*0.95,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      name = value;
                    });
                  },
                ),
                SizedBox(height: height * 0.01,),
                //Địa chỉ
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
                      address = value;
                    });
                  },
                ),
                SizedBox(height: height * 0.01,),
                //Số điện thoại
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
                      phoneNumber = value;
                    });
                  },
                ),
                SizedBox(height: height * 0.01,),
                //Thêm
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
                      await deliveryDetailProvider.createDeliveryDetail(
                        new DeliveryDetail(
                            ID: 0,
                            deliveryName: name,
                            shipCode: "",
                            description: "",
                            weight: 0,
                            deliveryAddress: address,
                            deliveryContact: phoneNumber,
                            deliveryFee: 0,
                            deliveryId: null)
                      );
                      await deliveryDetailProvider.getAllDeliveryDetail();
                      Navigator.pop(context);
                    },
                    child: const Text("Thêm",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Coiny-Regular-font',
                        fontSize: 16,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}