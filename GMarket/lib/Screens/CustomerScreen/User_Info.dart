
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/Box_Chat.dart';
import 'package:gmarket/Screens/CustomerScreen/Change_Password.dart';
import 'package:gmarket/Screens/CustomerScreen/Home_Screen.dart';
import 'package:gmarket/Screens/CustomerScreen/Order_List.dart';
import 'package:gmarket/Screens/CustomerScreen/Update_UserInfo.dart';
import 'package:gmarket/Screens/Logins/Login.dart';
import 'package:provider/provider.dart';

class User_Info extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return User_Info_State();
  }
}
class User_Info_State extends State<User_Info>{
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    final userProvider=Provider.of<User_Provider>(context);
    final orderProvider=Provider.of<Order_Provider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => HomeScreen(),),
                  (Route<dynamic> route) => false,
            );
          },
            icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
        )
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            //Anh dai dien
            Container(
              color: Color.fromRGBO(94, 200, 248, 1),
              width: width*1,
              height: height*0.1,
              //Hinh anh
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.account_circle_sharp, size: height*0.1, color: Color.fromRGBO(128, 128, 128, 1),)
                  ),
                  //Ten nguoi dung
                  SizedBox(width: width*0.02,),
                  Text('${userProvider.user!.fullname}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Coiny-Regular-font',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.01,),
            //Chinh sua thong tin ca nhan
            ElevatedButton(
                onPressed: () async {
                  await userProvider.getInfoUserById(userProvider.user!.ID);
                  print("${userProvider.user!.fullname}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Update_UserInfo(),)
                  );
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.black,
                minimumSize: Size(width*1, height*0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 0.2
                  )
                )
              ),
                child: Row(
                  children: [
                    const Text("Chỉnh sửa thông tin cá nhân",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Coiny-Regular-font',
                        color: Colors.black
                      ),
                    ),
                    SizedBox(width: width*0.15,),
                    const Align(alignment: Alignment.centerRight,
                    child:Icon(Icons.arrow_forward,
                      color: Colors.black,),
                    )
                  ],
                ),
            ),
            SizedBox(height: height*0.01,),
            //Xem don hang
            ElevatedButton(
              onPressed: () async {
                loading();
                await orderProvider.getOrderPending(userProvider.user!.ID);
                await orderProvider.getOrderPaying(userProvider.user!.ID);
                await orderProvider.getOrderDelivering(userProvider.user!.ID);
                await orderProvider.getOrderSuccess(userProvider.user!.ID);
                await orderProvider.getOrderReturned(userProvider.user!.ID);
                Navigator.pop(context);
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => Order_Info(),)
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black,
                  minimumSize: Size(width*1, height*0.08),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(
                          color: Colors.black,
                          width: 0.2
                      )
                  )
              ),
              child: Row(
                children: [
                  const Text("Xem đơn hàng",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Coiny-Regular-font',
                        color: Colors.black
                    ),
                  ),
                  SizedBox(width: width*0.47,),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward,
                      color: Colors.black,)
                  )

                ],
              ),
            ),
            SizedBox(height: height*0.01,),
            //Doi mat khau
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Change_Password(),)
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black,
                  minimumSize: Size(width*1, height*0.08),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(
                          color: Colors.black,
                          width: 0.2
                      )
                  )
              ),
                //Đổi mật khẩu
              child: Row(
                children: [
                  const Text("Đổi mật khẩu",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Coiny-Regular-font',
                        color: Colors.black
                    ),
                  ),
                  SizedBox(width: width*0.495,),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward,
                      color: Colors.black,) ,
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.01,),
            //Hỗ trợ
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Box_Chat(),)
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black,
                  minimumSize: Size(width*1, height*0.08),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(
                          color: Colors.black,
                          width: 0.2
                      )
                  )
              ),
              child: Row(
                children: [
                  const Text("Hỗ trợ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Coiny-Regular-font',
                        color: Colors.black
                    ),
                  ),
                  SizedBox(width: width*0.63,),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward,
                      color: Colors.black,) ,
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.01,),
            //dang xuat2
            ElevatedButton(
              onPressed: () async {
                userProvider.clearUser();
                Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) => Login(),),
                        (Route<dynamic> route) => false,
                );
              },
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
              child: const Text("Đăng xuất",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Coiny-Regular-font',
                    color: Colors.black
                ),
              ),
            ),
            SizedBox(height: height*0.01,),
          ],
        ),
      ),
    );
  }
  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}