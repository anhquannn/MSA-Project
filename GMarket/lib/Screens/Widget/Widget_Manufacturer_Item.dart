
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Manufacturer_Item extends StatelessWidget {
  final String name;
  final String address;
  final String contact;
  final int? ID;
  final VoidCallback onTap;

  Widget_Manufacturer_Item({
    required this.name,
    required this.address,
    required this.contact,
    this.ID,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromRGBO(244, 244, 244, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(94, 200, 248, 1)
                ),
                height: height*0.1,
                child: Icon(Icons.precision_manufacturing, color: Colors.white,size: height*0.095,),
              ),
              SizedBox(width: width*0.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ID
                  Text("ID:${ID.toString()}",
                    textAlign: TextAlign.center,

                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  //name
                  Text("Tên: $name",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  //address
                  Text("Địa chỉ: $address",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                  //contact
                  Text("Liên hệ: $contact",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                ],
              ),
            ],
          )
         
        )


      ),
    );
  }


}
