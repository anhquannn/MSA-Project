class FeedBack{
  final int rating;
  final String comments;
  final int user_id;
  final int product_id;
  final int ID;

  FeedBack({
    required this.rating,
    required this.comments,
    required this.user_id,
    required this.product_id,
    required this.ID
  });
  factory FeedBack.fromJson(Map<String,dynamic> json){
    return FeedBack(
        rating: json['rating'],
        comments: json['comments'],
        ID: json['ID'],
        user_id: json['user_id'],
        product_id: json['product_id']
    );
  }
}