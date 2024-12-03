
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Screens/CustomerScreen/User_Info.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Delivering.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Paying.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Pending.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Returned.dart';
import 'package:gmarket/Screens/Widget/Widget_Order_Success.dart';

class Order_Info extends StatefulWidget {
  @override
  State createState() {
    return Order_Info_State();
  }
}

class Order_Info_State extends State<Order_Info> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(94, 200, 248, 1),
        titleTextStyle: const TextStyle(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context) => User_Info(),),
                  (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Text("Đơn hàng của bạn",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Coiny-Regular-font',
              color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body:PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Cập nhật chỉ số hiện tại khi vuốt
          });
        },
        children: [
          Center( child: Widget_Order_Paying(),),
          Center( child: Widget_Delivering(),),
          Center( child: Widget_Order_Success(),),
          Center( child: Widget_Order_Returned(),),
          Center( child: Widget_Pending(),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          selectedItemColor: const Color(0xff5ec8f8),
          unselectedItemColor: const Color(0xff000000),
          onTap: (value) {
            setState(() {
              _currentIndex=value;
            });
            _pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            activeIcon: Icon(Icons.payment),
            label: 'Chờ thanh toán',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining_outlined),
            activeIcon: Icon(Icons.delivery_dining),
            label: 'Chờ giao hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_outlined),
            activeIcon: Icon(Icons.check),
            label: 'Đã giao',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_return_outlined),
            activeIcon: Icon(Icons.assignment_return),
            label: 'Đã hủy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_outlined),
            activeIcon: Icon(Icons.pending),
            label: 'Chưa xử lí',
          ),
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

