
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Widget/Widget_Category.dart';
import 'package:gmarket/Screens/Widget/Widget_Manufacturer.dart';
import 'package:gmarket/Screens/Widget/Widget_Product.dart';
import 'package:gmarket/Screens/Widget/Widget_PromoCode.dart';
import 'package:gmarket/Screens/Widget/Widget_User.dart';
import 'package:gmarket/Screens/Widget/Widget_Order.dart';

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
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        title: const Text("Quản Lý Cửa Hàng",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Coiny-Regular-font',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body:
      PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Cập nhật chỉ số hiện tại khi vuốt
          });
        },
        children: [
          Center(child: Widget_Product(),),
          Center(child: Widget_User(),),
          Center(child: Widget_Order(),),
          Center(child:Widget_PromoCode(),),
          Center(child:Widget_Category(),),
          Center(child:Widget_Manufacturer(),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xff5ec8f8),
        unselectedItemColor: const Color(0xff000000),
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cập nhật chỉ số khi nhấn
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ); // Chuyển đổi PageView
        },
        items: const [
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Loại',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.precision_manufacturing_outlined),
            activeIcon: Icon(Icons.precision_manufacturing),
            label: 'Nhà sản xuất',
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}