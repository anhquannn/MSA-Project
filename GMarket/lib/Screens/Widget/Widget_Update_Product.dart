
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Category.dart';
import 'package:gmarket/Http/Manufaturer.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Widget_Update_Product(id:0),
      )));
}

class Widget_Update_Product extends StatefulWidget{
  int? id;
  Widget_Update_Product({
    required this.id
});
  @override
  State createState() {
    return Widget_Update_Product_State();
  }
}

class Widget_Update_Product_State extends State<Widget_Update_Product> {

  int? productId;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController specification = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stocknumber = TextEditingController();
  TextEditingController stocklevel = TextEditingController();
  TextEditingController category_id = TextEditingController();
  TextEditingController manufaturer_id = TextEditingController();
  TextEditingController expiry = TextEditingController();
  Category? selectedCategory;
  Manufacturer? selectedManufacturer;
  Product? product;
//Lấy dữ liệu

  Future getData() async {
    final product = await productHttp().getProductById(widget.id!);
    selectedCategory =
    await categoryHttp().getCategoryById(product!.category_id!);
    setState(() {
      productId = product.ID;
      name.text = product.name.toString();
      price.text = product.price.toString();
      image.text = product.image.toString();
      size.text = product.size.toString();
      color.text = product.color.toString();
      specification.text = product.specification.toString();
      description.text = product.description.toString();
      stocknumber.text = product.stocknumber.toString();
      print("chay try catch");
      stocklevel.text = product.stocklevel.toString();
      category_id.text = product.category_id.toString();
      manufaturer_id.text = product.manufacturer_id.toString();
      expiry.text = DateFormat('dd/MM/yyyy').format(
          DateTime.parse(product.expiry.toString()));
    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Material(
          child: Center(
            child: Container(
                color: Colors.white,
                width: width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('${widget.id}'),
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
                      FutureBuilder<List<Category>>(
                        future: categoryHttp().getAllCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Text('Không có category');
                          } else {
                            List<Category> categories = snapshot.data!;
                            // Kiểm tra nếu selectedCategory không tồn tại trong categories thì đặt thành null
                            return DropdownButtonFormField<Category>(
                              decoration: InputDecoration(
                                labelText: "Loại sản phẩm",
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
                                  ),),),
                              style: const TextStyle(
                                color: Colors.black, fontSize: 15,),

                              hint: Text('${categories[int.parse(category_id.text)-1].name.toString()}',
                                style: const TextStyle(color: Colors.black),),

                              value: categories.contains(categories[int.parse(category_id.text)-1])
                                  ? categories[int.parse(category_id.text)-1]
                                  : null,
                              onChanged: (Category? newValue) {
                                setState(() {
                                  category_id.text=newValue!.ID.toString();
                                  print(newValue.name.toString());
                                });
                              },
                              items: categories.map((Category category) {
                                return DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.name),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Mã nhà sản xuất sản phẩm
                      FutureBuilder<List<Manufacturer>>(
                        future: manufacturerHttp().getAllManufacturer(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          else if (snapshot.hasError)
                            return Text("Error '${snapshot.hasError}'");
                          else if (!snapshot.hasData || snapshot.data!.isEmpty)
                            return Text("Không có Manufacturer");
                          else {
                            List<Manufacturer> manu = snapshot.data!;
                            return DropdownButtonFormField<Manufacturer>(
                              items: manu.map((Manufacturer manufac) {
                                return DropdownMenuItem(
                                  value: manufac,
                                  child: Text(manufac.name),
                                );
                              }).toList(),

                              onChanged: (Manufacturer? value) {
                                setState(() {
                                  manufaturer_id.text=value!.ID.toString();
                                  print(selectedManufacturer?.name.toString());
                                });
                              },
                              value: manu.contains(manu[int.parse(manufaturer_id.text)-1])
                                  ? manu[int.parse(manufaturer_id.text)-1]
                                  : null,

                              hint: Text(
                                '${manu[int.parse(manufaturer_id.text)-1].name.toString()}',
                                style: TextStyle(color: Colors.black),),

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
                                  ),),),
                            );
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Hình ảnh
                      SizedBox(width: width*0.025,),
                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromRGBO(94, 200, 248, 1)),
                        onPressed: () {
                          _image==null;
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
                        child: _image != null ?
                        ClipRRect(child: Image.file(_image!, fit: BoxFit.cover),) :
                        Image.memory(base64Decode(image.text),fit: BoxFit.cover,),
                        ),
                      //test hình ảnh
                      // ElevatedButton(
                      //     onPressed: () {
                      //       chuyen();
                      //       print('$image');
                      //     },
                      //   child: Text('Chuyển sang base64'),),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     chuyen();
                      //     print('$image');
                      //     // Image.memory(base64Decode(image));
                      //   },
                      //   child: Text('Chuyen sang hinh anh'),),
                      // Container(
                      //   child: Image.memory(base64Decode(image!)),
                      // ),
                      Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(94, 200, 248, 1)),
                              onPressed: () {
                                onPressedUpdateProduct();
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
                                onPressedDeleteProduct();
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
                  ),
                )
            ),
          ),
        )
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
        setState(() {
          _image = pickedImage;
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
TextEditingController dateController=TextEditingController();
Future<void> selectExpiryDate(context) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    // Kết hợp ngày được chọn với giờ hiện tại để có đầy đủ thời gian
    DateTime pickedWithTime = DateTime(
      picked.year,
      picked.month,
      picked.day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
      DateTime.now().millisecond,
      DateTime.now().microsecond,
    );
    // Chuyển sang chuỗi ISO 8601 với múi giờ địa phương
    DateTime formattedExpiry = pickedWithTime.toLocal();
    setState(() {
      expiry.text = formattedExpiry.toString();  // Định dạng theo ISO 8601 với múi giờ
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);  // Hiển thị định dạng ngắn gọn
    });
  }
}
  //____________________________________________________________________________
//Update sản phẩm
Future<void> onPressedUpdateProduct() async{
  await productHttp().UpdateProduct(new Product(sales: 0, name: name.text, price: int.parse(price.text),
      image: await convertImageToBase64(_image!), size: int.parse(size.text),
      color: color.text, specification: specification.text,
      description: description.text, expiry: expiry.text,
      stocknumber: int.parse(stocknumber.text), stocklevel: stocklevel.text,
      category_id: int.parse(category_id.text), manufacturer_id: int.parse(manufaturer_id.text), ID: productId, manufacturer: null, category: null));
}
Future<void> onPressedDeleteProduct()async{
  await productHttp().deleteProduct(productId!);
}
}

