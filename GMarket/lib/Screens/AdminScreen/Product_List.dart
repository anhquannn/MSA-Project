
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Admin_Screen.dart';
import 'package:gmarket/Screens/AdminScreen/Product_Update.dart';
import 'package:gmarket/Screens/CustomerScreen/Search_Product.dart';
import 'package:gmarket/Screens/Widget/Widget_Product_Item.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: Product_List(),
    ),
  ));
}

class Product_List extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return
      Product_List_State();
  }
}

class Product_List_State extends State<Product_List>{
  int page=1;
  @override
  Widget build(BuildContext context) {
    final itemProvider=Provider.of<ProductProvider>(context,listen: false);
    final itemCategory=Provider.of<Category_Provider>(context,listen: false);
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);

    final width = MediaQuery.of(context).size.width;
    return
      Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                page=1;
              });
              Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => AdminScreen(),),
                    (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.arrow_back, color: Colors.black,)
        ),
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
      ),
      body:SingleChildScrollView(
        child: Center(
          child:
            Consumer2<ProductProvider, Category_Provider>(
              builder: (context, value, value2, child) {
                if(value.products.isEmpty || value2.listCategory.isEmpty){
                  return Text("Không có dữ liệu");
                }
                else{
                  return Container(
                    width: width,
                    child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              width: width,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1
                                ),
                                itemCount: value.products.length,
                                itemBuilder: (context, index) {
                                  final product= value.products[index];
                                  return WidgetProductItem(name: product!.name!,
                                    image: product.image!,
                                    price: product.price,
                                    id: product.ID,
                                    onTap: () async{
                                      loading();
                                      await itemProvider.getProductById(product.ID!);
                                      await  itemCategory.getCategoryById(itemProvider.product!.category_id!);
                                      await   itemManufacturer.getManufacturerById(itemProvider.product!.manufacturer_id!);
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Product_Update_Delete(id: product.ID)),
                                      );
                                    }
                                  );
                                },
                              ),
                            ),
                          ),
                          //Xem thêm
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
                              setState(() {
                                page += 1;
                              });
                              print("page $page");
                              await itemProvider.filterProducts(page);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Xem thêm...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Coiny-Regular-font',
                              ),
                            ),
                          ),
                        ]
                    ),
                  );
                }
              },
            ),
        )
      )
     
    );
  }
  void onTapSearch(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search_Product(),)
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
