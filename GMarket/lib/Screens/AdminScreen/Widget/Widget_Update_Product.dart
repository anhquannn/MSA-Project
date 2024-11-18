//
// import 'dart:convert';
// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gmarket/Http/Category.dart';
// import 'package:gmarket/Http/Manufaturer.dart';
// import 'package:gmarket/Http/Product.dart';
// import 'package:gmarket/Models/Category.dart';
// import 'package:gmarket/Models/Manufacturer.dart';
// import 'package:gmarket/Models/Product.dart';
// import 'package:image_picker/image_picker.dart';
//
// void main(){
//   runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Widget_Update_Product(id: 0,),
//       )));
// }
//
// class Widget_Update_Product extends StatefulWidget{
//   int? id;
//   Widget_Update_Product({
//     required this.id
//   });
//
//   @override
//   State createState() {
//     return Widget_Update_Product_State();
//   }
// }
// class Widget_Update_Product_State extends State<Widget_Update_Product> {
//
//   TextEditingController name = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController image = TextEditingController();
//   TextEditingController size = TextEditingController();
//   TextEditingController color = TextEditingController();
//   TextEditingController specification = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController stocknumber = TextEditingController();
//   TextEditingController stocklevel = TextEditingController();
//   TextEditingController category_id = TextEditingController();
//   TextEditingController manufaturer_id = TextEditingController();
//
//   String? getName;
//   int? getPrice;
//   String? getImage;
//   int? getSize;
//   String? getColor;
//   String? getSpecification;
//   String? getDescription;
//   int? getStocknumber;
//   String? getStocklevel;
//   int? getCategory_id;
//   int? getManufaturer_id;
//
//   late DateTime expiry;
//
//   Category? selectedCategory;
//   Manufacturer? selectedManufacturer;
//
//   int? searchProduct;
//
//   @override
//   Future<void> initState() async {
//     super.initState();
//     final product= await productHttp().getProductById(widget.id!);
//     if(product!=null){
//       this.name.text=product.name!;
//       this.price.text=product.price.toString();
//       this.size.text=product.size.toString();
//       this.color.text=product.color!;
//       this.specification.text=product.specification!;
//       this.description.text=product.description!;
//       this.stocknumber.text=product.stocknumber.toString();
//       this.stocklevel.text=product.stocklevel!;
//       this.category_id.text=product.category_id.toString();
//       this.manufaturer_id.text=product.manufacturer_id.toString();
//
//       this.name.addListener(() => this.getName=name.toString(),);
//       this.price.addListener(() => this.getPrice=int.parse(price.toString()),);
//       this.size.addListener(() => this.getSize=int.parse(size.toString()),);
//       this.color.addListener(() => this.getColor=color.toString(),);
//       this.specification.addListener(() => this.getSpecification=specification.toString(),);
//       this.stocknumber.addListener(() => this.getStocknumber=int.parse(stocknumber.toString()),);
//       this.stocklevel.addListener(() => this.getStocklevel=stocklevel.toString(),);
//       this.description.addListener(() => this.getDescription=description.toString(),);
//       this.category_id.addListener(() => this.getCategory_id=int.parse(category_id.toString()),);
//       this.manufaturer_id.addListener(() => this.getManufaturer_id=int.parse(manufaturer_id.toString()),);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//         body: Material(
//           child: Center(
//             child: Container(
//                 color: Colors.white,
//                 width: width * 0.9,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: height*0.02,),
//                       //Tên sản phẩm
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: "Tên sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getName = value;
//                           });
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Giá sản phẩm
//                       TextField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "Giá sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getPrice = int.parse(value);
//                           });
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Size sản phẩm
//                       TextField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "Size sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getSize = int.parse(value);
//                           });
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Màu sản phẩm
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: "Màu sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getColor = value;
//                           });
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Thông số sản phẩm
//                       TextField(
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(
//                           labelText: "Thông số sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getSpecification = value;
//                           });
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Mô tả sản phẩm
//                       TextField(
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(
//                           labelText: "Mô tả sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getDescription = value;
//                           });
//                         },
//                       ),
//                       //Hạn sử dụng sản phẩm
//                       //     SizedBox(height: height * 0.02,),
//                       //     TextField(
//                       //       readOnly: true,
//                       //       controller: dateController,
//                       //       decoration: InputDecoration(
//                       //         labelText: "Hạn sử dụng sản phẩm",
//                       //         labelStyle: const TextStyle(
//                       //             color: Colors.black,
//                       //             fontSize: 18,
//                       //             fontFamily: 'Coiny-Regular-font'
//                       //         ),
//                       //         focusedBorder: OutlineInputBorder(
//                       //             borderRadius: BorderRadius.circular(20),
//                       //             borderSide: const BorderSide(
//                       //               color: Color.fromRGBO(94, 200, 248, 1),
//                       //               width: 3,
//                       //             )
//                       //         ),
//                       //         enabledBorder: OutlineInputBorder(
//                       //             borderRadius: BorderRadius.circular(15),
//                       //             borderSide: const BorderSide(
//                       //               color: Color.fromRGBO(94, 200, 248, 1),
//                       //               width: 2,
//                       //             )
//                       //         ),
//                       //       ),
//                       //       style: const TextStyle(
//                       //           color: Colors.black,
//                       //           fontSize: 15
//                       //       ),
//                       //       onTap: () => selectExpiryDate(context),
//                       //     ),
//                       SizedBox(height: height * 0.02,),
//                       //Số lượng tồn kho sản phẩm
//                       TextField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: "Số lượng tồn kho sản phẩm",
//                           labelStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               fontFamily: 'Coiny-Regular-font'
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 3,
//                               )
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                 color: Color.fromRGBO(94, 200, 248, 1),
//                                 width: 2,
//                               )
//                           ),
//                         ),
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             getStocknumber = int.parse(value);
//                           });
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Mức tồn kho sản phẩm
//                       DropdownButtonFormField<String>(
//                         style: TextStyle(color: Colors.black, fontSize: 15),
//                         items: const [
//                           DropdownMenuItem(
//                               value: 'Low',
//                               child: Text('Thấp')
//                           ),
//                           DropdownMenuItem(
//                               value: 'Medium',
//                               child: Text('Trung Bình')
//                           ),
//                           DropdownMenuItem(
//                               value: 'High',
//                               child: Text('Cao')
//                           )
//                         ],
//                         onChanged: (String? value) {
//                           setState(() {
//                             getStocklevel = value!;
//                           });
//                         },
//                         value: getStocklevel,
//                         decoration: InputDecoration(
//                           labelText: "Mức tồn kho sản phẩm",
//                           labelStyle: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontFamily: 'Coiny-Regular-font',
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: const BorderSide(
//                               color: Color.fromRGBO(94, 200, 248, 1),
//                               width: 3,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(
//                               color: Color.fromRGBO(94, 200, 248, 1),
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Mã loại sản phẩm
//                       FutureBuilder<List<Category>>(
//                         future: categoryHttp().getAllCategory(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasError) {
//                             return Text('Error: ${snapshot.error}');
//                           } else
//                           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                             return Text('Không có category');
//                           } else {
//                             List<Category> categories = snapshot.data!;
//                             // Kiểm tra nếu selectedCategory không tồn tại trong categories thì đặt thành null
//                             return DropdownButtonFormField<Category>(
//                               decoration: InputDecoration(
//                                 labelText: "Loại sản phẩm",
//                                 labelStyle: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontFamily: 'Coiny-Regular-font',
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromRGBO(94, 200, 248, 1),
//                                     width: 3,
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromRGBO(94, 200, 248, 1),
//                                     width: 2,
//                                   ),),),
//                               style: const TextStyle(
//                                 color: Colors.black, fontSize: 15,),
//
//                               hint: Text('${selectedCategory?.name.toString()}',
//                                 style: const TextStyle(color: Colors.black),),
//
//                               value: categories.contains(selectedCategory)
//                                   ? selectedCategory
//                                   : null,
//                               onChanged: (Category? newValue) {
//                                 setState(() {
//                                   selectedCategory = newValue;
//                                   getCategory_id=selectedCategory!.category_id;
//                                   print(selectedCategory?.name.toString());
//                                 });
//                               },
//                               items: categories.map((Category category) {
//                                 return DropdownMenuItem<Category>(
//                                   value: category,
//                                   child: Text(category.name),
//                                 );
//                               }).toList(),
//                             );
//                           }
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Mã nhà sản xuất sản phẩm
//                       FutureBuilder<List<Manufacturer>>(
//                         future: manufacturerHttp().getAllManufacturer(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting)
//                             return CircularProgressIndicator();
//                           else if (snapshot.hasError)
//                             return Text("Error '${snapshot.hasError}'");
//                           else if (!snapshot.hasData || snapshot.data!.isEmpty)
//                             return Text("Không có Manufacturer");
//                           else {
//                             List<Manufacturer> manu = snapshot.data!;
//                             return DropdownButtonFormField<Manufacturer>(
//                               items: manu.map((Manufacturer manufac) {
//                                 return DropdownMenuItem(
//                                   value: manufac,
//                                   child: Text(manufac.name),
//                                 );
//                               }).toList(),
//
//                               onChanged: (Manufacturer? value) {
//                                 setState(() {
//                                   selectedManufacturer = value;
//                                   getManufaturer_id=selectedManufacturer!.ID;
//                                   print(selectedManufacturer?.name.toString());
//                                 });
//                               },
//
//                               value: manu.contains(selectedManufacturer)
//                                   ? selectedManufacturer
//                                   : null,
//
//                               hint: Text(
//                                 '${selectedManufacturer?.name.toString()}',
//                                 style: TextStyle(color: Colors.black),),
//
//                               decoration: InputDecoration(
//                                 labelText: "Loại sản phẩm",
//                                 labelStyle: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontFamily: 'Coiny-Regular-font',
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromRGBO(94, 200, 248, 1),
//                                     width: 3,
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromRGBO(94, 200, 248, 1),
//                                     width: 2,
//                                   ),),),
//                             );
//                           }
//                         },
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       //Hình ảnh
//                       Row(
//                         children: [
//                           SizedBox(width: width*0.025,),
//                           ElevatedButton(
//
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                   const Color.fromRGBO(94, 200, 248, 1)),
//                               onPressed: _image==null ? _getImage : null,
//                               child: const Text(
//                                 "Chọn hình ảnh",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 15,
//                                     fontFamily: 'Coiny-Regular-font'),
//                               )),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                   const Color.fromRGBO(94, 200, 248, 1)),
//                               onPressed: () {
//                                 setState(() {
//                                   _image=null;
//                                 });
//                               },
//                               child: const Text(
//                                 "Xóa hình ảnh",
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 15,
//                                     fontFamily: 'Coiny-Regular-font'),
//                               )),
//                         ],
//                       ),
//                       SizedBox(height: height * 0.02,),
//                       Container(
//                         width: width,
//                         height: width,
//                         child: _image != null ?
//                         ClipRRect(child: Image.file(_image!, fit: BoxFit.cover),) :
//                         const Center(child: Text('Vui lòng chọn ảnh'),
//                         ),
//
//                       ),
//                       //test hình ảnh
//                       // ElevatedButton(
//                       //     onPressed: () {
//                       //       chuyen();
//                       //       print('$image');
//                       //     },
//                       //   child: Text('Chuyển sang base64'),),
//                       // ElevatedButton(
//                       //   onPressed: () {
//                       //     chuyen();
//                       //     print('$image');
//                       //     // Image.memory(base64Decode(image));
//                       //   },
//                       //   child: Text('Chuyen sang hinh anh'),),
//                       // Container(
//                       //   child: Image.memory(base64Decode(image!)),
//                       // ),
//
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                               const Color.fromRGBO(94, 200, 248, 1)),
//                           onPressed: () {
//                             onPressedCreateProduct();
//                           },
//                           child: const Text(
//                             "Tạo sản phẩm",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                                 fontFamily: 'Coiny-Regular-font'),
//                           )),
//                       SizedBox(height: height * 0.2,),
//                     ],
//                   ),
//                 )
//             ),
//           ),
//         )
//     );
//   }
//
//   void showMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//         backgroundColor: Colors.blue,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
//   Future<void> onPressedCreateProduct() async{
//
//     try{
//       final ig=await convertImageToBase64(_image!);
//       setState(() {
//         getImage=ig;
//         //test
//         getName="name";
//         getPrice=2000000;
//         getSize=12;
//         getColor="xanh";
//         getSpecification="sfdgdfgsdfgdsfgdfg";
//         getDescription="sdfsdfsdfsdcsfseefdfsdf";
//         getStocknumber=22;
//         getCategory_id=1;
//         getManufaturer_id=1;
//         //
//       });
//       print('Base64 của hình ảnh: $image -----');
//
//
//       await productHttp().createProduct(
//           new Product( name: getName, price: getPrice,
//               image: getImage, size: getSize, color: getColor,
//               specification: getSpecification, description: getDescription,
//               stocknumber: getStocknumber, stocklevel: getStocklevel,
//               category_id: getCategory_id, manufacturer_id: getManufaturer_id,ID: 1));
//       // Navigator.pop(context);
//     }catch(e){
//       throw Exception('Lỗi tạo sản phẩm: $e');
//     }
//   }
//   //____________________________________________________________________________
//   //Lấy hình ảnh từ điện thoại
//   File? _image;
//   Future<File?> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     } else {
//       print('No image selected.');
//       return null;
//     }
//   }
//
//   Future _getImage() async {
//     final pickedImage = await pickImage(ImageSource.gallery);
//     if(pickedImage!=null){
//       setState(() {
//         _image = pickedImage;
//       });
//     }
//     else{
//       print("Không thể lấy hình ảnh");
//     }
//
//   }
//   //Chuyển hình ảnh thành base64
//   Future<String> convertImageToBase64(File image) async {
//     final bytes = await image.readAsBytes();
//     final base64String = base64Encode(bytes);
//     return base64String;
//   }
// //____________________________________________________________________________
// // TextEditingController dateController=TextEditingController();
// // Future<void> selectExpiryDate(context) async {
// //   DateTime? picked = await showDatePicker(
// //     context: context,
// //     initialDate: DateTime.now(),
// //     firstDate: DateTime(2000),
// //     lastDate: DateTime(2100),
// //   );
// //
// //   if (picked != null) {
// //     // Kết hợp ngày được chọn với giờ hiện tại để có đầy đủ thời gian
// //     DateTime pickedWithTime = DateTime(
// //       picked.year,
// //       picked.month,
// //       picked.day,
// //       DateTime.now().hour,
// //       DateTime.now().minute,
// //       DateTime.now().second,
// //       DateTime.now().millisecond,
// //       DateTime.now().microsecond,
// //     );
// //     // Chuyển sang chuỗi ISO 8601 với múi giờ địa phương
// //     DateTime formattedExpiry = pickedWithTime.toLocal();
// //     setState(() {
// //       expiry = formattedExpiry;  // Định dạng theo ISO 8601 với múi giờ
// //       dateController.text = DateFormat('dd/MM/yyyy').format(picked);  // Hiển thị định dạng ngắn gọn
// //     });
// //   }
// // }
//   Future  getProductById(String value) async{
//     int id=int.parse(value);
//     final product=await productHttp().getProductById(id);
//     setState(() {
//       getName=product?.name;
//       getPrice=product?.price;
//       getImage=product?.image;
//       getSize=product?.size;
//       getColor=product?.color;
//       getSpecification=product?.specification;
//       getDescription=product?.description;
//       getStocknumber=product?.stocknumber;
//       getStocklevel=product?.stocklevel;
//       getCategory_id=product?.category_id;
//       getManufaturer_id=product?.manufacturer_id;
//     });
//   }
//
// }
