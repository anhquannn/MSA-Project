
import 'dart:convert';
import 'dart:io';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Category.dart';
import 'package:gmarket/Http/Manufaturer.dart';
import 'package:gmarket/Models/Category.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Models/Product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    home: Scaffold(
      body: Add_Product(),
    )));
}

class Add_Product extends StatefulWidget{
  @override
  State createState() {
    return Add_Product_State();
  }
}
class Add_Product_State extends State<Add_Product> {

  late String name;
  late int price;
  late String image='';
  late int size;
  late String color;
  late String specification;
  late String description;
  late int stocknumber;
  late String stocklevel = "Low";
  late int category_id;
  late int manufaturer_id;

  late String expiry;

  Category? selectedCategory;
  Manufacturer? selectedManufacturer;
  Future<List<Category>?> listCategory = categoryHttp().getAllCategory();

  late bool flagImage = false;

  @override
  void initState() {
    super.initState();
    listCategory = categoryHttp().getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemProduct=Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          titleTextStyle: const TextStyle(
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Mũi tên quay lại màu trắng
            onPressed: () {
              Navigator.pop(context); // Quay lại màn hình trước đó
            },
          ),
          title: const Text("Quản Lý Cửa Hàng",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Coiny-Regular-font',
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
                color: Colors.white,
                width: width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01,),
                      //Tên sản phẩm
                      TextField(
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
                            name = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      //Giá sản phẩm
                      TextField(
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
                            price = int.parse(value);
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      //Size sản phẩm
                      TextField(
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
                            size = int.parse(value);
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Màu sản phẩm
                      TextField(
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
                            color = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Thông số sản phẩm
                      TextField(
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
                            specification = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.02,),
                      //Mô tả sản phẩm
                      TextField(
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
                            description = value;
                          });
                        },
                      ),
                  //Hạn sử dụng sản phẩm
                      SizedBox(height: height * 0.02,),
                      TextField(
                        readOnly: true,
                        controller: dateController,
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
                            stocknumber = int.parse(value);
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
                            stocklevel = value!;
                          });
                        },
                        value: stocklevel,
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

                              hint: Text('${selectedCategory?.name.toString()}',
                                style: const TextStyle(color: Colors.black),),

                              value: categories.contains(selectedCategory)
                                  ? selectedCategory
                                  : null,
                              onChanged: (Category? newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                  category_id=selectedCategory!.ID;
                                  print(selectedCategory?.name.toString());
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
                                  selectedManufacturer = value;
                                  manufaturer_id=selectedManufacturer!.ID;
                                  print(selectedManufacturer?.name.toString());
                                });
                              },

                              value: manu.contains(selectedManufacturer)
                                  ? selectedManufacturer
                                  : null,

                              hint: Text(
                                '${selectedManufacturer?.name.toString()}',
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
                      Row(
                          children: [
                            SizedBox(width: width*0.025,),
                            ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color.fromRGBO(94, 200, 248, 1)),
                                onPressed: _image==null ? getImage : null,
                                child: const Text(
                                  "Chọn hình ảnh",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Coiny-Regular-font'),
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color.fromRGBO(94, 200, 248, 1)),
                                onPressed: () {
                                  setState(() {
                                    _image=null;
                                  });
                                },
                                child: const Text(
                                  "Xóa hình ảnh",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Coiny-Regular-font'),
                                )),
                          ],
                      ),
                      SizedBox(height: height * 0.02,),
                      Container(
                        width: width,
                        height: width,
                        child: _image != null ?
                        ClipRRect(child: Image.file(_image!, fit: BoxFit.cover),) :
                        const Center(child: Text('Vui lòng chọn ảnh'),
                        ),

                      ),
                      SizedBox(height: height * 0.02,),
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
                            if(isValid()==0){
                              showMessage(context, "Hạn sử dụng quá ngắn");
                            }
                            else{
                              try{
                                final ig=await convertImageToBase64(_image!);
                                setState(() {
                                  image=ig;
                                });
                                itemProduct.createProduct(new Product(sales: 0, name: name, price: price,
                                    image: image, size: size, color: color,
                                    specification: specification, description: description,
                                    stocknumber: stocknumber, stocklevel: stocklevel,
                                    category_id: category_id, manufacturer_id: manufaturer_id,ID: 0,
                                    expiry: expiry,
                                    category: null,manufacturer: null)).then((_){
                                  if(itemProduct.isSucess==true){
                                    Navigator.pop(context);
                                    showMessage(context, "Thêm thành công");
                                  }
                                  else{
                                    showMessage(context, "Thêm không thành công");
                                  }
                                });
                              }catch(e){
                                showMessage(context, 'Lỗi tạo sản phẩm: $e');
                                throw Exception('Lỗi tạo sản phẩm: $e');
                              }
                            }

                            },
                          child: const Text(
                            "Tạo sản phẩm",
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
  File? _image;
  //lấy hình ảnh
  Future getImage() async {
    final pickedImage = await pickImage(ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        _image = pickedImage;
      });
    }
    else{
      print("Không thể lấy hình ảnh");
    }

  }
  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  //Chuyển hình ảnh thành base64
  Future<String> convertImageToBase64(File image) async {
    final bytes = await image.readAsBytes();
    final base64String = base64Encode(bytes);
    return base64String;
  }
  //____________________________________________________________________________
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
      String formattedDate = pickedWithTime.toUtc().toIso8601String();
      setState(() {
        date=pickedWithTime;
        expiry = formattedDate;  // Định dạng theo ISO 8601 với múi giờ
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);  // Hiển thị định dạng ngắn gọn
      });
    }
  }
  DateTime? date;
  int isValid(){
    if(date!.isBefore(DateTime.now())){
      return 0;
    }
    return 1;
  }
  }
