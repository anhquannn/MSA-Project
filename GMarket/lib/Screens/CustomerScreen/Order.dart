import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/CartItem.dart';
import 'package:gmarket/Models/Order.dart';
import 'package:gmarket/Models/Payment.dart';
import 'package:gmarket/Models/Promocode.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/Payment_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:provider/provider.dart';

class Create_Order extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return Create_Order_State();
  }
}

class Create_Order_State extends State<Create_Order> {
  int quantity = 1;
  bool zaloPay=false;
  bool shipCode=true;
  String promoCode="";
  String method="";

  Future<void> increase() async {
    setState(() {
      quantity++;
    });

    await Provider.of<CartItem_Provider>(context,listen: false).
    updateCartItem(
        new CartItem(ID: Provider.of<CartItem_Provider>(context,listen: false).cart!.ID,
            status: "available",
            price: 999,
            quantity: quantity,
            cart_id: Provider.of<Cart_Provider>(context,listen: false).cart!.ID,
            product_id: Provider.of<ProductProvider>(context,listen: false).product!.ID)
    );
  }

  Future<void> decrease() async {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      await Provider.of<CartItem_Provider>(context,listen: false).
      updateCartItem(
          new CartItem(ID: Provider.of<CartItem_Provider>(context,listen: false).cart!.ID,
              status: "available",
              price: 999,
              quantity: quantity,
              cart_id: Provider.of<Cart_Provider>(context,listen: false).cart!.ID,
              product_id: Provider.of<ProductProvider>(context,listen: false).product!.ID)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final itemProduct = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<User_Provider>(context);
    final orderProvider=Provider.of<Order_Provider>(context);
    final cartProvider=Provider.of<Cart_Provider>(context);
    final cartItemProvider=Provider.of<CartItem_Provider>(context);
    final paymentProvider=Provider.of<Payment_Provider>(context);
    final promocodeProvider=Provider.of<Promocode_Provider>(context);



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          onPressed: () async {
            loading();
            orderProvider.clearPreviewOrder();
            await cartItemProvider.deleteCartItem(cartItemProvider.cart!.ID!);
            Navigator.pop(context);
            Navigator.pop(context);

          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Đặt hàng",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Coiny-Regular-font',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
         child: Container(
           child: Column(
           children: [
             SizedBox(height: height * 0.01),
             //Thong tin don hang
             Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(7),
                 border: Border.all(
                   width: 0.4,
                   color: Colors.black,
                 ),
               ),
               width: width * 0.95,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: height * 0.01),
                   //Tên người dùng
                   Text(
                     "Tên người dùng: ${userProvider.user!.fullname}",
                     softWrap: true,
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 16,
                     ),
                   ),
                   SizedBox(height: height * 0.01),
                   //Địa chỉ
                   Text(
                     "Địa chỉ: ${userProvider.user!.address}",
                     softWrap: true,
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 16,
                     ),
                   ),
                   SizedBox(height: height * 0.01),
                   //Số điện thoại
                   Text(
                     "Số điện thoại: ${userProvider.user!.address}",
                     softWrap: true,
                     style: const TextStyle(
                       color: Colors.black,
                       fontSize: 16,
                     ),
                   ),
                   //chinh sua dia chi
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       ElevatedButton(
                           style: ElevatedButton.styleFrom(
                               backgroundColor: Color.fromRGBO(94, 200, 248, 0.5),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
                               ),
                           ),
                           onPressed: () {

                           },
                           child: const Row(
                             children: [
                               Text("Chỉnh sửa địa chỉ",
                                 style: TextStyle(color: Colors.black, fontSize: 14,),
                               ),
                             ],
                           )
                       )
                     ],
                   ),
                 ],
               ),
             ),
             //thong tin san pham
             SizedBox(height: height * 0.01),
             Container(
               width: width * 0.95,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5),
                 border: Border.all(width: 0.5, color: Colors.black),
               ),
               height: height * 0.2,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   //hinh anh
                   Container(
                     width: width * 0.35,
                     height: height * 0.5,
                     child: Image.memory(
                       base64Decode(itemProduct.product!.image!),
                       fit: BoxFit.cover,
                     ),
                   ),
                   SizedBox(width: width * 0.03),
                   Container(
                     width: width * 0.55,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         //name
                         Text(
                           itemProduct.product!.name!,
                           style: const TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             overflow: TextOverflow.ellipsis,
                           ),
                           softWrap: true,
                         ),
                         SizedBox(height: height * 0.06),
                         //gia
                         Text(
                           '${itemProduct.product!.price!} VND',
                           style: const TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 16,
                           ),
                         ),
                         SizedBox(height: height * 0.01),
                         Row(
                           children: [
                             // Nút giảm số lượng
                             ElevatedButton(
                               onPressed: () async {
                                 loading();
                                 await decrease();
                                await orderProvider.getPreviewOrder(userProvider.user!.ID, cartProvider.cart!.ID, promoCode);
                                 Navigator.pop(context);
                               },
                               style: ElevatedButton.styleFrom(
                                 padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                 minimumSize: const Size(5, 10),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(5),
                                   side: const BorderSide(
                                     color: Colors.black,
                                     style: BorderStyle.solid,
                                   ),
                                 ),
                               ),
                               child: Text("-"),
                             ),
                             //quantity
                             SizedBox(width: 10),
                             Text("$quantity",
                               style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 16,
                               ),
                             ),
                             SizedBox(width: 10),
                             // Nút tăng số lượng
                             ElevatedButton(
                               onPressed:() async {
                                 loading();
                                 await increase();
                                await orderProvider.getPreviewOrder(userProvider.user!.ID, cartProvider.cart!.ID, promoCode);
                                 Navigator.pop(context);
                               },
                               style: ElevatedButton.styleFrom(
                                 padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                 minimumSize: const Size(5, 10),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(5),
                                   side: const BorderSide(
                                     color: Colors.black,
                                     style: BorderStyle.solid,
                                   ),
                                 ),
                               ),
                               child: Text("+"),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             //Phí vận chuyển
             SizedBox(height: height * 0.01),
             Container(
               width: width*0.95,
               child: const Text("Phí vận chuyển: 5k/km",
                 textAlign: TextAlign.start,
                 style: TextStyle(color: Colors.black, fontSize: 14),),
             ),
             //Ma giam gia
             SizedBox(height: height * 0.03),
             DropdownButtonFormField<PromoCode>(
               decoration: InputDecoration(
                 labelText: "Mã giảm giá",
                 labelStyle: const TextStyle(
                   color: Colors.black,
                   fontSize: 18,
                   fontWeight: FontWeight.bold
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20),
                   borderSide: const BorderSide(
                     color: Color.fromRGBO(94, 200, 248, 1),
                     width: 2,
                   ),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15),
                   borderSide: const BorderSide(
                     color: Color.fromRGBO(94, 200, 248, 1),
                     width: 1,
                   ),),),
               style: const TextStyle(
                 color: Colors.black, fontSize: 15,),
               hint: const Text("Chọn mã giảm giá",
                 style: TextStyle(color: Colors.black),),
               onChanged: (PromoCode? newValue) async {
                 loading();
                 await orderProvider.getPreviewOrder(userProvider.user!.ID, cartProvider.cart!.ID, newValue!.code! );
                 setState(() {
                   promoCode=newValue.code!;
                 });
                 Navigator.pop(context);
                 },
               items: promocodeProvider.promocodes.map((PromoCode pc) {
                 return DropdownMenuItem<PromoCode>(
                   value: pc,
                   child: Text(pc.code!),
                 );
               }).toList(),
             ),
             SizedBox(height: height * 0.01),
             //Phương thức thanh toán
             Container(
                 child: Column(
                   children: [
                     const Text("Phương thức thanh toán",
                       style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                     SizedBox(height: height*0.02,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         //Zalo Pay
                         ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: Color.fromRGBO(94, 200, 248, 1),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15)
                                 )
                             ),
                             onPressed: () {
                               if(zaloPay==false){
                                 setState(() {
                                   zaloPay=true;
                                   shipCode=false;
                                 });
                               }
                               else{
                                 setState(() {
                                   shipCode=true;
                                   zaloPay=false;
                                 });
                               }
                             },
                             child: Row(
                               children: [
                                 Text("Zalo Pay", style: TextStyle(color: Colors.black, fontSize: 16),),
                                 Checkbox( activeColor: Color.fromRGBO(94, 200, 248, 1),
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                   value: zaloPay,
                                   onChanged: (value) {
                                   setState(() {
                                     zaloPay=value!;
                                     zaloPay==true? shipCode=false:shipCode=true;
                                   });

                                   },
                                 )
                               ],
                             )
                         ),
                         // Ship Code
                         ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: Color.fromRGBO(170, 184, 194, 1),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15)
                                 )
                             ),
                             onPressed: () {
                               if(shipCode==true){
                                 setState(() {
                                   shipCode=false;
                                   zaloPay=true;
                                 });
                               }
                               else{
                                 setState(() {
                                   shipCode=true;
                                   zaloPay=false;
                                 });
                               }
                             },
                             child: Row(
                               children: [
                                 Text("Ship Code", style: TextStyle(color: Colors.black, fontSize: 16),),
                                 Checkbox(
                                   activeColor: Color.fromRGBO(94, 200, 248, 1),
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                   value: shipCode,
                                   onChanged: (value) {
                                     setState(() {
                                       shipCode=value!;
                                       shipCode==true?zaloPay=false:zaloPay=true;
                                     });
                                   },
                                 )
                               ],
                             )
                         ),
                       ],
                     ),
                   ],
                 )
             ),
             SizedBox(height: height * 0.03),
             //Thông tin thanh toán
             Consumer<Order_Provider>(builder: (context, value, child) {
               return Container(
                 decoration: BoxDecoration(
                     border: Border.all(
                       color: Color.fromRGBO(94, 200, 248,  1 ),
                       width: 1.5,
                     ),
                     borderRadius: BorderRadius.circular(10),
                 ),
                 padding: EdgeInsets.all(5),
                 width: width*0.9,
                 //Thông tin thanh toán
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 7,),
                         //Tổng tiền
                         Text("Tổng tiền", style: TextStyle(color: Colors.black, fontSize: 12),),
                         SizedBox(height: 5,),
                         //Tiền giảm giá
                         Text("Tiền giảm giá", style: TextStyle(color: Colors.black, fontSize: 12),),
                         SizedBox(height: 5,),
                         //Phí vận chuyển
                         Text("Phí vận chuyển", style: TextStyle(color: Colors.black, fontSize: 12),),
                         SizedBox(height: 5,),
                         //Còn lại
                         Text("Còn lại", style: TextStyle(color: Colors.black, fontSize: 12),),
                         SizedBox(height: 7,),
                       ],
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         const SizedBox(height: 7,),
                         //Tổng tiền
                         Text('${value.previewOrder.total_cost} VND', style: TextStyle(color: Colors.black, fontSize: 12),),
                         const SizedBox(height: 5,),
                         //Tiền giảm giá
                         Text("${value.previewOrder.discount} VND", style: TextStyle(color: Colors.black, fontSize: 12),),
                         const SizedBox(height: 5,),
                         //Phí vận chuyển
                         Text("0 VND", style: TextStyle(color: Colors.black, fontSize: 12),),
                         const SizedBox(height: 5,),
                         //Còn lại
                         Text("${value.previewOrder.grand_total} VND", style: TextStyle(color: Colors.black, fontSize: 12),),
                         const SizedBox(height: 7,),
                       ],
                     ),
                   ],
                 ),
               );
             },),

             SizedBox(height: height * 0.03),
             //Đặt hàng
             Container(
               height: height*0.06,
               width: width*0.4,
               child:  ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color.fromRGBO(94, 200, 248, 1),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
                     ),
                   ),
                   onPressed: () async {
                     showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
                       return const Center(
                         child: CircularProgressIndicator(),
                       );
                     },);
                     if(zaloPay==true){
                       setState(() {
                         method="ZaloPay";
                       });
                     }
                     else{
                       setState(() {
                         method="COD";
                       });
                     }
                     await orderProvider.createOrder(new Order(
                       ID: 0,
                       user_id: userProvider.user!.ID,
                       cart_id: cartProvider.cart!.ID,
                       grandtotal: orderProvider.previewOrder.grand_total,
                       status: "",
                     ), promoCode);

                     await paymentProvider.createPayment(
                         new Payment(ID: 0, paymentmethod:method,
                             status: "pending",
                             grandtotal: orderProvider.order!.grandtotal, order_id: orderProvider.order!.ID,
                             user_id: userProvider.user!.ID));
                     orderProvider.clearPreviewOrder();
                     Navigator.of(context).pop();
                     if (orderProvider.isSucess == true) {
                       Navigator.pop(context);
                       showMessage(context, "Đặt hàng thành công");
                     } else {
                       showMessage(context, "Không tồn tại mã giảm giá");
                     }

                   },
                   child: const Text("Đặt hàng",
                       style: TextStyle(color: Colors.black,
                         fontSize: 16,
                         fontFamily: 'Coiny-Regular-font',
                       )
                   )),
             ),
             SizedBox(height: height * 0.1),
           ],
         ),
         ),
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

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}
