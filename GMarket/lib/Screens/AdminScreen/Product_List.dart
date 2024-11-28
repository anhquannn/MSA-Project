
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final itemProvider=Provider.of<ProductProvider>(context,listen: false);
    final itemCategory=Provider.of<Category_Provider>(context,listen: false);
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return
      Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(94, 200, 248, 1),),
      body:Consumer2<ProductProvider, Category_Provider>(
          builder: (context, value, value2, child) {
            if(value.products.isEmpty || value2.listCategory.isEmpty){
              return Text("Không có dữ liệu");
            }
            else{
              return Center(
                child:  Container(
                    color: Colors.white,
                    width: width*0.99,
                    height: height,
                    child:
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1
                      ),
                      itemCount: itemProvider.products.length,
                      itemBuilder: (context, index) {
                        final product= itemProvider.products[index];
                        return WidgetProductItem(name: product!.name!,
                          image: product.image!,
                          price: product.price,
                          id: product.ID,
                          onTap: (){
                            itemCategory.getAllCategory();
                            itemManufacturer.getAllManufacturer();
                            print(itemProvider.products[0]!.name);
                            itemProvider.getProductById(product!.ID!).then((_){
                              itemCategory.getCategoryById(itemProvider.product!.category_id!);
                              itemManufacturer.getManufacturerById(itemProvider.product!.manufacturer_id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Product_Update_Delete(id: product.ID)),
                              );
                            });

                            // itemCategory.getCategoryById(itemProvider.product!.category_id!);

                          },
                        );
                      },
                    )
                ),
              );
            }
          },
      )
    );
  }
  void onTapSearch(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search_Product(),)
    );
  }
}
