import 'package:flutter/material.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Screens/AdminScreen/AdminScreen.dart';
import 'package:gmarket/Screens/CustomerScreen/HomeScreen.dart';
import 'package:gmarket/Screens/Logins/UpdatePassword.dart';
import 'package:gmarket/Screens/Logins/Register.dart';
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Scaffold(
//       body: Verifyotp(email: '',),
//     ),
//   ));
// }

class Verifyotplogin extends StatefulWidget {
  late String email;
  late String pass;
   Verifyotplogin({super.key, required this.email, required this.pass});
  @override
  State<StatefulWidget> createState() {
    return VerifyotpState();
  }
}

class VerifyotpState extends State<Verifyotplogin> {
  userHTTP user=userHTTP();
  late String _otp;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: height * 0.9,
                width: width * 0.9,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                child: Positioned(
                    child:SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: height*0.05,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: Image.asset(
                              'assets/image/QMarket-White.jpg',
                              height: height * 0.3,
                              width: width * 0.3,
                            ),
                          ),
                          const Text(
                            "Nhập Mã OTP",
                            style: TextStyle(
                                fontFamily: 'Coiny-Regular-font',
                                fontSize: 30,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _otp=value.toString();
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Coiny-Regular-font',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                hintText: "OTP Code",
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
                          // const Text(
                          //   "Gửi lại mã",
                          //   style: TextStyle(
                          //       fontFamily: 'Coiny-Regular-font',
                          //       fontSize: 15,
                          //       color: Colors.black,
                          //       decoration: TextDecoration.underline),
                          //   textAlign: TextAlign.center,
                          // ),
                          Center(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    getOtpAgain();
                                  },
                                  child: const Text(
                                    "Gửi lại mã",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Coiny-Regular-font',
                                        fontSize: 13,
                                        decoration: TextDecoration.underline),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(94, 200, 248, 1)),
                              onPressed: () {
                                OnPressNext();
                              },
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> OnPressNext() async {
    if(await user.verifyOTP(_otp)==1) {
      final a= await user.GetUserId();
      print("user Id $a");
      Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => AdminScreen()));
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
  Future<void> getOtpAgain()async {
    await user.LoginUser(widget.email, widget.pass);
    try {
      Navigator.push(
          context, MaterialPageRoute(
          builder:(context) => Verifyotplogin(email: widget.email, pass: widget.pass),
      ));
    }catch(e){
      throw Exception("Không thể gửi lại $e");
    }
  }
}
