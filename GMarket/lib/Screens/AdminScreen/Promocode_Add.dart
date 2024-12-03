
import 'package:gmarket/Models/Promocode.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Promocode_Add(),
      )));
}

class Promocode_Add extends StatefulWidget{
  @override
  State createState() {
    return Promocode_Add_State();
  }
}
class Promocode_Add_State extends State<Promocode_Add> {

  late String? name;
  late String? code;
  late String? description;
  TextEditingController startdate=new TextEditingController();
  TextEditingController enddate=new TextEditingController();
  late String? status;
  late String? discounttype;
  late int? discountpercentage;
  late int? minimumordervalue;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final pmProvider=Provider.of<Promocode_Provider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          titleTextStyle: const TextStyle(
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Mũi tên quay lại màu trắng
            onPressed: () {
              Navigator.pop(context); // Quay lại màn hình trước đó
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
        body:Center(
            child: Container(
                color: Colors.white,
                width: width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01,),
                      //Tên mã giảm giá
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Tên mã giảm giá",
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
                      //Mã giảm giá
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Mã giảm giá",
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
                            code = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      //Mô tả
                      TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Mô tả",
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
                            description =value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Trạng thái
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Trạng thái",
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
                            status = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Kiểu giảm giá
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Kiểu giảm giá",
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
                            discounttype = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Tỷ lệ giảm giá
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Tỷ lệ giảm giá",
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
                            discountpercentage = int.parse(value.toString());
                          });
                        },
                      ),
                      //Giá trị đơn hàng tối thiểu
                      SizedBox(height: height * 0.02,),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Giá trị đơn hàng tối thiểu",
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
                            minimumordervalue=int.parse(value);
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Ngày bắt đầu
                      TextField(
                        readOnly: true,
                        controller: startdateController,
                        decoration: InputDecoration(
                          labelText: "Ngày bắt đầu",
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
                        onTap: () => selectstartDate(context),
                      ),
                      SizedBox(height: height * 0.02,),
                      //Ngày kết thúc
                      TextField(
                        readOnly: true,
                        controller: enddateController,
                        decoration: InputDecoration(
                          labelText: "Ngày kết thúc",
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
                        onTap: () => selectendDate(context),
                      ),
                      SizedBox(height: height * 0.02,),
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
                            if(isValid(discountpercentage!)==0){
                              showMessage(context, "Phần trăm không được lớn hơn 100");
                            }
                            else if(isValid(discountpercentage!)==-1){
                              showMessage(context, "Ngày bắt đầu trước ngày kết thúc");
                            }
                            else if(isValid(discountpercentage!)==-2){
                              showMessage(context, "Vui lòng nhập đầy đủ thông tin");
                            }
                            else{
                              pmProvider.createPromoCode(
                                  new PromoCode(name: name, description: description,
                                      status: status, code: code, discounttype: discounttype,
                                      discountpercentage: discountpercentage, enddate: enddate.text,
                                      minimumordervalue: minimumordervalue, startdate:  enddateController.text, ID: 0)
                              );
                              Navigator.pop(context);
                              showMessage(context, "Thêm thành công");
                            }
                          },
                          child: const Text(
                            "Tạo mã giảm giá",
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

  TextEditingController enddateController=new TextEditingController();
  TextEditingController startdateController=new TextEditingController();
  DateTime? start;
  DateTime? end;

  Future<void> selectstartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100), );

    if (picked != null) {
      DateTime pickedWithTime = DateTime( picked.year, picked.month, picked.day, );
      String formattedDate = pickedWithTime.toIso8601String();
      // Định dạng ISO 8601
      setState(() {
        start=picked;
        startdate.text = DateFormat('dd/MM/yyyy').format(picked);
        startdateController.text = formattedDate;
        // sử dụng định dạng này cho việc so sánh
        });
    }
   }
  Future<void> selectendDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100), );
    if (picked != null) {
      DateTime pickedWithTime = DateTime( picked.year, picked.month, picked.day, );
      String formattedDate = pickedWithTime.toIso8601String();
      // Định dạng ISO 8601
      setState(() {
        end=picked;
        enddate.text = DateFormat('dd/MM/yyyy').format(picked);
        enddateController.text = formattedDate;
        // sử dụng định dạng này cho việc so sánh
        });
    }

    }

  int isValid(int percent){
      if(percent>100){
        return 0;
      }
      if(end!.isBefore(start!)){
        return -1;
      }
      if (name == null ||
          code == null ||
          description == null ||
          startdate.text.isEmpty ||
          enddate.text.isEmpty ||
          status == null ||
          discounttype == null ||
          discountpercentage == null ||
          minimumordervalue == null) {
        return -2;
      }
      return 1;
  }
}

