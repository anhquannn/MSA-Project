
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Product.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_PromoCode.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_User.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Order.dart';
import 'package:gmarket/Screens/CustomerScreen/ItemDetail.dart';
import 'package:gmarket/Screens/CustomerScreen/Search.dart';
import 'package:gmarket/Screens/CustomerScreen/Widget/Widget_Product_Item.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: HomeScreen(),
    ),
  ));
}

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
       title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width*0.6, // Kích thước ô tìm kiếm
                child: TextField(
                  onTap: () {
                    onTapSearch();
                  },
                  style: const TextStyle(color: Colors.white,fontSize: 16),
                  readOnly: true,
                  // enabled: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  ),
                  // maxLines: 3,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              onPressedInfoUser();
            },
            icon: Icon(Icons.account_circle_outlined,color: Colors.white,),
          ),
          IconButton(
              onPressed: () {
                onPressedCart();
              },
              icon: Icon(Icons.add_shopping_cart_sharp,color: Colors.white,))
        ],
        // centerTitle: true,
      ),
      body: Center(

        child:  Container(
          color: Colors.white,
          width: width*0.99,
          height: height,
          child:
              FutureBuilder<List<Product>>(
                future: productHttp().getAllProduct(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  else if(snapshot.hasError){
                    return Text("Lỗi dữ liệu ${snapshot.hasData}");
                  }
                  else if(!snapshot.hasData|| snapshot.data!.isEmpty) {
                    return Text('Không thể tải dữ liệu');
                  }
                  else{
                    List<Product> products=snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product=products[index];
                        return WidgetProductItem(name: product.name!,
                          image: product.image!,
                          price: product.price,
                          id: product.ID,
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ItemDetail(id: product.ID)),
                            );
                          },
                        );
                      },
                    );
                  }
                },
          ),
        ),
      )
    );
  }
  void onPressedInfoUser(){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ,)
    // )
  }
  void onPressedCart(){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ItemDetail(id: ,),)
    // );
  }
  void onTapSearch(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search(),)
    );
  }
}
