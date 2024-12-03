
import 'package:gmarket/Http/PromoCode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Promocode_Delete extends StatefulWidget{
  @override
  State createState() {
    return Promocode_Delete_State();
  }
}

class Promocode_Delete_State extends State<Promocode_Delete> {
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

  Future getData(int id) async {
    final pc=await promoCodeHttp().getPromoCodeById(id);
    if(pc!=null){
      setState(() {
        id=pc.ID!;
        name.text = pc.name.toString();
        code.text = pc.code!;
        description.text = pc.description.toString();
        startdate.text = pc.startdate.toString();
        enddate.text = pc.enddate.toString();
        status.text = pc.status.toString();
        discounttype.text = pc.discounttype!;
        discountpercentage.text = pc.discountpercentage.toString();
        minimumordervalue.text = pc.minimumordervalue.toString();
      });
    }
    else{
      print("Không thể lấy PromoCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          titleTextStyle: const TextStyle(
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            // Mũi tên quay lại màu trắng
            onPressed: () {
              Navigator.pop(context); // Quay lại màn hình trước đó
            },
          ),
          title: TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              setState(()  async{
                id=int.parse(value);
                await getData(int.parse(value));
              });
            },
            decoration: InputDecoration(
              hintText: "Tìm kiếm Id",
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(94, 200, 248, 1),
                    width: 3,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    width: 4,
                    color: Color.fromRGBO(94, 200, 248, 1)
                ),
              ),
              prefixIcon: Icon(Icons.search, color: Colors.white,),
            ),
          ),
        ),
        body: Center(
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
                          TextField(readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
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
                            readOnly: true,
                            controller: discountpercentage,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
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
                              });
                            },
                          ),
                          SizedBox(height: height * 0.02,),
                          //Giá trị tối thiểu
                          TextField(
                            readOnly: true,
                            controller: minimumordervalue,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
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
                            readOnly: true,
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
                                onPressedDeletePromocode();
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

  Future onPressedDeletePromocode() async{
    if(await promoCodeHttp().deletePromoCode(id!)==true){
      Navigator.pop(context);
      showMessage(context, "Xóa mã sản phẩm thành công");
    }
    else{
      showMessage(context, "Xóa mã sản phẩm  không thành công");
    }
  }
}

