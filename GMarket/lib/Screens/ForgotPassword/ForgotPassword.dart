
import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Logins/Login.dart';
import 'package:gmarket/Screens/Logins/VerifyOTP.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
    Scaffold(
      body: ForgotPassword(),
    ),

  ));
}

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() {

    return ForgotPasswordState();
  }
}
class ForgotPasswordState extends State<ForgotPassword>{
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
          Positioned(
            child: Column(
              children: [
                SizedBox(height: height*0.1,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.asset('assets/image/QMarket-White.jpg',
                    height: height*0.4,
                    width: width*0.5,),
                ),
                const Text("Quên Mật Khẩu",
                  style: TextStyle(
                      fontFamily: 'Coiny-Regular-font',
                      fontSize: 30,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height*0.05,),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20,
                      right: 20
                  ),
                  child: Column(
                    children: [
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
                                  color: Color.fromRGBO(94 , 200, 248, 1),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 3.0,
                                    color: Color.fromRGBO(94 , 200, 248, 1)))
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      ElevatedButton(
                          onPressed:() {
                            GetPassword();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:const Color.fromRGBO(94, 200, 248, 1)
                          ),
                          child: const Text("Tiếp Theo",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Coiny-Regular-font',
                              fontSize: 18,
                            ),)),
                    ],
                  ),

                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  void GetPassword(){
    //get passwpord
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login() )
    );

  }
}