class PromoCode{
  final String name;
  final String code;
  final String description;
  final String startdate;
  final String enddate;
  final String status;
  final String discounttype;
  final String discountvalue;
  final String minimumordervalue;
  final int promocode_id;

  PromoCode({
    required this.name,
    required this.description,
    required this.status,
    required this.code,
    required this.discounttype,
    required this.discountvalue,
    required this.enddate,
    required this.minimumordervalue,
    required this.startdate,
    required this.promocode_id
  });

  factory PromoCode.fromJson(Map<String,dynamic>json){
    return PromoCode(
      description: json['description'],
      code: json['code'],
      discounttype: json['discounttype'],
      discountvalue: json['discountvalue'],
      enddate: json['enddate'],
      minimumordervalue: json['minimumordervalue'],
      name: json['name'],
      startdate: json['startdate'],
      status: json['status'],
      promocode_id:json['promocode_id']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'description':description,
      'code':code,
      'discounttype':discounttype,
      'discountvalue':discountvalue,
      'enddate':enddate,
      'minimumordervalue':minimumordervalue,
      'name':name,
      'startdate':startdate,
      'status':status,
      'promocode_id': promocode_id
    };
  }
}