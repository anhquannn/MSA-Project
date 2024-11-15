
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Product.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_PromoCode.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_User.dart';
import 'package:gmarket/Screens/AdminScreen/Widget/Widget_Order.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: Scaffold(
      body: AdminScreen(),
    ),
  ));
}

class AdminScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AdminScreenState();
  }
}

class AdminScreenState extends State<AdminScreen>{
  int _selectedIndex = 0;
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Center(child: Widget_Product(),),
          Center(child: Widget_User(),),
          Center(child: Widget_Order(),),
          Center(child:Widget_PromoCode(),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff5ec8f8),
          unselectedItemColor: const Color(0xff000000),
          type: _bottomNavType,
          onTap: (value) {
            onTap(value);
            print(value);
          },
          items: _navBarItem),
      );
  }

  void onTap(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  static const _navBarItem=[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_rounded),
      label: 'Sản Phẩm',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_rounded),
      activeIcon: Icon(Icons.person_rounded),
      label: 'Người Dùng',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
      label: 'Đơn Hàng',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark_border_outlined),
      activeIcon: Icon(Icons.bookmark_rounded),
      label: 'Mã Giảm Giá',
    )
  ];
  
}