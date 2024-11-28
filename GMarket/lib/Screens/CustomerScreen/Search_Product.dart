import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/FeedBack_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/CustomerScreen/Product_Detail.dart';
import 'package:gmarket/Screens/Widget/Widget_Product_Item.dart';
import 'package:provider/provider.dart';

class Search_Product extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Search_Product_State();
  }
}
class Search_Product_State extends State<Search_Product> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    final itemProduct = Provider.of<ProductProvider>(context);
    final itemUser = Provider.of<User_Provider>(context, listen: false);
    final itemCart = Provider.of<Cart_Provider>(context, listen: false);
    final itemFeedback = Provider.of<FeedBack_Provider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        title: TextField(
          controller: _searchController,
          onSubmitted: (value) async {
            await itemProduct.getProductByName(value);
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () async {
                loading();
                await itemProduct.getProductByName(_searchController.text);
                Navigator.pop(context);
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
      body:  Container(
        child: itemProduct.isLoading ? Center(child: CircularProgressIndicator()) :
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1.5,
          ),
          itemCount: itemProduct.productSearch.length,
          itemBuilder: (context, index) {
            final item = itemProduct.productSearch[index];
            return WidgetProductItem(
              name: item.name!,
              image: item.image!,
              price: item.price,
              id: item.ID,
              onTap: () {
                //Lấy sản phẩm --> lấy product
                 itemProduct.getProductById(item.ID!);
                 itemFeedback.getAllFeedbacksByProductID(item.ID!);
                if (itemFeedback.feedbacks!.isNotEmpty) {
                  for (int i = 0; i < itemFeedback.feedbacks!.length; i++) {
                     itemUser.getUserById(itemFeedback.feedbacks![i].user_id);
                  }
                }

                if (itemCart.cart != null) {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Product_Detail()),
                  );
                }
              },
            );
          },
        ),
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