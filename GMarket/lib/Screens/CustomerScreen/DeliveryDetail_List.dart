import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/DeliveryDetail.dart';
import 'package:gmarket/Provider/DeliveryDetail_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/DeliveryDetail_Add.dart';
import 'package:gmarket/Screens/CustomerScreen/Update_UserInfo.dart';
import 'package:provider/provider.dart';

class DeliveryDetail_List extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DeliveryDetail_List_State();
  }

}
class DeliveryDetail_List_State extends State<DeliveryDetail_List>{
  bool isDefault=true;
  List<bool> notDefault=[];

  @override
  void initState() {
    super.initState();
    final deliveryDetailProvider= Provider.of<DeliveryDetail_Provider>(context,listen: false);
    if(deliveryDetailProvider.deliveryDetail==null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Update_UserInfo(),));
    }
    try{
      for(int i=0;i<deliveryDetailProvider.deliveryDetails.length;i++){
        if(deliveryDetailProvider.deliveryDetails[i].ID==deliveryDetailProvider.deliveryDetail!.ID){
          notDefault.add(true);
          isDefault=false;
        }
        else{
          notDefault.add(false);
        }
      }
    }catch(e){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Update_UserInfo(),));
    }

  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userProvider = Provider.of<User_Provider>(context,listen: false);
    final deliveryDetailProvider = Provider.of<DeliveryDetail_Provider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      //Chọn địa ch
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if(isDefault==true){
              deliveryDetailProvider.setDeliveryDetail(
                  new DeliveryDetail(
                      ID: 0,
                      deliveryName: userProvider.user!.fullname,
                      shipCode: "",
                      description: "",
                      weight: 0,
                      deliveryAddress: userProvider.user!.address,
                      deliveryContact: userProvider.user!.phonenumber,
                      deliveryFee: 0,
                      deliveryId: null));
              Navigator.pop(context);
            }
            else if(notDefault.contains(true)){
              Navigator.pop(context);
            }
            else{
              showMessage(context, "Vui lòng chọn địa chỉ");
            }
          },
        ),
        title: const Text("Chọn địa chỉ",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child:Container(
          width: width*0.95,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //dia chi mac dinh
                Container(
                  margin: EdgeInsets.all(5),
                  width: width*0.95,
                  height: height*0.18,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(94, 200, 248, 1),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Thong tin dia chi
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Tên
                            Text("Tên: ${userProvider.user!.fullname}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            //Địa chỉ
                            Text("Địa chỉ: ${userProvider.user!.address}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            //Số điện thoại
                            Text("Số điện thoại: ${userProvider.user!.phonenumber}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                          ],
                        ),
                      ),
                      //Checkbox chon dia chi mac dinh
                      Container(
                        child: Checkbox(
                          focusColor: Color.fromRGBO(94, 200, 248, 1),
                          activeColor: Color.fromRGBO(94, 200, 248, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          value: isDefault,
                          onChanged: (value) {
                            if(notDefault.contains(true)){
                              notDefault.fillRange(0, notDefault.length,false);
                            }
                            setState(() {
                              isDefault=value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //chon cac dia chi khac
                Container(
                  child: ListView.builder(
                    itemCount: deliveryDetailProvider.deliveryDetails.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final detail=deliveryDetailProvider.deliveryDetails[index];
                        return Container(
                          width: width*0.95,
                          height: height*0.18,
                          child:Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(94, 200, 248, 1),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Thong tin dia chi
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Tên
                                      Text("Tên: ${detail.deliveryName}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      //Địa chỉ
                                      Text("Địa chỉ: ${detail.deliveryAddress}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                      //Số điện thoại
                                      Text("Số điện thoại: ${detail.deliveryContact}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: height*0.01,),
                                    ],
                                  ),
                                ),
                                //Checkbox chon dia chi mac dinh
                                Container(
                                  child: Checkbox(
                                    focusColor: Color.fromRGBO(94, 200, 248, 1),
                                    activeColor: Color.fromRGBO(94, 200, 248, 1),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    value: notDefault[index],
                                    onChanged: (value) {
                                      if(value==true){
                                        notDefault.fillRange(0, notDefault.length,false);
                                        deliveryDetailProvider.setDeliveryDetail(detail);
                                      }
                                      setState(() {
                                        notDefault[index]=value!;
                                      });
                                      notDefault.contains(true)?isDefault=false:isDefault=true;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        );
                      },
                  )
                ),
                //them dia chi
                Container(
                  child: ElevatedButton(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDetail_Add(),));
                      },
                      child: const Text("Thêm địa chỉ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        )

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