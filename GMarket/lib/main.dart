import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gmarket/Provider/CartItem_Provider.dart';
import 'package:gmarket/Provider/Cart_Provider.dart';
import 'package:gmarket/Provider/Category_Provider.dart';
import 'package:gmarket/Provider/DeliveryDetail_Provider.dart';
import 'package:gmarket/Provider/Delivery_Provider.dart';
import 'package:gmarket/Provider/FeedBack_Provider.dart';
import 'package:gmarket/Provider/Manufacturer_Provider.dart';
import 'package:gmarket/Provider/OrderDetail_Provider.dart';
import 'package:gmarket/Provider/Order_Provider.dart';
import 'package:gmarket/Provider/Payment_Provider.dart';
import 'package:gmarket/Provider/Product_Provider.dart';
import 'package:gmarket/Provider/Promocode_Provider.dart';
import 'package:gmarket/Provider/RetrunOrder.dart';
import 'package:gmarket/Provider/User_Provider.dart';
import 'package:gmarket/Screens/Logins/Login.dart';
import 'package:provider/provider.dart';

// void main() {
//       runApp(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => ProductProvider()),
//             ChangeNotifierProvider(create: (_) => ReturnOrder_Provider()),
//             ChangeNotifierProvider(create: (_) => Category_Provider()),
//             ChangeNotifierProvider(create: (_) => Manufacturer_Provider()),
//             ChangeNotifierProvider(create: (_) => User_Provider()),
//             ChangeNotifierProvider(create: (_) => Cart_Provider()),
//             ChangeNotifierProvider(create: (_) => CartItem_Provider()),
//             ChangeNotifierProvider(create: (_) => FeedBack_Provider()),
//             ChangeNotifierProvider(create: (_) => Order_Provider()),
//             ChangeNotifierProvider(create: (_) => OrderDetail_Provider()),
//             ChangeNotifierProvider(create: (_) => Promocode_Provider()),
//             ChangeNotifierProvider(create: (_) => Payment_Provider()),
//           ],
//           child: MyApp(),
//         ),
//       );
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Login(),
//     );
//   }
// }
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kReleaseMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      FlutterError.presentError(details);
    }
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ReturnOrder_Provider()),
        ChangeNotifierProvider(create: (_) => Category_Provider()),
        ChangeNotifierProvider(create: (_) => Manufacturer_Provider()),
        ChangeNotifierProvider(create: (_) => User_Provider()),
        ChangeNotifierProvider(create: (_) => Cart_Provider()),
        ChangeNotifierProvider(create: (_) => CartItem_Provider()),
        ChangeNotifierProvider(create: (_) => FeedBack_Provider()),
        ChangeNotifierProvider(create: (_) => Order_Provider()),
        ChangeNotifierProvider(create: (_) => OrderDetail_Provider()),
        ChangeNotifierProvider(create: (_) => Promocode_Provider()),
        ChangeNotifierProvider(create: (_) => Payment_Provider()),
        ChangeNotifierProvider(create: (_) => Delivery_Provider()),
        ChangeNotifierProvider(create: (_) => DeliveryDetail_Provider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
