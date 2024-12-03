
import 'package:gmarket/Http/PromoCode.dart';
import 'package:gmarket/Models/Promocode.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Admin_Screen.dart';
import 'package:gmarket/Screens/AdminScreen/Order_List.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_List.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Promocode_Update extends StatefulWidget{
  @override
  State createState() {
    return Promocode_Update_State();
  }
}

class Promocode_Update_State extends State<Promocode_Update> {
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController discounttype = TextEditingController();
  TextEditingController discountpercentage = TextEditingController();
  TextEditingController minimumordervalue = TextEditingController();
  TextEditingController startdate= TextEditingController();
  TextEditingController enddate= TextEditingController();
  int?id;

  @override
  void initState() {
    super.initState();
    final pm=Provider.of<Promocode_Provider>(context,listen: false);
    setState(() {
      id=pm.promocodes[pm.index].ID;
      name.text=pm.promocodes[pm.index].name!;
      code.text=pm.promocodes[pm.index].code!;
      description.text=pm.promocodes[pm.index].description!;
      status.text=pm.promocodes[pm.index].status!;
      discounttype.text=pm.promocodes[pm.index].discounttype!;
      discountpercentage.text=pm.promocodes[pm.index].discountpercentage!.toString();
      minimumordervalue.text=pm.promocodes[pm.index].minimumordervalue!.toString();
      startdate.text=pm.promocodes[pm.index].startdate!;
      enddate.text=pm.promocodes[pm.index].enddate!;
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final promocodeProvider=Provider.of<Promocode_Provider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        title: const Text("Mã giảm giá",
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
                      Column(
                        children: [
                          SizedBox(height: height*0.02,),
                          //Tên mã giảm giá
                          TextField(
                            controller: name,
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
                                name.text = value;
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Mã giảm giá
                          TextField(
                            controller: code,
                            keyboardType: TextInputType.number,
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
                                code.text = value;
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Mô tả
                          TextField(
                            controller: description,
                            keyboardType: TextInputType.number,
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
                                description.text = int.parse(value).toString();
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Trạng thái
                          TextField(
                            controller: status,
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
                                status.text = value;
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Loại giảm giá
                          TextField(
                            controller: discounttype,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              labelText: "Loại giảm giá",
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
                                discounttype.text = value;
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Phần trăm giảm giá
                          TextField(
                            controller: discountpercentage,
                            maxLines: null,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Phần trăm giảm giá",
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
                                discountpercentage.text = value;
                                print('Ma giam gia $value');
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Giá trị tối thiểu
                          TextField(
                            controller: minimumordervalue,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Giá trị tối thiểu",
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
                                minimumordervalue.text = value;
                              });
                            },
                          ),
                          //Ngày bắt đầu
                          SizedBox(height: height * 0.02,),
                          TextField(
                            controller: startdate,
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
                            onTap: () {
                              getDate(1);
                            },
                          ),
                          //Ngày kết thúc
                          SizedBox(height: height * 0.02,),
                          TextField(
                            readOnly: true,
                            controller: enddate,
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
                            onTap: () {
                              getDate(2);
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Cap nhat
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
                              onPressed: ()async {
                                loading();
                                await promocodeProvider.updatePromoCode(
                                  new PromoCode(
                                      ID: id,
                                      name: name.text,
                                      description: description.text,
                                      status: status.text, code: code.text,
                                      discounttype: discounttype.text,
                                      discountpercentage: int.parse(discountpercentage.text),
                                      enddate: enddate.text,
                                      minimumordervalue: int.parse(minimumordervalue.text),
                                      startdate: startdate.text
                                  )
                                );
                                await promocodeProvider.getAllPromoCode();
                                showMessage(context, "Cập nhật mã giảm giá thành công");
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => Promocode_List(),),
                                      (Route<dynamic> route) => false,
                                );

                              },
                              child: const Text(
                                "Cập nhật mã giảm giá",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),
                          SizedBox(height: height * 0.02,),
                          //Xoa ma giam gia
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
                                loading();
                                await promocodeProvider.deletePromoCode(id!);
                                await promocodeProvider.getAllPromoCode();
                                showMessage(context, "Xóa mã giảm giá thành công");
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => Promocode_List(),),
                                      (Route<dynamic> route) => false,
                                );
                              },
                              child: const Text(
                                "Xóa mã giảm giá",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),
                          SizedBox(height: height * 0.2,),
                        ],
                      )
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

  Future<void> getDate(int type) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Kết hợp ngày được chọn với giờ hiện tại để có đầy đủ thời gian
      DateTime pickedWithTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );

      setState(() {
        if(type==1){
          startdate.text= DateFormat('dd/MM/yyyy').format(picked);
        }
        else if(type==2){
          enddate.text= DateFormat('dd/MM/yyyy').format(picked);
        }// Hiển thị định dạng ngắn gọn
      });
    }
  }

  Future onPressedUpdatePromocode() async{
    if(await promoCodeHttp().updatePromoCode(
        new PromoCode(ID:id,name: name.text, description: description.text,
            status: status.text, code: code.text, discounttype: discounttype.text,
            discountpercentage: int.parse(discountpercentage.text) , enddate: enddate.text.toString(),
            minimumordervalue: int.parse(minimumordervalue.text), startdate: startdate.text.toString()))==true){
      Navigator.pop(context);
      showMessage(context, "Sửa mã giảm giá thành công");
    }
    else{
      showMessage(context, "Sửa mã giảm giá không thành công");
    }
  }

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}

