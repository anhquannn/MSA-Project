class Manufacturer{
  final String name;
  final String address;
  final String contact;
  final int ID;

  Manufacturer({
    required this.name,
    required this.address,
    required this.contact,
    required this.ID
  });
  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
        name: json['name'],
        address: json['address'],
        contact: json['contact'],
        ID: json['ID']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'address':address,
      'contact':contact,
      'manufacturer_id':ID,
    };
  }
}
