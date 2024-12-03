
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/Delivery.dart';
import 'package:gmarket/Models/DeliveryDetail.dart';
import 'package:gmarket/Models/Order.dart';
import 'package:gmarket/Models/Payment.dart';
import 'package:gmarket/Models/Promocode.dart';
import 'package:gmarket/Models/zaloMethod.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/DeliveryDetail_Provider.dart';
import 'package:gmarket/Provider/Delivery_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/Payment_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/DeliveryDetail_List.dart';
import 'package:gmarket/Screens/CustomerScreen/Home_Screen.dart';
import 'package:gmarket/Screens/Widget/Widget_Item_Order.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Order_List_Item extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Order_List_Item_State();
  }
}

class Order_List_Item_State extends State<Order_List_Item>{
  int quantity = 1;
  bool zaloPay=false;
  bool shipCode=true;
  String promoCode="";
  String method="";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final itemProduct = Provider.of<ProductProvider>(context,listen: false);
    final userProvider = Provider.of<User_Provider>(context,listen: false);
    final orderProvider=Provider.of<Order_Provider>(context);
    final itemCart=Provider.of<Cart_Provider>(context);
    final itemCartItem=Provider.of<CartItem_Provider>(context);
    final paymentProvider=Provider.of<Payment_Provider>(context);
    final promocodeProvider=Provider.of<Promocode_Provider>(context);
    final cartProvider=Provider.of<Cart_Provider>(context);
    final deliveryDetailProvider=Provider.of<DeliveryDetail_Provider>(context);
    final deliveryProvider=Provider.of<Delivery_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
          onPressed: () async {
            await itemCartItem.updateCartItemStatus(itemCartItem.listid, "unavailable");
            await itemCartItem.getAllCartItemsByCartID(itemCart.cart!.ID);
            orderProvider.clearPreviewOrder();
            itemProduct.clearProducts();
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
                      Text(
                        "Tên người dùng: ${userProvider.user!.fullname}",
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "Địa chỉ: ${userProvider.user!.address}",
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        "Số điện thoại: ${userProvider.user!.address}",
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      //cap nhat thong tin ca nhan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                                await deliveryDetailProvider.getAllDeliveryDetail();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDetail_List(),));
                              },

                              child: const Text("Chỉnh sửa địa chỉ",
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 14,
                                  )
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                //thong tin san pham
                SizedBox(height: height * 0.01),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 244, 244, 1),
                    border: Border.all
                      (width: 1,
                      color: Color.fromRGBO(94, 200, 248, 1), ),
                  ),
                  //danh sach san pham
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: PageScrollPhysics(),
                    itemCount: itemCartItem.cartItems!.length,
                    itemBuilder: (context, index){

                      final product=itemProduct.products[index];
                      final quantity=itemCartItem.cartItems?[index].quantity;
                      final cartItemId=itemCartItem.cartItems?[index].ID;

                      if(itemCartItem.cartItems!.isEmpty){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else{
                        return Container(
                            height: height*0.21,
                            child:  Widget_Item_Order(
                              image: product!.image, name: product.name,
                              price: product.price, product_id: product.ID,
                              cart_id: itemCart.cart!.ID, quantity: quantity!,
                              cartItemId: cartItemId!,
                            )
                        );
                      }
                    },
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
                //Mã giảm giá
                SizedBox(height: height * 0.03),
                SizedBox(
                  width: width * 0.9,
                  height: height * 0.15,
                  child: DropdownButtonFormField<PromoCode>(
                    decoration: InputDecoration(
                      labelText: "Mã giảm giá",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 60,
                    ),
                    hint: const Text(
                      "",
                      style: TextStyle(color: Colors.black),
                    ),
                    onChanged: (PromoCode? newValue) async {
                      loading();
                      await orderProvider.getPreviewOrder(userProvider.user!.ID, cartProvider.cart!.ID, newValue!.code!);
                      setState(() {
                        promoCode = newValue.code!;
                      });
                      Navigator.pop(context);
                    },
                    items: promocodeProvider.promocodes.map((PromoCode pc) {
                      return DropdownMenuItem<PromoCode>(
                        value: pc,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          width: width * 0.7,
                          height: height * 0.07, // Tăng chiều cao của phần tử trong dropdown
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1.5,
                              color: Color.fromRGBO(94, 200, 248, 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Giảm ngay ${pc.discountpercentage}%",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Đơn tối thiểu: ${pc.minimumordervalue!} VND",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Icon(Icons.discount),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                //Phương thức thanh toán
                SizedBox(height: height * 0.01),
                Container(
                    width: width * 0.95,
                    child: Column(
                      children: [
                        const Text("Phương thức thanh toán",
                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(height: height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //zalo pay
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
                                onPressed: () {
                                  if(shipCode==false){
                                    setState(() {
                                      zaloPay==true? zaloPay=false:zaloPay=true;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      shipCode=false;
                                      zaloPay=true;
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
                                        if(shipCode==false){
                                          setState(() {
                                            zaloPay==true? zaloPay=false:zaloPay=true;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            shipCode=false;
                                            zaloPay=true;
                                          });
                                        }
                                      },
                                    )
                                  ],
                                )
                            ),
                            // Ship Code
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
                                onPressed: () {
                                  if(zaloPay==false){
                                    setState(() {
                                      shipCode==true? shipCode=false:shipCode=true;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      zaloPay=false;
                                      shipCode=true;
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
                                        if(zaloPay==false){
                                          setState(() {
                                            shipCode==true? shipCode=false:shipCode=true;
                                          });
                                        }
                                        else{
                                          setState(() {
                                            zaloPay=false;
                                            shipCode=true;
                                          });
                                        }
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
                //Thông tin thanh toán
                SizedBox(height: height * 0.01),
                Consumer<Order_Provider>(builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(94, 200, 248,  1 ),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
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
                SizedBox(height: height * 0.01),
                //Dat hang
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
                      if(zaloPay==true){
                        setState(() {
                          method="zalopay";
                        });
                        //Tao order
                        await orderProvider.createOrder(
                            Order( ID: 0,
                                user_id: userProvider.user!.ID,
                                cart_id: cartProvider.cart!.ID,
                                grandtotal: orderProvider.previewOrder.grand_total,
                                status: "paying",order_details: [], User: userProvider.user!
                            ), promoCode);
                        //UpdateOrder
                        await orderProvider.updateStatusOrder(
                            orderProvider.order!.ID, userProvider.user!.ID, cartProvider.cart!.ID, "paying");
                        //Tao payment
                        await paymentProvider.createPayment(
                            new Payment(
                                ID: 0, paymentmethod: method,
                                status: "paying", grandtotal: orderProvider.previewOrder.grand_total,
                                order_id: orderProvider.order!.ID, user_id: userProvider.user!.ID));
                        //________________Thanh toan zalopay_______________________________________________
                        final result=await getOrderZalo(orderProvider.previewOrder.grand_total);
                        await launchUrl(Uri.parse(result!.orderurl), mode: LaunchMode.externalApplication);
                        //________________________________________________________________________________
                        // Update Payment
                        await paymentProvider.updatePayment(
                          new Payment(ID: paymentProvider.payment!.ID,
                              paymentmethod: "zalopay", status: "success",
                              grandtotal:orderProvider.previewOrder.grand_total, order_id: orderProvider.order!.ID,
                              user_id: userProvider.user!.ID)
                        );
                        //UpdateOrder paid
                        await orderProvider.updateStatusOrder(
                            orderProvider.order!.ID, userProvider.user!.ID, cartProvider.cart!.ID, "paid");
                        //tạo delivery
                        await deliveryProvider.createDelivery(
                            new Delivery(ID: 0, status: "delivering",
                                orderId: orderProvider.order!.ID, userId: userProvider.user!.ID,
                                details: null),
                            userProvider.user!.ID,
                            orderProvider.order!.ID);
                        print("giao dien ${deliveryProvider.delivery!.ID}");
                        await orderProvider.updateStatusOrder(
                            orderProvider.order!.ID, userProvider.user!.ID, cartProvider.cart!.ID, "delivering");
                        await deliveryDetailProvider.createDeliveryDetail(
                            new DeliveryDetail(ID: 0,
                                deliveryName: deliveryDetailProvider.deliveryDetail!.deliveryName,
                                shipCode: "",
                                description: "",
                                weight: 0,
                                deliveryAddress: deliveryDetailProvider.deliveryDetail!.deliveryAddress,
                                deliveryContact: deliveryDetailProvider.deliveryDetail!.deliveryContact,
                                deliveryFee: 0,
                                deliveryId: deliveryProvider.delivery!.ID)
                        );
                      }
                      else{
                        loading();
                        setState(() {
                          method="COD";
                        });
                        //Tao order
                        await orderProvider.createOrder(Order(
                            ID: 0,
                            user_id: userProvider.user!.ID,
                            cart_id: cartProvider.cart!.ID,
                            grandtotal: orderProvider.previewOrder.grand_total,
                            status: "",order_details: [], User: userProvider.user!
                        ), promoCode);
                        //UpdateOrder
                        await orderProvider.updateStatusOrder(
                            orderProvider.order!.ID, userProvider.user!.ID, cartProvider.cart!.ID, "delivering");
                        //Tao payment
                        await paymentProvider.createPayment(
                            new Payment(
                                ID: 0, paymentmethod: method,
                                status: "paying", grandtotal: orderProvider.previewOrder.grand_total,
                                order_id: orderProvider.order!.ID, user_id: userProvider.user!.ID));
                        //tạo delivery
                        await deliveryProvider.createDelivery(
                            new Delivery(ID: 0, status: "delivering",
                                orderId: orderProvider.order!.ID, userId: userProvider.user!.ID,
                                details: null),
                            userProvider.user!.ID,
                            orderProvider.order!.ID);
                        await deliveryDetailProvider.createDeliveryDetail(
                            new DeliveryDetail(ID: 0,
                                deliveryName: deliveryDetailProvider.deliveryDetail!.deliveryName,
                                shipCode: "",
                                description: "",
                                weight: 0,
                                deliveryAddress: deliveryDetailProvider.deliveryDetail!.deliveryAddress,
                                deliveryContact: deliveryDetailProvider.deliveryDetail!.deliveryContact,
                                deliveryFee: 0,
                                deliveryId: deliveryProvider.delivery!.ID)
                        );
                      }
                      orderProvider.clearPreviewOrder();
                      Navigator.pop(context);
                      await itemProduct.getAllProduct();
                      if (orderProvider.isSucess == true) {
                        Navigator.pop(context);
                        showMessage(context, "Đặt hàng thành công");
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => HomeScreen(),),
                                (Route<dynamic> route) => false,
                        );
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
