class Feedback{
  final String rating;
  final String comments;
  final int order_id;
  final int user_id;
  final int product_id;
  final int feedback_id;

  Feedback({
    required this.rating,
    required this.comments,
    required this.order_id,
    required this.user_id,
    required this.product_id,
    required this.feedback_id
  });
  factory Feedback.fromJson(Map<String,dynamic> json){
    return Feedback(
        rating: json['rating'],
        comments: json['comments'],
        feedback_id: json['feedback_id'],
        order_id: json['order_id'],
        user_id: json['user_id'],
        product_id: json['product_id']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'rating':rating,
      'comments':comments,
      'feedback_id':order_id,
      'order_id':user_id,
      'user_id':product_id,
      'product_id':feedback_id,
    };
  }
}