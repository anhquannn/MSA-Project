
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Screens/Logins/Login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: UpdatePassword(),
    ),
  ));
}

class UpdatePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpdatePasswordState();
  }
}

class UpdatePasswordState extends State<UpdatePassword>{
  late String oldPassword;
  late String newPassword;
  late String verifyPassword;
  
  bool flagShow1=true;
  bool flagShow2=true;
  bool flagShow3=true;

  userHTTP user=userHTTP();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  width: width*0.9,
                  height: height*0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: height*0.1),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.asset(
                            'assets/image/QMarket-White.jpg',
                            height: height * 0.2,
                            width: width * 0.3,
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        TextField(
                          obscureText: flagShow1,
                          onChanged: (value) {
                            oldPassword=value.toString();
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Coiny-Regular-font',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                              hintText: "Mật khẩu cũ",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Coiny-Regular-font',
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(94, 200, 248, 1),
                                      width: 2.0
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3.0,
                                      color: Color.fromRGBO(94, 200, 248, 1)
                                  )
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    showOldPassword();
                                  },
                                  icon: Icon(
                                      flagShow1 ? Icons.visibility_off : Icons.visibility
                                  )
                              )
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        TextField(
                          obscureText: flagShow2,
                          onChanged: (value) {
                            newPassword=value.toString();
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Coiny-Regular-font',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                              hintText: "Mật khẩu mới",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Coiny-Regular-font',
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(94, 200, 248, 1),
                                      width: 2.0
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3.0,
                                      color: Color.fromRGBO(94, 200, 248, 1)
                                  )
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    showNewPassword();
                                  },
                                  icon: Icon(flagShow2 ? Icons.visibility_off : Icons.visibility)
                              )
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        TextField(obscureText: flagShow3,
                          onChanged: (value) {
                            verifyPassword=value.toString();
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Coiny-Regular-font',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                              hintText: "Nhập lại mật khẩu mới",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Coiny-Regular-font',
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(94, 200, 248, 1),
                                      width: 2.0
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3.0,
                                      color: Color.fromRGBO(94, 200, 248, 1)
                                  )
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    showVerifyPassword();
                                  },
                                  icon: Icon(flagShow3 ? Icons.visibility_off : Icons.visibility)
                              )
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(94, 200, 248, 1)),
                            onPressed: () {
                              PressOnUpdatePassword();
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
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> PressOnUpdatePassword() async{
    if(newPassword==verifyPassword){
      if(await user.UpdateUserPassword(oldPassword, newPassword)==true){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login(),)
        );
      }
      else{
        ShowErrorUpdateDialog(context);
      }
    }
  }

  void ShowErrorUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi tạo mật khẩu'),
          content: const Text("Không hợp lệ"),
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
  
  void showOldPassword(){
    setState(() {
      if(flagShow1){
        flagShow1=false;
      }
      else{
        flagShow1=true;
      }
    });
  }
  void showNewPassword(){
    setState(() {
      if(flagShow2){
        flagShow2=false;
      }
      else{
        flagShow2=true;
      }
    });
  }
  void showVerifyPassword(){
    setState(() {
      if(flagShow3){
        flagShow3=false;
      }
      else{
        flagShow3=true;
      }
    });
  }
}