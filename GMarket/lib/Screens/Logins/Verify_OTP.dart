import 'package:flutter/material.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/Logins/Update_Password.dart';
import 'package:provider/provider.dart';

class Verifyotp extends StatefulWidget {
  late String email;
   Verifyotp({super.key, required this.email});
  @override
  State<StatefulWidget> createState() {
    return VerifyotpState();
  }
}

class VerifyotpState extends State<Verifyotp> {
  userHTTP user=userHTTP();
  late String _otp;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userProvider=Provider.of<User_Provider>(context);
    final cartProvider=Provider.of<Cart_Provider>(context);

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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: height*0.005,),
                          Container(
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
                          //Gửi lại mã
                          const Text(
                            "Gửi lại mã",
                            style: TextStyle(
                                fontFamily: 'Coiny-Regular-font',
                                fontSize: 15,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(94, 200, 248, 1)),
                              onPressed: () {
                                if(_otp.isEmpty){
                                  showMessage(context, "Chưa nhập mã OTP");
                                }
                                else{
                                  userProvider.verifyOTP(_otp).then((_){
                                    if(userProvider.user!=null){
                                      cartProvider.getOrCreateCartForUser(userProvider.user!.ID);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => UpdatePassword(),),
                                          (Route<dynamic> route) => false
                                      );
                                    }
                                  });
                                }
                              },
                              child: const Text(
                                "Tiếp theo",
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
