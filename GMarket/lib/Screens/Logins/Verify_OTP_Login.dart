import 'package:flutter/material.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Admin_Screen.dart';
import 'package:gmarket/Screens/CustomerScreen/Home_Screen.dart';
import 'package:provider/provider.dart';


class Verifyotplogin extends StatefulWidget {
  late String email;
  late String pass;
   Verifyotplogin({super.key, required this.email, required this.pass});
  @override
  State<StatefulWidget> createState() {
    return VerifyotploginState();
  }
}

class VerifyotploginState extends State<Verifyotplogin> {
  userHTTP user=userHTTP();
  late String _otp;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userProvider=Provider.of<User_Provider>(context,listen: false);
    final productProvider=Provider.of<ProductProvider>(context,listen: false);
    final cartProvider=Provider.of<Cart_Provider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
          body: Center(
            child: Container(
              color: Colors.white,
              child: Container(
                height: height * 0.9,
                width: width * 0.9,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                child: SingleChildScrollView(
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
                              onPressed: () async {
                                loading();
                                await productProvider.getAllProduct();
                                await userProvider.verifyOTP(_otp);
                                await cartProvider.getOrCreateCartForUser(Provider.of<User_Provider>(context,listen: false).user!.ID) ;
                                Navigator.pop(context);
                                if(userProvider.user!=null){
                                  if(userProvider.user!.role=="admin"){
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => AdminScreen()));
                                  }
                                  else{
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                  }
                                }
                                cartProvider.getOrCreateCartForUser(userProvider.user!.ID);
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

    );
  }
  Future<void> getOtpAgain()async {
    await user.LoginUser(widget.email, widget.pass);
    try {
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (context) => Verifyotplogin(email: widget.email, pass: widget.pass),),
      //       (Route<dynamic> route) => false,
      // );
      Navigator.push(
          context, MaterialPageRoute(
          builder:(context) => Verifyotplogin(email: widget.email, pass: widget.pass),
      ));
    }catch(e){
      throw Exception("Không thể gửi lại $e");
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
