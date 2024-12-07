
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class Update_UserInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Update_UserInfo_State();
  }
}
class Update_UserInfo_State extends State<Update_UserInfo>{
  late var isChecked=false;
  TextEditingController _lName=new TextEditingController();
  TextEditingController _address=new TextEditingController();
  TextEditingController _phoneNumber=new TextEditingController();

  @override
  void initState() {
    super.initState();
    _lName.text=Provider.of<User_Provider>(context,listen: false).user!.fullname;
    _address.text=Provider.of<User_Provider>(context,listen: false).user!.address;
    _phoneNumber.text=Provider.of<User_Provider>(context,listen: false).user!.phonenumber;
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;
    final userProvider=Provider.of<User_Provider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            await userProvider.getInfoUserById(userProvider.user!.ID);

            Navigator.pop(context);
          },
        ),
        //Cập nhật thông tin
        title: const Text("Cập nhật thông tin",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Coiny-Regular-font',
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body:
          Center(
                child: Container(
                  width: width*0.95,
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  child:
                  Column(
                    children: [
                      SizedBox(height: height*0.02,),
                      //Tên
                      TextField(
                        controller: _lName,
                        onChanged: (value) {
                          _lName.text = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "Tên",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                      ),
                      SizedBox(height: height * 0.01,),
                      //Địa chỉ
                      TextField(
                        controller: _address,
                        onChanged: (value) {
                          _address.text = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "Địa chỉ",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                      ),
                      SizedBox(height: height * 0.01,),
                      //Số điện thoại
                      TextField(
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _phoneNumber.text = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "Số điện thoại",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
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
                            if(isValid(context)==true){
                              await userProvider.updateUserInfo(_lName.text.toString(), _phoneNumber.text.toString(),_address.text.toString());
                               await userProvider.getInfoUserById(userProvider.user!.ID);
                                Navigator.pop(context);
                                showMessage(context, "Cập nhật thông tin thành công");
                            }
                          },
                          child: const Text(
                            "Cập nhật",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                          ))
                    ],
                  ),
                )
          ),
    );

  }
  bool isValid(BuildContext context){
    if(_phoneNumber.text.length<10 ){
      showMessage(context, "Vui lòng nhập đúng số điện thoại");
      return false;
    }
    return true;
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