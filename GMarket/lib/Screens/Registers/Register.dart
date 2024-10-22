

import 'package:flutter/material.dart';
import 'package:gmarket/Screens/ForgotPassword/ForgotPassword.dart';
import 'package:gmarket/Screens/Registers/Information.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
    Scaffold(
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
  bool _isObscure= true;
  late var isChecked=false;




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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              child: Image.asset('assets/image/QMarket-White.jpg',
                                height: height*0.4,
                                width: width*0.5,),
                            ),
                            const Text("Đăng Ký",
                              style: TextStyle(
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 30,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10,),
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
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              obscureText: _isObscure,
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
                                        _isObscure ? Icons.visibility_off : Icons.visibility
                                    ),
                                    onPressed: showPassWord
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
                            ),
                            const SizedBox(height: 10,),
                            TextField(
                              obscureText: _isObscure,
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
                                        _isObscure ? Icons.visibility_off : Icons.visibility
                                    ),
                                    onPressed: showPassWord
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
                            ),
                            const SizedBox(height: 10,),
                            const SizedBox(height: 20,),
                            ElevatedButton(
                                onPressed:() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Information() )
                                  );
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
  void showPassWord(){
    setState(() {
      if(_isObscure) {
        _isObscure=false;
      } else {
        _isObscure=true;
      }
    });
  }
}