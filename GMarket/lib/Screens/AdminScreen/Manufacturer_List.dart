
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Manufacturer_Update.dart';
import 'package:gmarket/Screens/Widget/Widget_Manufacturer_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Manufacturer_List extends StatefulWidget{
  const Manufacturer_List({super.key});

  @override
  State createState() {
    return Manufacturer_List_State();
  }
}
class Manufacturer_List_State extends State<Manufacturer_List> {
  bool isLoading=true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);
    itemManufacturer.getAllManufacturer().then((_){
      setState(() {
        isLoading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          title: const Text("Quản Lý Cửa Hàng",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Coiny-Regular-font',
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
         body: Container(
           child: Consumer<Manufacturer_Provider>(
             builder:(context, value, child) {
               return ListView.builder(
                 itemCount: itemManufacturer.listManufacturer.length,
                 itemBuilder: (context, index) {
                   final man = itemManufacturer.listManufacturer[index];
                   return Widget_Manufacturer_Item(
                       name: man.name,
                       address: man.address,
                       contact: man.contact,
                       ID: man.ID,
                       onTap: () {
                         itemManufacturer.getManufacturerById(man.ID);
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) =>
                               Manufacturer_Update(id: man.ID)),
                         );
                       });
                 },
               );
             },)
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
