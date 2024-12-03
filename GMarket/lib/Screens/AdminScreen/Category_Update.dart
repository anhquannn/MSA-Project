
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Category_Update(id: 0,),
      )));
}

class Category_Update extends StatefulWidget{
  int? id;
  Category_Update({
    required this.id
});
  @override
  State createState() {
    return Category_Update_State();
  }
}
class Category_Update_State extends State<Category_Update> {

  bool isLoading=true;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  int?id;
  Future getData(Category cat) async {
      setState(() {
        id=cat.ID;
        name.text = cat.name.toString();
        description.text = cat.description.toString();
      });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemCategory=Provider.of<Category_Provider>(context);
    final result=itemCategory.category;
    if(result!=null){
      getData(result);
      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemCategory=Provider.of<Category_Provider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          titleTextStyle: const TextStyle(
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            // Mũi tên quay lại màu trắng
            onPressed: () {
              Navigator.pop(context); // Quay lại màn hình trước đó
            },
          ),
        ),
        body:
        Center(
            child: Container(
                color: Colors.white,
                width: width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01,),
                      //Tên mã loại sản phẩm
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: "Tên mã loại sản phẩm",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Coiny-Regular-font'
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 3,
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 2,
                              )
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                        onChanged: (value) {
                          setState(() {
                            name.text = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      //Mô tả mã loại sản phẩm
                      TextField(
                        controller: description,
                        decoration: InputDecoration(
                          labelText: "Mô tả mã loại sản phẩm",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Coiny-Regular-font'
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 3,
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(94, 200, 248, 1),
                                width: 2,
                              )
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),
                        onChanged: (value) {
                          setState(() {
                            description.text = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
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
                            itemCategory.updateCategory(
                                new Category(name: name.text,
                                    description: description.text,
                                    ID: itemCategory.category!.ID));
                            Navigator.pop(context);
                            showMessage(context, "Thêm thành công");
                          },
                          child: const Text(
                            "Sửa loại sản phẩm",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                          )),
                      SizedBox(height: height * 0.01,),
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
                            itemCategory.deleteCategory(itemCategory.category!.ID);
                            Navigator.pop(context);
                            showMessage(context, "Xóa thành công");
                          },
                          child: const Text(
                            "Xóa loại sản phẩm",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                          )),
                      SizedBox(height: height * 0.2,),
                    ],
                  ),
                )
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
}
