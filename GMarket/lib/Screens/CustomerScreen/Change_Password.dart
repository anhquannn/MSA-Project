
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class Change_Password extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Change_Password_State();
  }
}

class Change_Password_State extends State<Change_Password>{
  String? oldPassword;
  String? newPassword;
  String? verifyPassword;

  bool flagShow1=true;
  bool flagShow2=true;
  bool flagShow3=true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userrovider=Provider.of<User_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Đổi mật khẩu",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
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
                          //mat khau cu
                          TextField(
                            obscureText: flagShow1,
                            onChanged: (value) {
                              setState(() {
                                oldPassword=value.toString();
                              });
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Coiny-Regular-font',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                hintText: "Mật khẩu cũ",
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(94, 200, 248, 1),
                                        width: 2.0
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 3.0,
                                        color: Color.fromRGBO(94, 200, 248, 1)
                                    )
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      showOldPassword();
                                    },
                                    icon: Icon(flagShow1 ? Icons.visibility_off : Icons.visibility)
                                )
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          //mat khau moi
                          TextField(
                            obscureText: flagShow2,
                            onChanged: (value) {
                              setState(() {
                                newPassword=value.toString();
                              });
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Coiny-Regular-font',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                hintText: "Mật khẩu mới",
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Coiny-Regular-font',
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(94, 200, 248, 1),
                                        width: 2.0
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
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
                          //xac thuc mat khau moi

                          TextField(
                            obscureText: flagShow3,
                            onChanged: (value) {
                              verifyPassword=value.toString();
                            },
                            style: const TextStyle(
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
                                  backgroundColor: Color.fromRGBO(94, 200, 248, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                          color: Colors.black,
                                          width: 0.2
                                      )
                                  )
                              ),
                              onPressed: () {
                                print(isValid(context));
                                if(isValid(context)==true){
                                  userrovider.changePassword(oldPassword!, newPassword!).then((_){
                                    if(userrovider.isLoading==false){
                                      Navigator.pop(context);
                                      showMessage(context, "Đổi mật khẩu thành công");
                                    }
                                  });
                                }
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
  bool isValid(BuildContext contenxt){
    if(oldPassword==null || newPassword==null || verifyPassword==null ){
      showMessage(context, "Vui lòng nhập đầy đủ thông tin");
      return false;
    }
    if(newPassword!=verifyPassword){
      showMessage(context, "Mật khẩu không khớp");
      return false;
    }
    return true;
  }
}