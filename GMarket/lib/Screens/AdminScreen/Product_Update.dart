
import 'dart:convert';
import 'dart:io';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Screens/AdminScreen/Product_List.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Product_Update_Delete extends StatefulWidget{
  int? id;
  Product_Update_Delete({
    required this.id
  });
  @override
  State createState() {
    return Product_Update_Delete_State();
  }
}

class Product_Update_Delete_State extends State<Product_Update_Delete> {
  int? productId;
  String? image = "";
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController specification = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stocknumber = TextEditingController();
  TextEditingController stocklevel = TextEditingController();
  TextEditingController expiry = TextEditingController();
  Category? selectedCategory;
  Manufacturer? selectedManufacturer;
  int page=1;
  @override
  void initState(){
    super.initState();
    final itemProvider = Provider.of<ProductProvider>(context,listen: false);
    final itemManufacturer = Provider.of<Manufacturer_Provider>(context,listen: false);
    final itemCategory = Provider.of<Category_Provider>(context,listen: false);
    setState(() {
      image = itemProvider.product?.image.toString();
      productId = itemProvider.product?.ID;
      name.text = itemProvider.product!.name.toString();
      price.text = itemProvider.product!.price.toString();
      size.text = itemProvider.product!.size.toString();
      color.text = itemProvider.product!.color.toString();
      specification.text = itemProvider.product!.specification.toString();
      description.text = itemProvider.product!.description.toString();
      stocknumber.text = itemProvider.product!.stocknumber.toString();
      stocklevel.text = itemProvider.product!.stocklevel.toString();
      expiry.text = itemProvider.product!.expiry.toString();
      selectedManufacturer=itemManufacturer.manufacturer;
      selectedCategory=itemCategory.category!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ProductProvider>(context);
    final itemCategory=Provider.of<Category_Provider>(context,listen: false);
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
                  Column(
                    children: [
                      SizedBox(height: height*0.02,),
                      //Tên sản phẩm
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: "Tên sản phẩm",
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
                      SizedBox(height: height * 0.02,),
                      //Giá sản phẩm
                      TextField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Giá sản phẩm",
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
                            price.text = int.parse(value).toString();
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Size sản phẩm
                      TextField(
                        controller: size,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Size sản phẩm",
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
                            size.text = int.parse(value).toString();
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Màu sản phẩm
                      TextField(
                        controller: color,
                        decoration: InputDecoration(
                          labelText: "Màu sản phẩm",
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
                            color.text = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Thông số sản phẩm
                      TextField(
                        controller: specification,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Thông số sản phẩm",
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
                            specification.text = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Mô tả sản phẩm
                      TextField(
                        controller: description,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Mô tả sản phẩm",
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
                      //Hạn sử dụng sản phẩm
                      SizedBox(height: height * 0.02,),
                      TextField(
                        readOnly: true,
                        controller: expiry,
                        decoration: InputDecoration(
                          labelText: "Hạn sử dụng sản phẩm",
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
                        onTap: () => selectExpiryDate(context),
                      ),
                      SizedBox(height: height * 0.02,),
                      //Số lượng tồn kho sản phẩm
                      TextField(
                        controller: stocknumber,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Số lượng tồn kho sản phẩm",
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
                            stocknumber.text = int.parse(value).toString();
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Mức tồn kho sản phẩm
                      DropdownButtonFormField<String>(
                        hint: Text("${stocklevel.text}"),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        items: const [
                          DropdownMenuItem(
                              value: 'Low',
                              child: Text('Low')
                          ),
                          DropdownMenuItem(
                              value: 'Medium',
                              child: Text('Medium')
                          ),
                          DropdownMenuItem(
                              value: 'High',
                              child: Text('High')
                          )
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            stocklevel.text = value!;
                          });
                        },
                        // value: stocklevel.text,
                        decoration: InputDecoration(
                          labelText: "Mức tồn kho sản phẩm",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Coiny-Regular-font',
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(94, 200, 248, 1),
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(94, 200, 248, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02,),
                      //Mã loại sản phẩm
                      DropdownButtonFormField<Category>(
                        // value: null,
                        onChanged: (Category? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: itemCategory.list.map<DropdownMenuItem<Category>>((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        hint: Text('${selectedCategory!.name}'),
                        decoration: InputDecoration(
                          labelText: "Danh mục",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Coiny-Regular-font',
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(94, 200, 248, 1),
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(94, 200, 248, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02,),
                      //Mã nhà sản xuất sản phẩm
                      DropdownButtonFormField<Manufacturer>(
                        // value: selectedManufacturer,
                        onChanged: (Manufacturer? value) {
                          setState(() {
                              selectedManufacturer = value;
                          });
                        },
                        items: itemManufacturer.listManufacturer.map((Manufacturer manufac) {
                          return DropdownMenuItem<Manufacturer>(
                            value: manufac,
                            child: Text(manufac.name),
                          );
                        }).toList(),
                        // hint: Text('${Provider.of<Manufacturer_Provider>(context).manufacturer!.name}'),
                        hint: Text('${selectedManufacturer!.name}'),
                        decoration: InputDecoration(
                          labelText: "Nhà sản xuất",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Coiny-Regular-font',
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(94, 200, 248, 1),
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(94, 200, 248, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Đã bán: ${itemProvider.product!.sales}"),
                          Text("Còn lại: ${itemProvider.product!.stocknumber}"),
                        ],
                      ),
                      SizedBox(height: height * 0.02,),
                      //Hình ảnh
                      SizedBox(width: width*0.025,),
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
                            _image=null;
                            _getImage();
                          },
                          child: const Text(
                            "Chọn hình ảnh",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Coiny-Regular-font'),
                          )),
                      SizedBox(height: height * 0.02,),
                      SizedBox(height: height * 0.02,),
                      Container(
                          width: width,
                          height: width,
                          child:
                          Image.memory(base64Decode(image!),fit: BoxFit.cover,)

                      ),
                      // Sửa sản phẩm
                      // Xóa sản phẩm
                      Column(
                        children: [
                          // Sửa sản phẩm
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
                              onPressed: () async{
                                loading();
                                selectedCategory ??= Provider.of<Category_Provider>(context, listen: false).category!;
                                selectedManufacturer ??= Provider.of<Manufacturer_Provider>(context,listen: false).manufacturer;
                                await itemProvider.updateProduct(new Product(name: name.text, price: int.parse(price.text),
                                    image: image, size: int.parse(size.text),
                                    color: color.text, specification: specification.text,
                                    description: description.text, expiry: expiry.text,
                                    stocknumber: int.parse(stocknumber.text), stocklevel: stocklevel.text,
                                    // category_id: int.parse(selectedCategory.ID! as String),
                                     category_id: selectedCategory!.ID,
                                    manufacturer_id: selectedManufacturer!.ID
                                    , ID: productId,category: null, manufacturer: null, sales: 0));
                                      await itemProvider.getAllProduct();
                                  Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => Product_List(),),
                                      (Route<dynamic> route) => false,
                                );
                                  showMessage(context, "Sửa thành công");

                                // onPressedUpdateProduct();
                              },
                              child: const Text(
                                "Sửa sản phẩm",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),
                          // Xóa sản phẩm
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
                              onPressed: ()async {
                                loading();
                               await itemProvider.deleteProduct(widget.id!);
                                await itemProvider.getAllProduct();
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) => Product_List(),),
                                      (Route<dynamic> route) => false,
                                );

                                showMessage(context, "Xóa thành công");
                                // onPressedDeleteProduct();
                              },
                              child: const Text(
                                "Xóa sản phẩm",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),
                        ],
                      ),
                      SizedBox(height: height * 0.2,),
                    ],
                  )
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
  //____________________________________________________________________________
  // Lấy hình ảnh từ điện thoại
  File? _image;

  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('Không có hình ảnh');
      return null;
    }
  }

  Future _getImage() async {
    final pickedImage = await pickImage(ImageSource.gallery);
    if(pickedImage!=null){
      String imageBytes = await convertImageToBase64(pickedImage);
      setState(() {
        _image = pickedImage;
        image=imageBytes;
      });


    }
  }
  //Chuyển hình ảnh thành base64
  Future<String> convertImageToBase64(File image) async {
    final bytes = await image.readAsBytes();
    final base64String = base64Encode(bytes);
    return base64String;
  }
  //____________________________________________________________________________
  //Lấy ngày giờ expiry
  Future<void> selectExpiryDate(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      DateTime pickedWithTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );
      setState(() {
        expiry.text = DateFormat('dd/MM/yyyy').format(picked);  // Định dạng theo ISO 8601 với múi giờ// Hiển thị định dạng ngắn gọn
      });
    }
  }
  //____________________________________________________________________________
//Update sản phẩm
  Future<void> onPressedUpdateProduct() async{

    await productHttp().UpdateProduct(new Product(sales:0,name: name.text, price: int.parse(price.text),
        image: image, size: int.parse(size.text),
        color: color.text, specification: specification.text,
        description: description.text, expiry: expiry.text,
        stocknumber: int.parse(stocknumber.text), stocklevel: stocklevel.text,
        category_id: selectedCategory!.ID, manufacturer_id: selectedManufacturer!.ID, ID: productId,category: null, manufacturer: null));

    Navigator.pop(context);
    showMessage(context, "Sửa thành công");
  }

  Future<void> onPressedDeleteProduct()async{
    await productHttp().deleteProduct(productId!);
    showMessage(context, "Xóa thành công");
    Navigator.pop(context);
  }

  void loading(){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
  }
}
