import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/User.dart';
import 'package:gmarket/Models/User.dart';

class User_Provider extends ChangeNotifier{
  Users? _user;
  bool _isLoading=false;
  final List<Users> _difusers=[];
  String _name="";
  String _address="";
  String _phoneNumber="";
  Users? _usersearch;
  List<Users>? _listuser;
  String? _issucesss;

  String? get deleteIsSuccess=>_issucesss;
  List<Users>? get listUser=>_listuser;
  String get name=>_name;
  String get address=>_address;
  String get phoneNumber=>_phoneNumber;
  List<Users> get difuser=>_difusers;
  Users? get user=>_user;
  Users? get usersearch=>_usersearch;
  bool get isLoading=>_isLoading;

  Future loginWithGoogle(String googleToken) async{
    _isLoading=true;
    notifyListeners();
    try{
      final result=await userHTTP().LoginWithGoogle(googleToken);
      if(result!=null){
        _user=result;
      }
    }catch(e){
      throw Exception("Khong the loginWithGoogle $e");
    }
    _isLoading=false;
    notifyListeners();
  }

  Future updateUserInfo(String FullName ,String PhoneNumber, String Address) async {
    _isLoading=true;
    notifyListeners();
    try{
      final result=await userHTTP().UpdateUserInfo(FullName, _user!.password, PhoneNumber, _user!.email, Address,_user!.ID);
      if(result==true){
        print("Provider updateUserInfo thanh cong");
      }
    }catch(e){
      throw Exception("Khong the updateUserInfo $e");
    }
    _isLoading=false;
    notifyListeners();
  }

  Future getUserById(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().GetUserById(userId);
      _difusers.add(result!);
      print("Provider - getUserById thanh cong, name: ${_difusers[0].fullname}");
        } catch (e) {
      throw Exception("Provider - Khong the getUserById $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future getInfoUserById(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().GetUserById(userId);
      print("dfasdfasdf${result!.fullname}");
      _user=result;
        } catch (e) {
      throw Exception("Provider - Khong the getUserById $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future verifyOTP(String otpCode) async {
    _user=null;
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().verifyOTP(otpCode);
      if (result !=null) {
        print('verifyOTP ${result.fullname}');
        _user=result;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Khong the verifyOTP $e");
    }

  }

  Future changePassword(String currenrPassword, String newPassword)async{
    _isLoading=true;
    notifyListeners();
    final user=await userHTTP().UpdateUserPassword(newPassword, currenrPassword, _user!.ID);
    if(user!=null){
      this._user=user;
      _isLoading=false;
      notifyListeners();
    }
  }

  Future updateUserPassword(String password) async{
    _isLoading=true;
    notifyListeners();
    if(await userHTTP().UpdateUserInfo(_user!.fullname, password, _user!.phonenumber, _user!.email, _user!.address, _user!.ID)==true){
      _isLoading=false;
      notifyListeners();
    }
  }

  Future searchUser(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().GetUserById(userId);
      print("dfasdfasdf${result!.fullname}");
      _usersearch=result;
        } catch (e) {
      throw Exception("Provider - Khong the getUserById $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future deleteUser(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().DeleteUser(userId);
      if(result==true){
        print("Provider - etUserById thanh cong ");
        _issucesss="Xóa thành công";
      }else{
        _issucesss="Xóa không thành công";
      }

        } catch (e) {
      _issucesss="Xóa không thành công";
      throw Exception("Provider - Khong the getUserById $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future GetUserByNumberPhone(String numberPhone) async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().GetUserByNumberPhone(numberPhone);
      _usersearch=result;
        } catch (e) {
      throw Exception("Provider - Khong the GetUserByNumberPhone $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future getAllUsers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await userHTTP().getAllUser();
      if(result!=null) {
        _listuser=result;
      }
    } catch (e) {
      throw Exception("Provider - Khong the getAllUsers $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  void updateAddress(String name, String address, String phoneNumber){
    this._name=name;
    this._address=address;
    this._phoneNumber=phoneNumber;
    notifyListeners();
  }

  void clearUser(){
    this._user=null;
    _isLoading=true;
    notifyListeners();
  }
}
