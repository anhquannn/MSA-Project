

class Category{
  final String name;
  final String description;
  final int ID;

  Category({
    required this.name,
    required this.description,
    required this.ID
  });
  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
        name: json['name'],
        description: json['description'],
        ID: json['ID']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name':name,
      'description':description,
      'ID':ID,
    };
  }

}