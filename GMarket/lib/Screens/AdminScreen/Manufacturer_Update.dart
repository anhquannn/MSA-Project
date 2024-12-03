
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Http/Manufaturer.dart';
import 'package:gmarket/Models/Manufacturer.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Manufacturer_Update(id: 0,),
      )));
}

class Manufacturer_Update extends StatefulWidget{
  int? id;
  Manufacturer_Update({
    required this.id
});
  @override
  State createState() {
    return Manufacturer_Update_State();
  }
}
class Manufacturer_Update_State extends State<Manufacturer_Update> {

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  bool isLoading=true;
  int?id;
  Future getData(Manufacturer manu) async {
      setState(() {
        name.text = manu.name.toString();
        address.text = manu.address.toString();
        contact.text = manu.contact.toString();
      });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final manu=Provider.of<Manufacturer_Provider>(context,listen: false);
    manu.getManufacturerById(widget.id!).then((_){
      if(manu.manufacturer!=null){
        getData(manu.manufacturer!);
        setState(() {
          isLoading=false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemManufacturer=Provider.of<Manufacturer_Provider>(context,listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(94, 200, 248, 1),
          titleTextStyle: const TextStyle(
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Quay lại màn hình trước đó
            },
          ),
          title: TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              setState(()  async{
                // id=int.parse(value);
                // await getData(int.parse(value));
              });
            },
            decoration: InputDecoration(
              hintText: "Tìm kiếm",
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(94, 200, 248, 1),
                    width: 3,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    width: 4,
                    color: Color.fromRGBO(94, 200, 248, 1)
                ),
              ),
              prefixIcon: Icon(Icons.search, color: Colors.white,),
            ),
          ),
        ),
        body: isLoading  ? Center(child: CircularProgressIndicator(),):
        Center(
            child: Container(
                color: Colors.white,
                width: width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01,),
                      //Tên nhà sản xuất
                      TextField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: "Tên nhà sản xuất",
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
                      //Địa chỉ
                      TextField(
                        controller: address,
                        decoration: InputDecoration(
                          labelText: "Địa chỉ",
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
                            address.text = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      //Phương thức liên lạc
                      TextField(
                        controller: contact,
                        decoration: InputDecoration(
                          labelText: "Phương thức liên lạc",
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
                            contact.text = value;
                          });
                        },
                      ),
                      SizedBox(height: height * 0.01,),
                      Column(
                        children: [
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
                                itemManufacturer.updateManufacturer(new Manufacturer(
                                        name: name.text, address: address.text,
                                        ID: itemManufacturer.manufacturer!.ID,contact: contact.text));
                                Navigator.pop(context);
                                showMessage(context, "Sửa thành công");
                              },
                              child: const Text(
                                "Sửa nhà sản xuất",
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
                                itemManufacturer.deleteManufacturer(itemManufacturer.manufacturer!.ID).then((_){
                                  itemManufacturer.getAllManufacturer();
                                  Navigator.pop(context);
                                  showMessage(context, "Xóa thành công");
                                });

                              },
                              child: const Text(
                                "Xóa nhà sản xuất",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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

  Future onPressedUpdateManufacturer() async{
    if( await manufacturerHttp().updateManufacturer(new Manufacturer(name: name.text, address: address.text, ID: id!,contact: contact.text))==true){
      Navigator.pop(context);
      showMessage(context, "Thêm thành công");
    }
    else{
      showMessage(context, "Vui lòng điền đầy đủ dữ liệu");
    }
  }
}
