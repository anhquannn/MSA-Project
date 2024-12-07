import 'package:flutter/cupertino.dart';
import 'package:gmarket/Http/FeedBack.dart';
import 'package:gmarket/Models/FeedBack.dart';

class FeedBack_Provider extends ChangeNotifier{
  List<FeedBack>? _feedbacks=[];
  bool isLoading=false;
  FeedBack? _feedback;
  bool _isGet=false;

  bool get isget=>_isGet;
  List<FeedBack>? get feedbacks=>_feedbacks;
  bool get loading =>isLoading;
  FeedBack? get feedback=>_feedback;

  Future createFeedback(FeedBack fb)async{
    isLoading=true;
    notifyListeners();
    try{
      final result = await feedbackHttp().createFeedback(fb);
      if(result==true){
        print("tao FeedBack thanh cong");
      }
    }catch(e){
      print("Khong the tao FeedBack");
    } finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future getFeedbackById(int id)async{
    _feedback=null;
    isLoading=true;
    notifyListeners();
    try{
      final result = await feedbackHttp().getFeedbackById(id);
      if(result!=null){
        _feedback=result;
      }
    }catch(e){
      print("Khong the get FeedBack");
    } finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future updateFeedback(FeedBack fb)async{
    isLoading=true;
    notifyListeners();
    try{
      final result = await feedbackHttp().updateFeedback(fb);
      if(result==true){
        print("update FeedBack thanh cong");
      }
    }catch(e){
      print("Khong the update FeedBack");
    } finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future deleteFeedback(int id)async{
    isLoading=true;
    notifyListeners();
    try{
      final result = await feedbackHttp().deleteFeedback(id);
      if(result==true){
        print("xoa FeedBack thanh cong");
      }
    }catch(e){
      print("Khong the xoa FeedBack");
    } finally{
      isLoading=false;
      notifyListeners();
    }
  }

  Future getAllFeedbacksByProductID(int id)async{
    _feedbacks=[];
    isLoading=true;
    notifyListeners();
    try{
      final result = await feedbackHttp().getAllFeedbacksByProductID(id);
      if(result!=null){
        _feedbacks=result;
        _isGet=true;
      }
    }catch(e){

      print("Provider - Khong the getAllFeedbacksByProductID");
    } finally{
      isLoading=false;
      notifyListeners();
    }
  }

}