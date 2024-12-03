import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Payment.dart';
import 'package:gmarket/Models/Payment.dart';

class Payment_Provider extends ChangeNotifier{
  List<Payment> _listPayment=[];
  bool _isLoading=false;
  Payment? _payment;

  List<Payment> get listPayment=>_listPayment;
  bool get isLoading=>_isLoading;
  Payment? get payment=>_payment;

  Future getAllPayment()async{
    _isLoading=true;
    notifyListeners();
    try{
      List<Payment> pay=await paymentHttp().getAllPayments();
      _listPayment=pay;
    }catch(e){
      print("Provider - Khong the lay  Payment");
    } finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future createPayment(Payment pay)async{
    final result=await paymentHttp().createPayment(pay);
    if(result!=null){
      _payment=result;
    }else{
      print("Provider - Khong the tao Payment");
    }
  }

  Future updatePayment(Payment pay)async{
    final result=await paymentHttp().updatePayment(pay);
    if(result!=null){
      _payment=result;
    }else{
      print("Provider - Khong the update updatePayment");
    }
  }

  Future deletePayment(int id) async{
    final result=await paymentHttp().deletePayment(id);
    if(result==true){
      print("Provider - deletePayment");
    }else{
      print("Provider - Khong the deletePayment");
    }
  }

  Future getPaymentByID(int id) async{
    _payment=null;
    _isLoading=true;
    notifyListeners();
    final result=await paymentHttp().getPaymentByID(id);
    if(result!=null){
      _payment=result;
    }else{
      print("Provider - Khong the getPayment");
    }
    _isLoading=false;
    notifyListeners();
  }
}