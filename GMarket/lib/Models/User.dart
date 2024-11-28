class Users {
  final String fullname;
  final String email;
  final String password;
  final String phonenumber;
  final String address;
  final String role;
  final int ID;
  // final String BirthDay;
  Users(
      {
        required this.fullname,
        required this.email,
        required this.password,
        required this.phonenumber,
        required this.address,
        required this.role,
        required this.ID
        // required this.BirthDay
      });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        fullname: json['fullname'],
        email: json['email'],
        password: json['password'],
        phonenumber: json['phonenumber'],
        address: json['address'],
        role: json['role'],
        ID: json['ID']
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'fullnam':fullname,
      'email':email,
      'password':password,
      'phonenumber':phonenumber,
      'address':address,
      'role':role,
      'ID':ID,
    };
  }
}