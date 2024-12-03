import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class User_List extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return User_List_State();
  }

}
class User_List_State extends State<User_List>{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userProvider=Provider.of<User_Provider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
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
        title:const Text("Danh sách người dùng",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width*0.95,
            child: ListView.builder(
              itemCount: userProvider.listUser!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final user=userProvider.listUser?[index];
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromRGBO(94, 200, 248, 1)
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //id
                        Text("Mã khách hàng: ${user!.ID}", style: TextStyle(color: Colors.black, fontSize: 14),),
                        //ten
                        Text("Tên khách hàng: ${user.fullname}", style: TextStyle(color: Colors.black, fontSize: 14),),
                        //email
                        Text("Email khách hàng: ${user.email}", style: TextStyle(color: Colors.black, fontSize: 14),),
                        //so dien thoai
                        Text("Số điện thoại: ${user.phonenumber}", style: TextStyle(color: Colors.black, fontSize: 14),),
                        //dia chi
                        Text("Địa chỉ: ${user.address}", style: TextStyle(color: Colors.black, fontSize: 14),),
                        SizedBox(height: height*0.01,),
                        //xoa khach hang
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                onPressed: () async {
                                  loading();
                                  await userProvider.deleteUser(user.ID);
                                  showMessage(context, userProvider.deleteIsSuccess!);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Xóa khách hàng",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Coiny-Regular-font'),
                                )),
                          ],
                        ),

                      ],
                    ),
                  );
                },
            ),
          ),
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