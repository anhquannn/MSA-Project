
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/FeedBack.dart';
import 'package:gmarket/Provider/FeedBack_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Order_List.dart';
import 'package:gmarket/Screens/CustomerScreen/Order_List.dart';
import 'package:provider/provider.dart';


class Create_Feedback extends StatefulWidget{
  @override
  State createState() {
    return Create_Feedback_State();
  }
}
class Create_Feedback_State extends State<Create_Feedback> {
  int rating=5;
  String comment="";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemFeedback=Provider.of<FeedBack_Provider>(context,listen: false);
    final itemUser=Provider.of<User_Provider>(context,listen: false);
    final itemOrder=Provider.of<Order_Provider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Mũi tên quay lại màu trắng
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước đó
          },
        ),
        title: const Text("Tạo đánh giá",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            color: Colors.white,
            width: width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.01,),
                  //Sao danh gia
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        return IconButton(
                            onPressed: () {
                              setState(() {
                                rating=index+1;
                              });
                            },
                            icon: Icon(
                              index < rating ? Icons.star : Icons.star_border, color: index < rating ? Colors.yellow : Colors.grey,
                            )
                        );
                        },)

                    ),
                  ),
                  SizedBox(height: height * 0.01,),
                  //Binh luan
                  TextField(
                    minLines: 1,
                   maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Đánh giá sản phẩm",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Coiny-Regular-font'
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(94, 200, 248, 1),
                            width: 2,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(94, 200, 248, 1),
                            width: 1,
                          )
                      ),
                    ),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),
                    onChanged: (value) {
                      setState(() {
                        comment = value;
                      });
                    },
                  ),
                  SizedBox(height: height * 0.01,),
                  //Tao danh gia
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
                        for(int i=0;i<itemOrder.list_idproduct.length;i++){
                          itemFeedback.createFeedback(
                              FeedBack(
                                  rating: rating,
                                  comments: comment,
                                  user_id: itemUser.user!.ID,
                                  product_id: itemOrder.list_idproduct[i],
                                  ID: 0)
                          );
                        }
                        itemOrder.clearListIdProduct();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Order_Info(),),
                              (Route<dynamic> route) => false,);
                      },
                      child: const Text("Tạo đánh giá",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Coiny-Regular-font',
                        ),
                      )
                  ),
                  SizedBox(height: height * 0.01,),

                ],
              ),
            )
        ),
      ),
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
