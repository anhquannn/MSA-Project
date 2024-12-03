import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/Product.dart';
import 'package:gmarket/Models/Product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product?> _products = [];
  List<Product> _productSearch = [];
  Product? _product;
  bool? _isSucess=false;
  List<Product> _productSort = [];
  bool _isLoading = false;

  bool? get isSucess =>_isSucess;
  List<Product?> get products => _products;
  List<Product?> get productSort => _productSort;
  List<Product> get productSearch => _productSearch;
  Product? get product => _product;
  bool get isLoading => _isLoading;

  Future getAllProduct() async {
    _products =[];
    _isLoading = true;
    notifyListeners();
    try {
      List<Product> p = await productHttp().getAllProduct();
      _products = p;
        } catch (e) {
      Exception('Lỗi provider $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future createProduct(Product p) async {
    final result = await productHttp().createProduct(p);
    if (result == true) {
      getAllProduct();
      _isSucess=true;
    } else {
      print("Provider thêm thất bại");
    }
  }

  Future updateProduct(Product product) async {
      if(await productHttp().UpdateProduct(product)==true){
        print("Http - Provider update thanh cong");

    } else {
      print("Provider update thất bại");
    }
    notifyListeners();
  }

  Future deleteProduct(int id) async {
    final result = await productHttp().deleteProduct(id);
    if (result == true) {
    } else {
      print("Provider delete thất bại");
    }
    notifyListeners();
  }

  Future getProductByName(String name) async {
    _productSearch = [];
    _isLoading = true;
    notifyListeners();

    final result = await productHttp().searchProduct(name);
    if (result != null) {
      _productSearch = result;
    } else {
      _productSearch = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future getProductById(int id) async {
    _product=null;
    _isLoading=true;
    notifyListeners();
    final result=await productHttp().getProductById(id);
    if(result!=null){
      _product=result;
      print("Provider - getProductById thanh cong");
      notifyListeners();
    }else{
      print("Provider - getProductById that bai");
    }
    _isLoading=false;
    notifyListeners();
  }

  void clearProductSearch(){
    this._productSearch=[];
  }

  void clearProducts(){
    this._products=[];
    notifyListeners();
  }

  Future addProduct(int id) async{
    _isLoading=false;
    notifyListeners();
    try{
      final product=await productHttp().getProductById(id);
      if(product!=null){
        _products.add(product);
        notifyListeners();
        print("Provider - Add product thanh cong ${product.ID}");
      }
    }catch(e){
      throw Exception("Provider - Add product khong thanh cong ");
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }
  }

  Future SortProducts(int size, int minPrice, int maxPrice, int categoryId, int page, int pageSize) async{
    _isLoading=false;
    notifyListeners();

    final result=await productHttp().SortProducts(size, minPrice, maxPrice, categoryId, page, pageSize);
    if(result!=null){
      _productSort=result;
      _products+=_productSort;
      print("Provider - fillProduct thanh cong ${_products[0]!.name}");
    }
    _isLoading=true;
    notifyListeners();
  }

  Future filterProducts( int page) async{
    _isLoading=false;
    notifyListeners();
    final result=await productHttp().filterProducts(page);
    if(result!=null){
      _productSort=result;
      _products+=_productSort;
      print("Provider - fillProduct thanh cong length ${_products.length}");
      notifyListeners();
    }
    else{
      notifyListeners();
    }
    _isLoading=true;
    notifyListeners();
  }

}
