import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/CartItem.dart';
import 'package:gmarket/Models/DeliveryDetail.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/DeliveryDetail_Provider.dart';
import 'package:gmarket/Provider/FeedBack_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/Box_Chat.dart';
import 'package:gmarket/Screens/CustomerScreen/List_Cart_Item.dart';
import 'package:gmarket/Screens/CustomerScreen/Order.dart';
import 'package:gmarket/Screens/Widget/Widget_Feedback.dart';
import 'package:gmarket/Screens/Widget/Widget_Product_Item.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Product_Detail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Product_Detail_State();
  }
}
class Product_Detail_State extends State<Product_Detail>{
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    final itemProduct = Provider.of<ProductProvider>(context);
    final itemCart=Provider.of<Cart_Provider>(context);
    final itemCartItem=Provider.of<CartItem_Provider>(context);
    final itemUser=Provider.of<User_Provider>(context);
    final itemFeedback = Provider.of<FeedBack_Provider>(context, listen: false);
    final promocodeProvider=Provider.of<Promocode_Provider>(context);
    final itemOrder=Provider.of<Order_Provider>(context);
    final deliveryDetailProvider=Provider.of<DeliveryDetail_Provider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(94, 200, 248, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.arrow_back, color: Colors.black,)),
        //Thông tin sản phẩm
        title: const Text("Thông tin sản phẩm", 
          style: TextStyle(color: Colors.black,
          fontSize: 18,
            fontFamily: 'Coiny-Regular-font',),
        ),
        centerTitle: true,
      ),
      body: itemProduct.isLoading==true? const Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                child: Image.memory(base64Decode(itemProduct.product!.image!),fit: BoxFit.cover,),
              ),
              Container(
                width: width*0.98,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height*0.005,),
                    //Tên sản phẩm
                    Text('${itemProduct.product!.name}',
                      style:const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Giá sản phẩm
                    Text('${floatToMoney(int.parse(itemProduct.product!.price.toString()) as int)}',
                      style:const TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(94, 190, 248, 1),
                          fontWeight: FontWeight.bold),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Số lượng đã bán
                    Text('Đã bán: ${itemProduct.product!.sales}',
                      style:const TextStyle(
                          fontSize: 14,
                          color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    //Còn lại
                    Text('Còn lại: ${itemProduct.product!.stocknumber}',
                      style:const TextStyle(
                        fontSize: 14,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.04,),
                    //Thông tin chi tiết
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(94, 200, 248, 0.5),
                        border: Border.all(color: Colors.black, width: 1)
                      ),
                      alignment: Alignment.center,
                        child:const Text('Thông tin chi tiết',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    SizedBox(height: height*0.002,),
                    //Size
                    Text('Size: ${itemProduct.product!.size}',
                      style:const TextStyle(
                        fontSize: 16,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Màu
                    Text('Màu: ${itemProduct.product!.color}',
                      style:const TextStyle(
                        fontSize: 16,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Hạn sử dụng
                    Text('Hạn sử dụng: ${itemProduct.product!.expiry}',
                      style:const TextStyle(
                        fontSize: 16,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Chi tiết sản phẩm
                    Text('Chi tiết sản phẩm: ${itemProduct.product!.specification}',
                      style:const TextStyle(
                        fontSize: 16,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Mô tả sản phẩm
                    Text('Mô tả sản phẩm: ${itemProduct.product!.description}',
                      style:const TextStyle(
                        fontSize: 16,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.002,),
                    //Chính sách đổi trả
                    const Text('Chính sách đổi trả: Đổi trả trong 15 ngày',
                      style:TextStyle(
                        fontSize: 16,
                        color: Colors.black,),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: height*0.04,),
                    //Feddback
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(94, 200, 248, 0.5),
                            border: Border.all(color: Colors.black, width: 1)
                        ),
                        alignment: Alignment.center,
                        child:const Text('Đánh giá',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    SizedBox(height: height*0.002,),
                    Container(
                      // width: width*0.98,
                      height: height*0.5,
                      child: ListView.builder(
                        itemCount: itemFeedback.feedbacks!.length,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                            final fb=itemFeedback.feedbacks?[index];
                            final name=itemUser.difuser[index].fullname;
                            return Column(
                              children: [
                                Container(
                                    height: height*0.2,
                                    child:  Widget_Feedback(
                                        rating: fb!.rating,
                                        name: name,
                                        comments: fb.comments)
                                ),
                                const SizedBox(height:3,),
                              ],) ;
                        },),
                    ),
                    //Sản phẩm tương tự
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(94, 200, 248, 0.5),
                            border: Border.all(color: Colors.black, width: 1)
                        ),
                        alignment: Alignment.center,
                        child:const Text('Sản phẩm tương tự',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20, fontWeight: FontWeight.bold),)
                    ),
                    SizedBox(height: height*0.002,),
                    //San pham tuong tu
                    Container(
                      width: width,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                            itemCount: itemProduct.products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:2,
                                crossAxisSpacing: 1
                            ),
                            itemBuilder: (context, index) {
                              final pd=itemProduct.products[index];
                              return WidgetProductItem(
                                name: pd!.name!,
                                image: pd.image!,
                                price: pd.price,
                                onTap:() {
                                  itemProduct.getProductById(pd.ID!).then((_){
                                    if(itemProduct.product!=null){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => Product_Detail(),)
                                      );
                                    }
                                  });
                                },
                              );
                            },)
                      ),
                    SizedBox(height: height*0.002,),
                  ],
                ),
              )
            ],
          ),
        ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(250, 250, 250, 1),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Giỏ hàng
              IconButton(
                  onPressed: () async {
                    try{
                      itemCartItem.clearListId();
                      await itemCartItem.getAllCartItemsByCartID(itemCart.cart!.ID);
                      if (itemCartItem.cartItems!.isNotEmpty) {
                        print("1");
                        itemProduct.clearProducts();
                        for (int i = 0; i < itemCartItem.cartItems!.length; i++) {
                          int? product_id = itemCartItem.cartItems?[i].product_id;
                          await itemProduct.addProduct(product_id!);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => List_Cart_Item(),
                          ),
                        );
                      }
                    }catch(e){
                      showMessage(context, "Giỏ hàng trống");
                    }
                  },
                  icon: Icon(Icons.add_shopping_cart_sharp, color: Colors.black, ),
              ),
              //Chat
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Box_Chat(),)
                    );
                  },
                  icon: Icon(Icons.chat_sharp, color: Colors.black),
              ),
              //Thêm vào giỏ hàng
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
                   await itemCartItem.addProductToCart(new CartItem(
                            ID: 0,
                            status: "status",
                            price: 0,
                            quantity: 1,
                            cart_id: itemCart.cart!.ID,
                            product_id: itemProduct.product!.ID!));
                   if(itemCartItem.cart!=null){
                     showMessage(context,"Thêm vào giỏ hàng thành công");
                     Navigator.pop(context);
                   }

                  },
                  child: const Text("Thêm vào\ngiỏ hàng",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15, fontWeight: FontWeight.bold),
                    softWrap: true,maxLines: 2,
                  )
              ),
              SizedBox(width: width*0.005,),
              //Mua ngay
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
                    //lấy promocode -> thêm sản phẩm vào cart
                    await promocodeProvider.getAllPromoCode();
                    await itemCartItem.addProductToCart(
                      new CartItem(
                          ID: 0, status: "status",
                          price: itemProduct.product!.price, quantity: 1,
                          cart_id: itemCart.cart!.ID, product_id:  itemProduct.product!.ID)
                    );
                    List<int> id=[];
                    id.add(itemCartItem.cart!.ID!);
                    await itemCartItem.updateCartItemStatus(id, "available");
                    await itemOrder.getPreviewOrder(itemUser.user!.ID, itemCart.cart!.ID, "" );
                    deliveryDetailProvider.setDeliveryDetail(
                        new DeliveryDetail(
                            ID: 0,
                            deliveryName: itemUser.user!.fullname,
                            shipCode: "",
                            description: "",
                            weight: 0,
                            deliveryAddress: itemUser.user!.address,
                            deliveryContact: itemUser.user!.phonenumber,
                            deliveryFee: 0,
                            deliveryId: null));
                    Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Create_Order(),)
                      );
                    // }
                  },
                  child: const Text("Mua ngay",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15, fontWeight: FontWeight.bold),
                      softWrap: true,maxLines: 2, textAlign: TextAlign.center
                  )
              ),
            ],
          ),
      ),
    );
  }
  String floatToMoney(int price){
    NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN'); // Định dạng tiền tệ cho Việt Nam
    String formattedAmount = formatter.format(price);
    return formattedAmount;
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