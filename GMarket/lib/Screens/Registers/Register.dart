

import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Registers/Information.dart';
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

  UserHTTP user=UserHTTP();
  late String _email;
  late String _password;
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
                child: Center(
                    child: Column(
                      children: [
                        Column(
                          children: [
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
                                hintText: "Verify Password",
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
                            const SizedBox(height: 10,),
                            const SizedBox(height: 20,),
                            ElevatedButton(
                                onPressed:() {
                                  PressNextButton();

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:const Color.fromRGBO(94, 200, 248, 1)
                                ),
                                child: const Text("Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Coiny-Regular-font',
                                    fontSize: 18,
                                  ),)),
                          ],
                        ),
                      ],
                    )
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
  void PressNextButton(){
    if(_password==_verifyPassword){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Information(email: _email, password:_password) )
      );
    }
    else{
      ShowLoginDialog(context);
    }
  }

  void ShowLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title:
            const Text('Lỗi đăng ký'),
        content: const Text('Vui lòng thử lại.'),
        actions: [
        TextButton(
        onPressed: () {
        Navigator.pop(context);
        },
        child:
        const Text('Đóng'),
        ),
        ],
        );
      },
    );
  }
}