
import 'dart:convert';
import 'dart:io';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Product_Update_Delete(id: 0,),
      )));
}

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
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  String? image = "";
  TextEditingController size = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController specification = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stocknumber = TextEditingController();
  TextEditingController stocklevel = TextEditingController();
  // TextEditingController category_id = TextEditingController();
  // TextEditingController manufaturer_id = TextEditingController();
  TextEditingController expiry = TextEditingController();
  Category? selectedCategory;
  Manufacturer? selectedManufacturer;
  Product? product;
  List<Category>? listCate;
  String? namee;

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    size.dispose();
    color.dispose();
    specification.dispose();
    description.dispose();
    stocknumber.dispose();
    stocklevel.dispose();
    // category_id.dispose();
    // manufaturer_id.dispose();
    expiry.dispose();
    super.dispose();
  }
//Lấy dữ liệu
  Future getData(Product data) async {
    setState(() {
      _image=null;
      image = data.image.toString();
      productId = data.ID;
      name.text = data.name.toString();
      price.text = data.price.toString();
      size.text = data.size.toString();
      color.text = data.color.toString();
      specification.text = data.specification.toString();
      description.text = data.description.toString();
      stocknumber.text = data.stocknumber.toString();
      stocklevel.text = data.stocklevel.toString();
      expiry.text = data.expiry.toString();

    });
  }
  bool _isInitialized = false;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if (!_isInitialized) {
      final itemProvider = Provider.of<ProductProvider>(context);

      itemProvider.getProductById(widget.id!).then((_) {
        final product = itemProvider.product;
        if (product != null) {
            getData(product);
        }
        setState(() {
          selectedManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false).manufacturer;
          selectedCategory=Provider.of<Category_Provider>(context, listen: false).category;
            _isInitialized = true;
        });
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ProductProvider>(context);
    final itemCategory=Provider.of<Category_Provider>(context);
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context);

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
      body: _isInitialized==false? Center(child: CircularProgressIndicator(),):
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
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        items: const [
                          DropdownMenuItem(
                              value: 'Low',
                              child: Text('Thấp')
                          ),
                          DropdownMenuItem(
                              value: 'Medium',
                              child: Text('Trung Bình')
                          ),
                          DropdownMenuItem(
                              value: 'High',
                              child: Text('Cao')
                          )
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            stocklevel.text = value!;
                          });
                        },
                        value: stocklevel.text,
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
                         // value: selectedCategory,
                        onChanged: (Category? newValue) {
                          setState(() {
                              selectedCategory = newValue;
                              // category_id.text = newValue.ID.toString();
                          });
                        },
                        items: itemCategory.list.map<DropdownMenuItem<Category>>((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        hint: Text('${Provider.of<Category_Provider>(context).category!.name}'),
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
                      //Hình ảnh
                      SizedBox(width: width*0.025,),
                      ElevatedButton(

                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color.fromRGBO(94, 200, 248, 1)),
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
                      Container(
                          width: width,
                          height: width,
                          child:
                          Image.memory(base64Decode(image!),fit: BoxFit.cover,)

                      ),
                      Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(94, 200, 248, 1)),
                              onPressed: () {
                                print('asdf asdfa sdf df ${selectedManufacturer!.name}');
                                print('asdf asdfa sdf df ${selectedCategory!.name}');
                                if(selectedCategory==null){
                                  selectedCategory=Provider.of<Category_Provider>(context, listen: false).category;
                                }
                                if(selectedManufacturer==null){
                                  selectedManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false).manufacturer;
                                }
                                itemProvider.updateProduct(new Product(name: name.text, price: int.parse(price.text),
                                    image: image, size: int.parse(size.text),
                                    color: color.text, specification: specification.text,
                                    description: description.text, expiry: expiry.text,
                                    stocknumber: int.parse(stocknumber.text), stocklevel: stocklevel.text,
                                    // category_id: int.parse(selectedCategory.ID! as String),
                                     category_id: selectedCategory!.ID,
                                    manufacturer_id: selectedManufacturer!.ID
                                    , ID: productId,category: null, manufacturer: null, sales: 0)).then((_){
                                      itemProvider.getAllProduct();
                                  Navigator.pop(context);
                                  showMessage(context, "Sửa thành công");
                                    });

                                // onPressedUpdateProduct();
                              },
                              child: const Text(
                                "Sửa sản phẩm",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Coiny-Regular-font'),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(94, 200, 248, 1)),
                              onPressed: () {
                                itemProvider.deleteProduct(widget.id!);
                                Navigator.pop(context);
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
}
