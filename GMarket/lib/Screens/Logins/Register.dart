

import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Logins/Login.dart';
import 'package:gmarket/Http/User.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: Register(),
    ),
  ));
}

class Register extends StatefulWidget{
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}
class RegisterState extends State<Register>{
  bool _isObscure1= true;
  bool _isObscure2=true;
  late var isChecked=false;

  userHTTP user=userHTTP();
  late String _email;
  late String _password;
  late String _fName;
  late String _lName;
  late String _phoneNumber;
  late String _address;
  late String _verifyPassword;


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;
    return Material(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(255, 255, 255, 1.0),
          ),
          Center(
            child:
            SizedBox(
                width: width*0.9,
                height: height*0.9,
                child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: height*0.05,),
                              Container(
                                child: Image.asset('assets/image/QMarket-White.jpg',
                                  height: height*0.3,
                                  width: width*0.3,),
                              ),
                              const Text("Đăng Ký",
                                style: TextStyle(
                                    fontFamily: 'Coiny-Regular-font',
                                    fontSize: 30,
                                    color: Colors.black
                                ),
                                // textAlign: TextAlign.center,
                              ),
                              SizedBox(height: height*0.05,),
                              TextField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Coiny-Regular-font'
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(94, 200, 248, 1),
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 3.0,
                                            color: Color.fromRGBO(94, 200, 248, 1)))
                                ),
                                onChanged: (value) {
                                  _email=value;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                obscureText: _isObscure1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Coiny-Regular-font',
                                    fontSize: 18,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _isObscure1 ? Icons.visibility_off : Icons.visibility
                                    ),
                                    onPressed: () {
                                      showPassWord1();
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(94, 200, 248, 1),
                                        width: 2.0,)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 3.0,
                                          color: Color.fromRGBO(94, 200, 248, 1)
                                      )
                                  ),
                                ),
                                onChanged: (value) {
                                  _password=value;
                                },
                              ),
                              const SizedBox(height: 10,),
                              TextField(
                                obscureText: _isObscure2,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Xác nhận Password",
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Coiny-Regular-font',
                                    fontSize: 18,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        _isObscure2 ? Icons.visibility_off : Icons.visibility
                                    ),
                                    onPressed: () {
                                      showPassWord2();
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(94, 200, 248, 1),
                                        width: 2.0,
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 2.0,
                                          color: Color.fromRGBO(94, 200, 248, 1)
                                      )
                                  ),
                                ),
                                onChanged: (value) {
                                  _verifyPassword=value;
                                },
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextField(
                                onChanged: (value) {
                                  _fName = value;
                                },
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Họ",
                                    hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Coiny-Regular-font'),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(94, 200, 248, 1),
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 3.0,
                                            color: Color.fromRGBO(94, 200, 248, 1)))),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextField(
                                onChanged: (value) {
                                  _lName = value;
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
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 3.0,
                                            color: Color.fromRGBO(94, 200, 248, 1)))),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextField(
                                onChanged: (value) {
                                  _address = value;
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
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 3.0,
                                            color: Color.fromRGBO(94, 200, 248, 1)))),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _phoneNumber = value;
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
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 3.0,
                                            color: Color.fromRGBO(94, 200, 248, 1)))),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color.fromRGBO(94, 200, 248, 1)),
                                  onPressed: () {
                                    PressOnRegister();
                                  },
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Coiny-Regular-font'),
                                  ))
                            ],
                          ),

                        ],
                      )
                  ),
                )
            ),
          )
        ],
      ) ,
    );

  }
  void showPassWord1(){
    setState(() {
      if(_isObscure1) {
        _isObscure1=false;
      } else {
        _isObscure1=true;
      }
    });
  }
  void showPassWord2(){
    setState(() {
      if(_isObscure2) {
        _isObscure2=false;
      } else {
        _isObscure2=true;
      }
    });
  }
  Future<void> PressOnRegister() async {
    String Fullname=_fName+" "+_lName;
    if(await user.RegisterUser(Fullname, _email, _password, _phoneNumber,_address)){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
    else{
      ShowRegisterDialog(context);
    }
  }
  void ShowRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi đăng ký'),
          content: const Text("Lỗi đăng ký"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}