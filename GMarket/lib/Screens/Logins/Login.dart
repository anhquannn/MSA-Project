import 'package:flutter/material.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Screens/ForgotPassword/VerifyOTP.dart';
import 'package:gmarket/Screens/Registers/Register.dart';
import 'package:gmarket/Screens/ForgotPassword/ForgotPassword.dart';

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

  late String _email;
  late String _password;

  UserHTTP user = UserHTTP();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(94, 200, 248, 1.0),
          ),
          Positioned(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.asset(
                    'assets/image/QMarket-Blue.jpg',
                    height: height * 0.2,
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
                const SizedBox(
                  height: 20,
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
                      const SizedBox(height: 10),
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
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    if (isChecked) {
                                      isChecked = false;
                                    } else {
                                      isChecked = true;
                                    }
                                  });
                                },
                              ),
                              const Text(
                                "Ghi Nhớ Tôi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(width: width * 0.1),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPassword()));
                                    },
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
                            onPressed: onPressedLoginWithGoogle,
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
        ],
      ),
    );
  }

  void onPressedLogin() {
    if(user.LoginUser(_email, _password)==true){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Register()));
    }
    else{
      ShowLoginDialog(context);
    }
  }

  void onPressedLoginWithGoogle() {}
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
}
