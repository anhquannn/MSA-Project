
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/User.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: User_Delete(),
      )));
}

class User_Delete extends StatefulWidget{
  @override
  State createState() {
    return User_Delete_State();
  }
}

class User_Delete_State extends State<User_Delete> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController address = TextEditingController();
  int?ID ;

//Lấy dữ liệu
  Future getData(Users u) async {
      setState(() {
        fullname.text = u.fullname;
        email.text = u.email;
        phonenumber.text = u.phonenumber.toString();
        address.text = u.address.toString();
      });

    }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userProvider=Provider.of<User_Provider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
          title: TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              setState(()  async{
                await userProvider.GetUserByNumberPhone(value);
                if(userProvider.usersearch!=null){
                  await getData(userProvider.usersearch!);
                }
              });
            },
            decoration: InputDecoration(
              hintText: "Số điện thoại người dùng",
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(94, 200, 248, 1),
                    width: 3,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    width: 4,
                    color: Color.fromRGBO(94, 200, 248, 1)
                ),
              ),
              prefixIcon: Icon(Icons.search, color: Colors.white,),
            ),
          ),
        ),
        body: Consumer<User_Provider>(
            builder: (context, value, child) {
              return  SingleChildScrollView(
                child: Center(
                    child: Container(
                      color: Colors.white,
                      width: width * 0.9,
                      child: Column(
                        children: [
                          SizedBox(height: height*0.03,),
                          TextField(readOnly: true,
                            controller: fullname,
                            decoration: InputDecoration(
                              labelText: "Họ Tên",
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Coiny-Regular-font'
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 3,
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 2,
                                  )
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(height: height * 0.02,),
                          TextField(
                            readOnly: true,
                            controller: email,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Coiny-Regular-font'
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 3,
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 2,
                                  )
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(height: height * 0.02,),
                          TextField(
                            readOnly: true,
                            controller: address,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Địa chỉ",
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Coiny-Regular-font'
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 3,
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 2,
                                  )
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(height: height * 0.02,),
                          TextField(
                            readOnly: true,
                            controller: phonenumber,
                            decoration: InputDecoration(
                              labelText: "Số điện thoại",
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Coiny-Regular-font'
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 3,
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(94, 200, 248, 1),
                                    width: 2,
                                  )
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                          SizedBox(height: height * 0.02,),
                          //Xóa người dùng
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
                              onPressed: () async{
                                await userProvider.deleteUser(userProvider.usersearch!.ID);
                                Navigator.pop(context);
                                showMessage(context, userProvider.deleteIsSuccess!);
                              },
                              child: const Text(
                                "Xóa người dùng",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),

                          SizedBox(height: height * 0.2,),
                        ],
                      ),
                    )
                ),
              );
                        },
        )
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

