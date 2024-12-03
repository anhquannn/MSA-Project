
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/User_Delete.dart';
import 'package:gmarket/Screens/AdminScreen/User_List.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Widget_User(),
    ),
  ));
}

class Widget_User extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Widget_User_Sate();
  }
}
class Widget_User_Sate extends State<Widget_User>{

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final userProvider=Provider.of<User_Provider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: Center(
          child:Container(
            width: width*0.9,
            child: SingleChildScrollView(
                child: Center(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Xóa người dùng
                      ElevatedButton(
                        onPressed: () async{
                          loading();
                          await userProvider.getAllUsers();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => User_Delete(),)
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                          fixedSize: Size(width * 0.4, width * 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.grey[300],
                          elevation: 7,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Color.fromRGBO(94, 200, 248, 1),
                              size: width * 0.2,
                            ),
                            const Center(
                              child: Text(
                                "Xóa người dùng",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Coiny-Regular-font',
                                  color: Colors.black,
                                ),textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      //danh sach nguoi dung
                      ElevatedButton(
                        onPressed: () async{
                          loading();
                          await userProvider.getAllUsers();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => User_List(),)
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(240, 248, 255, 1),
                          fixedSize: Size(width * 0.4, width * 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.grey[300],
                          elevation: 7,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.list,
                              color: const Color.fromRGBO(94, 200, 248, 1),
                              size: width * 0.2,
                            ),
                            const Center(
                              child: Text(
                                "Danh sách\nngười dùng",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Coiny-Regular-font',
                                  color: Colors.black,
                                ),textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )

                )
            ),
          )


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
