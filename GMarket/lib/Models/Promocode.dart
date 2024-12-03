
class PromoCode{
  final String? name;
  final String? code;
  final String? description;
  final String? startdate;
  final String? enddate;
  final String? status;
  final String? discounttype;
  final int? discountpercentage;
  final int? minimumordervalue;
  final int? ID;

  PromoCode({
    required this.ID,
    required this.name,
    required this.description,
    required this.status,
    required this.code,
    required this.discounttype,
    required this.discountpercentage,
    required this.enddate,
    required this.minimumordervalue,
    required this.startdate,
  });

  factory PromoCode.fromJson(Map<String,dynamic>json){
    return PromoCode(
      ID:json['ID'],
      description: json['description'],
      code: json['code'],
      discounttype: json['discounttype'],
      enddate: json['enddate'],
      // minimumordervalue: double.parse( json['minimumordervalue'].toString()),
      // discountpercentage: double.parse( json['discountpercentage'].toString()),
      minimumordervalue: json['minimumordervalue'],
      discountpercentage: json['discountpercentage'],
      name: json['name'],
      startdate: json['startdate'],
      status: json['status'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'description':description,
      'code':code,
      'discounttype':discounttype,
      'discountvalue':discountpercentage,
      'enddate':enddate,
      'minimumordervalue':minimumordervalue,
      'name':name,
      'startdate':startdate,
      'status':status,
    };
  }
}