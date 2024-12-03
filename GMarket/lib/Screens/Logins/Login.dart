import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Admin_Screen.dart';
import 'package:gmarket/Screens/CustomerScreen/Home_Screen.dart';
import 'package:gmarket/Screens/Logins/Verify_OTP_Login.dart';
import 'package:gmarket/Screens/Logins/Register.dart';
import 'package:gmarket/Screens/Logins/Forgot_Password.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Login(),
    ),
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  bool _isObscure = true;
  late var isChecked = false;

  userHTTP user = userHTTP();
  late String _email;
  late String _password;

  final FlutterSecureStorage secureStorage=FlutterSecureStorage();
  bool remember=false;

  String? Token;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: const Color.fromRGBO(94, 200, 248, 1.0),
          ),
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height*0.05,),
                  Container(
                    child: Image.asset(
                      'assets/image/QMarket-Blue.jpg',
                      height: height * 0.3,
                      width: width * 0.3,
                    ),
                  ),
                  const Text(
                    "Đăng Nhập",
                    style: TextStyle(
                        fontFamily: 'Coiny-Regular-font',
                        fontSize: 30,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Coiny-Regular-font',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Coiny-Regular-font'),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3.0, color: Colors.white))),
                          onChanged: (value) {
                            _email = value.toString();
                          },
                        ),
                        SizedBox(height: height*0.01),
                        TextField(
                          obscureText: _isObscure,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Coiny-Regular-font',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: "Mật Khẩu",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Coiny-Regular-font',
                              fontSize: 18,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: showPassWord),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3.0, color: Colors.white)),
                          ),
                          onChanged: (value) {
                            _password = value.toString();
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));},
                                      child: const Text(
                                        "Quên mật khẩu",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Coiny-Regular-font',
                                            fontSize: 13,
                                            decoration: TextDecoration.underline),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // productProvider.getAllProduct();

                                onPressedLogin();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: Size(width * 0.07, height * 0.05),
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(
                                    width: 2.0, color: Colors.white),
                              ),
                              child: const Center(
                                child: Text(
                                  "Đăng Nhập",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Coiny-Regular-font',
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const Text(
                              "Hoặc",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Coiny-Regular-font',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                loading();
                                signInWithGoogle();
                                Navigator.pop(context);


                                // signOut();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: Size(width * 0.07, height * 0.05),
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(
                                    width: 2.0, color: Colors.white),
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageIcon(
                                      AssetImage('assets/icons/google-icon.png'),
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Với Google",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Coiny-Regular-font',
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          child: const Text(
                            "Đăng ký",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Coiny-Regular-font',
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

          )
        ],
      ),
    );
  }

  Future onPressedLogin() async {
    if(await user.LoginUser(_email, _password)==true){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Verifyotplogin(email: _email, pass: _password)));
    }
    else{
      ShowLoginDialog(context);
    }
  }

  void showPassWord() {
    setState(() {
      if (_isObscure) {
        _isObscure = false;
      } else {
        _isObscure = true;
      }
    });
  }

  void ShowLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi đăng nhập'),
          content: const Text(
              'Tên đăng nhập hoặc mật khẩu không đúng. Vui lòng thử lại.'),
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

  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future signInWithGoogle() async {
    loading();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      String? accessToken = googleAuth.accessToken;
      await userHTTP().SaveToken(accessToken!);
      setState(() {
       Token=accessToken;
      });
      await Provider.of<User_Provider>(context,listen: false).loginWithGoogle(accessToken);
      await Provider.of<Cart_Provider>(context,listen: false).getOrCreateCartForUser(Provider.of<User_Provider>(context,listen: false).user!.ID) ;
      await Provider.of<ProductProvider>(context,listen: false).getAllProduct();
      Navigator.pop(context);
      if(Provider.of<User_Provider>(context,listen: false).user!.role=="admin"){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminScreen()));
      }
      else{
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }

        } catch (error) {
      print("Lỗi đăng nhập Google: $error");
    }

  }

  Future<void> signOut() async {
      await _googleSignIn.signOut();
      print("Đã đăng xuất khỏi Google.");
    }

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}
