import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class WidgetPromocodeItem extends StatefulWidget{
  final int ID;
  final String name;
  final String code;
  final String description;
  final String startdate;
  final String enddate;
  final String status;
  final String discounttype;
  final int discountpercentage;
  final int minimumordervalue;
  final VoidCallback onTap;
  WidgetPromocodeItem({
    required this.ID,
    required this.name,
    required this.code,
    required this.description,
    required this.startdate,
    required this.enddate,
    required this.status,
    required this.discounttype,
    required this.discountpercentage,
    required this.minimumordervalue,
    required this.onTap,
  });
  @override
  State<StatefulWidget> createState() {
    return WidgetPromocodeItem_State();
  }

}
class WidgetPromocodeItem_State extends State<WidgetPromocodeItem>{


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: widget.onTap,
        child: Card(
            color: Color.fromRGBO(244, 244, 244, 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
              width: width*0.95,
              height: height*0.155,
              child: Row(
                children: [
                  Container(
                    width: width*0.3,
                    height: height*0.153,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(94, 200, 248, 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Icon(Icons.card_giftcard_sharp, color: Colors.white,size: height*0.09,),
                  ),
                  SizedBox(width: width*0.01,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Tên mã giảm giá
                      Text("${widget.name}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                      //Mã giảm giá
                      Text("${widget.code}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                      //Trạng thái
                      Text("${widget.status}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                      //Tỷ lệ giảm giá
                      Text("${widget.discountpercentage}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                      //Giá trị đơn hàng tối thiểu
                      SizedBox(height: height * 0.01,),
                      Text("${widget.minimumordervalue}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        )
    );
  }
// Future<void> selectstartDate(BuildContext context) async {
//   DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100), );
//   setState(() {
//     start=picked;
//     startdate.text = DateFormat('dd/MM/yyyy').format(picked!);
//   });
// }
// Future<void> selectendDate(BuildContext context) async {
//   DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100), );
//   setState(() {
//     end=picked;
//     enddate.text = DateFormat('dd/MM/yyyy').format(picked!);
//   });
// }
//
// // Future<void> selectendDate(BuildContext context) async {
// //   DateTime? picked = await showDatePicker(
// //     context: context,
// //     initialDate: DateTime.now(),
// //     firstDate: DateTime(2000),
// //     lastDate: DateTime(2100), );
// //   if (picked != null) {
// //     DateTime pickedWithTime = DateTime( picked.year, picked.month, picked.day, );
// //     String formattedDate = pickedWithTime.toIso8601String();
// //     // Định dạng ISO 8601
// //     setState(() {
// //       end=picked;
// //       enddate.text = DateFormat('dd/MM/yyyy').format(picked);
// //       enddateController.text = formattedDate;
// //       // sử dụng định dạng này cho việc so sánh
// //     });
// //   }
// DateTime? start;
// DateTime? end;
// int isValid(int percent){
//   if(percent>100){
//     return 0;
//   }
//   if(end!.isBefore(start!)){
//     return -1;
//   }
//   return 1;
// }
}
