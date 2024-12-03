
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Admin_Screen.dart';
import 'package:gmarket/Screens/AdminScreen/Promocode_Update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Widget/Widget_Promocode_Item.dart';
import 'package:provider/provider.dart';

class Promocode_List extends StatefulWidget{
  @override
  State createState() {
    return Promocode_List_State();
  }
}
class Promocode_List_State extends State<Promocode_List> {
  int page=1;
  int id=0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final promocodeProvider=Provider.of<Promocode_Provider>(context);

    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => AdminScreen(),),
                      (Route<dynamic> route) => false,
                );
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,)
          ),
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          title: const Text("Mã giảm giá",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Coiny-Regular-font',
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: width*0.95,
            child: SingleChildScrollView(
              child:
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: promocodeProvider.promocodes.length,
                    itemBuilder: (context, index) {
                      final pm = promocodeProvider.promocodes[index];
                      return WidgetPromocodeItem(
                        status: pm.status!,
                        name: pm.name!,
                        ID:pm.ID! ,
                        code:pm.code! ,
                        description:pm.description! ,
                        discountpercentage:pm.discountpercentage! ,
                        discounttype:pm.discounttype! ,
                        enddate:pm.enddate! ,
                        minimumordervalue:pm.minimumordervalue! ,
                        startdate:pm.startdate!,
                        onTap: () async{
                          promocodeProvider.setIndex(index);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Promocode_Update(),));
                        },
                      );
                    },
                  ),
                  SizedBox(height: height*0.05,),
                  //xem them
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor:
                  //         const Color.fromRGBO(94, 200, 248, 1)),
                  //     onPressed: () async {
                  //       loading();
                  //       setState(() {
                  //         page++;
                  //       });
                  //       await promocodeProvider.fillOrder(page);
                  //       Navigator.pop(context);
                  //     },
                  //     child: const Text(
                  //       "Xem thêm...",
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 15,
                  //           fontFamily: 'Coiny-Regular-font'),
                  //     )),
                ],

              ),
            ),
          ),
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

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }

}
