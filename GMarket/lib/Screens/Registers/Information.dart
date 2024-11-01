import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Logins/Login.dart';
import 'package:gmarket/Http/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
// void main() {
//   runApp( MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home:
//     Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Information(password: '', email: '',),
//     ),
//   ));
// }

class Information extends StatefulWidget {
  late String password;
  late String email;
  Information({super.key, required this.password, required this.email});

  @override
  State<StatefulWidget> createState() {
    return InfomationState();
  }
}

class InfomationState extends State<Information> {
  final TextEditingController _dateController = TextEditingController();
  UserHTTP user = UserHTTP();
  late String _fName;
  late String _lName;
  late String _phoneNumber;
  late String _address;
  late String _birthDay;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                child: Center(
                    child: SizedBox(
                  height: height * 0.9,
                  width: width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: Image.asset(
                          'assets/image/QMarket-White.jpg',
                          height: height * 0.2,
                          width: width * 0.3,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextField(
                        onChanged: (value) {
                          _fName = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "First Name",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextField(
                        onChanged: (value) {
                          _lName = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "LastName",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextField(
                        onChanged: (value) {
                          _address = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextField(
                        onChanged: (value) {
                          _phoneNumber = value;
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Coiny-Regular-font',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextField(
                        onChanged: (value) {
                          _birthDay = value.toString();
                        },
                        controller: _dateController,
                        decoration: InputDecoration(
                            label: const Text("BirthDay"),
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  SelectDate(context);
                                },
                                icon: const Icon(Icons.calendar_today)),
                            hintText: "Phone Number",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(94, 200, 248, 1),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3.0,
                                    color: Color.fromRGBO(94, 200, 248, 1)))),
                        readOnly: true,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(94, 200, 248, 1)),
                          onPressed: () {
                             PressOnRegister();
                            

                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Coiny-Regular-font'),
                          ))
                    ],
                  ),
                )),
              ),
            ),
            // Text(widget.email),
            // SizedBox(height: 12,),
            // Text(widget.password)
          ],
        ),
      ),
    );
  }

  void PressOnRegister() {
    String Fullname=_fName+" "+_lName;
    if(user.RegisterUser(Fullname, widget.email, widget.password, _phoneNumber,_address)==true){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
    else{
      ShowRegisterDialog(context);
    }
  }

  void ShowRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi đăng ký'),
          content: const Text("Lỗi đăng ký"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  Future<void> SelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        String formatDate = '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
        _dateController.text = formatDate;
      });
    }
  }
}
