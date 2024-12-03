import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/FeedBack_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/List_Cart_Item.dart';
import 'package:gmarket/Screens/CustomerScreen/Product_Detail.dart';
import 'package:gmarket/Screens/CustomerScreen/Search_Product.dart';
import 'package:gmarket/Screens/CustomerScreen/User_Info.dart';
import 'package:gmarket/Screens/Widget/Widget_Product_Item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreen_State();
  }
}

class HomeScreen_State extends State<HomeScreen> {
  int page = 1;
  int pageSort = 1;
  int? category_id;
  int? minprice=1;
  int? maxprice=0;
  int? size=1;
  List<int> numbers = List<int>.generate(50, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    Provider.of<Category_Provider>(context, listen: false).getAllCategory();
    page=1;
    pageSort=1;
    category_id=null;
    minprice=0;
    maxprice=1000000;
    size=null;
  }
  
  void clearPageSort(){
    setState(() {
      pageSort=1;
    });
  }

  void reset(){
    setState(() {
      page=1;
      pageSort=1;
      category_id=null;
      minprice=0;
      maxprice=1000000;
      size=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final itemProduct = Provider.of<ProductProvider>(context, listen: false);
    final itemUser = Provider.of<User_Provider>(context, listen: false);
    final itemCart = Provider.of<Cart_Provider>(context, listen: false);
    final itemCartItem = Provider.of<CartItem_Provider>(context, listen: false);
    final itemFeedback = Provider.of<FeedBack_Provider>(context, listen: false);
    final itemCategory=Provider.of<Category_Provider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        leading: Container(
          child: Image.asset(
            'assets/image/QMarket-Blue.jpg',
            height: height * 0.3,
            width: width * 0.3,
          ),
        ),
        actions: [
          // search
          IconButton(
            onPressed: () async {
              setState(() {
                page=1;
              });
              itemProduct.clearProductSearch();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search_Product()),
              );

            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
          // user info
          IconButton(
            onPressed: () {
              setState(() {
                page=1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User_Info()),

              );
            },
            icon: Icon(Icons.account_circle_outlined, color: Colors.white),
          ),
          // cart
          IconButton(
            onPressed: () async {
              setState(() {
                page=1;
              });
              try {
                loading();
                itemCartItem.clearListId();
                await itemCartItem.getAllCartItemsByCartID(itemCart.cart!.ID);
                if (itemCartItem.cartItems!.isNotEmpty) {
                  itemProduct.clearProducts();
                  for (int i = 0; i < itemCartItem.cartItems!.length; i++) {
                    int? product_id = itemCartItem.cartItems?[i].product_id;
                    await itemProduct.addProduct(product_id!);
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => List_Cart_Item(),
                    ),
                  );
                }
              } catch (e) {
                showMessage(context, "Giỏ hàng trống");
                Navigator.pop(context);

              }
            },
            icon: Icon(Icons.add_shopping_cart_sharp, color: Colors.white),
          ),
          // sort
          IconButton(
            onPressed: () {
              setState(() {
                page=1;
              });
              showModalBottomSheet( context: context, builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: height*0.7,
                      child:
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(height: height*0.01,),
                          //Sắp xếp theo
                          Container(
                            child:  const Text("Sắp xếp theo: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          //loai san pham
                          Container(
                            width: width*0.9,
                            child:  DropdownButtonFormField<Category>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color:  Color.fromRGBO(94, 200, 248, 1),
                                      width: 1.5
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder( borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 1.5,  ),
                                  borderRadius: BorderRadius.circular(10), ),

                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Color.fromRGBO(94, 200, 248, 1),
                                      width: 1.5
                                  ),
                                ),
                                hintText: "Loại sản phẩm",
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              iconEnabledColor: Colors.white,
                              items: itemCategory.listCategory.map((Category cate) {
                                return DropdownMenuItem<Category>(
                                  value: cate,
                                  child: Text(cate.name),
                                );
                              }).toList(),
                              onChanged: (Category? value) {
                                setState(() {
                                  category_id = value!.ID;
                                });
                                print(category_id);
                              },
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          // size
                          Container(
                            width: width*0.5,
                            padding: EdgeInsets.all(10),
                            child: DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color:  Color.fromRGBO(94, 200, 248, 1),
                                      width: 1.5
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder( borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 1.5,  ),
                                  borderRadius: BorderRadius.circular(10), ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Color.fromRGBO(94, 200, 248, 1),
                                      width: 1.5
                                  ),
                                ),
                                hintText: "Size sản phẩm",
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              iconEnabledColor: Colors.white,
                              items: numbers.map((int number) {
                                return DropdownMenuItem<int>(
                                  value: number,
                                  child: Text(number.toString()),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  size = value;
                                });
                                print(size);
                              },
                            ),
                          ),
                          SizedBox(height: height*0.01,),
                          //Mức tiền tối thiểu
                          Text( 'Mức tiền tối thiểu: $minprice',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Slider(
                            value: minprice!.toDouble(),
                            min: 0, max: 1000000, divisions: 100,
                            label: minprice.toString(),
                            onChanged: (double value) {
                              setState(() {
                                minprice = value.toInt();
                              });
                            },
                            activeColor: Color.fromRGBO(94, 200, 248, 1),
                          ),
                          SizedBox(height: height*0.01,),
                          //Mức tiền tối đa
                          Text( 'Mức tiền tối đa: $maxprice',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Slider(
                            value: maxprice!.toDouble(),
                            min: 0, max: 1000000, divisions: 100,
                            label: maxprice.toString(),
                            onChanged: (double value) {
                              setState(() {
                                maxprice = value.toInt();
                              });
                            },
                            activeColor: Color.fromRGBO(94, 200, 248, 1),
                          ),
                          SizedBox(height: height*0.01,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //sap xep
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
                                    if(minprice!>maxprice!){
                                      showMessage(context, "min > max");
                                    }
                                    loading();
                                    try{
                                      itemProduct.clearProducts();
                                      await itemProduct.SortProducts(size!, minprice!, maxprice!, category_id!, 1, 10);
                                      if(itemProduct.products.isEmpty){
                                        showMessage(context, "Không có dữ liệu");
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }
                                      clearPageSort();
                                    }catch(e){
                                      throw Exception("Khong co du lieu sort");
                                    }finally{
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text("Sắp xếp", style: TextStyle(color: Colors.black),)
                              ),
                              SizedBox(height: height*0.01,),
                              //Reset
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
                                    reset();
                                    itemProduct.clearProducts();
                                    await itemProduct.getAllProduct();
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                  },
                                  child: Text("Reset", style: TextStyle(color: Colors.black),)
                              ),
                            ],
                          ),
                        ],
                      )
                    );

                  },
                );
              },
              );
            },
            icon: Icon(Icons.sort,color: Colors.white),

          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(
          builder: (context, value, child) {
            if (itemProduct.products.isEmpty) {
              return Center(child: Text("Không có dữ liệu"));
            } else {
              return Container(
                
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // sản phẩm
                      Container(
                        width: width * 0.99,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          itemCount: itemProduct.products.length,
                          itemBuilder: (context, index) {
                            final product = itemProduct.products[index];
                            return WidgetProductItem(
                              name: product!.name!,
                              image: product.image!,
                              price: product.price,
                              id: product.ID,
                              onTap: () async {
                                setState(() {
                                  page=1;
                                });
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                                await itemCart.getOrCreateCartForUser(itemUser.user!.ID);
                                await itemProduct.getProductById(product.ID!);
                                print("asdfasdf -product ${product.ID!}");
                                await itemFeedback.getAllFeedbacksByProductID(product.ID!);
                                if (itemFeedback.feedbacks!.isNotEmpty) {
                                  for (int i = 0; i < itemFeedback.feedbacks!.length; i++) {
                                    await itemUser.getUserById(itemFeedback.feedbacks![i].user_id);
                                  }
                                }
                                Navigator.pop(context);
                                if (itemCart.cart != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Product_Detail()),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      // xem thêm
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
                            pageSort += 1;
                          });
                          print("page $page");
                          await itemProduct.filterProducts(page);
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
                      //______________________________
                    ],
                  ),
                ),

              );
            }
          },
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
