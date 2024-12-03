
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widget_Category_Item extends StatelessWidget {
  final String name;
  final String description;
  final int? ID;
  final VoidCallback onTap;

  Widget_Category_Item({
    required this.name,
    required this.description,
    this.ID,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromRGBO(244, 244, 244, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child:Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Center(
            child:Row(
              children: [
                Container(
                  width: width*0.2,
                  height: height*0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(94, 200, 248, 1),
                  ),
                  child: Icon(Icons.category, size: height*0.08, color: Colors.white,),
                ),
                SizedBox(width:width*0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ID
                    Text("ID: ${ID.toString()}",
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
                    //description
                    Text("Mô tả: $description",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,),
                  ],
                ),
              ],
            )
          ),
        )

      ),
    );
  }


}
