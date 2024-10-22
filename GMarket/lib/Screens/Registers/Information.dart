

import 'package:flutter/material.dart';
import 'package:gmarket/Screens/Logins/Login.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home:
    Scaffold(
      body: Information(),
    ),
  ));
}

class Information extends StatefulWidget{
  const Information({super.key});

  @override
  State<StatefulWidget> createState() {
    return InfomationState();
  }
}
class InfomationState extends State<Information>{
  final TextEditingController _dateController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height= MediaQuery.of(context).size.height;

    return Material(
     child: Scaffold(
       body:
       Stack(
         children: [
           Center(
             child: Container(
               color: const Color.fromRGBO(255, 255, 255, 1.0),

               child: Center(
                   child: SizedBox(
                     height: height*0.9,
                     width: width*0.9,
                     child:
                     Column(
                       children: [
                         SizedBox(height: height*0.05,),
                         Container(
                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                           child: Image.asset('assets/image/QMarket-White.jpg',
                             height: height*0.2,
                             width: width*0.3,),
                         ),
                         SizedBox(height: height*0.01,),
                         TextField(
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
                                   fontFamily: 'Coiny-Regular-font'
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: const BorderSide(
                                     color: Color.fromRGBO(94 , 200, 248, 1),
                                     width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: const BorderSide(width: 3.0,
                                       color: Color.fromRGBO(94 , 200, 248, 1)))
                           ),
                         ),
                         SizedBox(height: height*0.01,),
                         TextField(
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
                                   fontFamily: 'Coiny-Regular-font'
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: const BorderSide(
                                     color: Color.fromRGBO(94 , 200, 248, 1),
                                     width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: const BorderSide(width: 3.0,
                                       color: Color.fromRGBO(94 , 200, 248, 1)))
                           ),
                         ),
                         SizedBox(height: height*0.01,),
                         TextField(
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
                                   fontFamily: 'Coiny-Regular-font'
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: const BorderSide(
                                     color: Color.fromRGBO(94 , 200, 248, 1),
                                     width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: const BorderSide(width: 3.0,
                                       color: Color.fromRGBO(94 , 200, 248, 1)))
                           ),
                         ),
                         SizedBox(height: height*0.01,),
                         TextField(
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
                                   fontFamily: 'Coiny-Regular-font'
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: const BorderSide(
                                     color:  Color.fromRGBO(94 , 200, 248, 1),
                                     width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: const BorderSide(width: 3.0,
                                       color: Color.fromRGBO(94 , 200, 248, 1))
                               )
                           ),
                         ),
                         SizedBox(height: height*0.01,),
                         TextField(
                           controller: _dateController,
                           decoration: InputDecoration(
                               label: const Text("BirthDay"),
                               labelStyle: const TextStyle(
                                   color: Colors.black,
                                   fontSize: 18,
                                   fontFamily: 'Coiny-Regular-font'
                               ),
                               suffixIcon: IconButton(
                                   onPressed: () => SelectDate(context),
                                   icon: const Icon(Icons.calendar_today)),
                               hintText: "Phone Number",
                               hintStyle: const TextStyle(
                                   color: Colors.black,
                                   fontSize: 18,
                                   fontFamily: 'Coiny-Regular-font'),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: const BorderSide(
                                     color: Color.fromRGBO(94 , 200, 248, 1),
                                     width: 2.0),
                               ),
                               focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: const BorderSide(width: 3.0,
                                       color: Color.fromRGBO(94 , 200, 248, 1)))
                           ),
                           readOnly: true,
                         ),
                         ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: const Color.fromRGBO(94 , 200, 248, 1)
                             ),
                             onPressed: () {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => const Login()
                                   )
                               );
                             },
                             child: const Text("Next",
                               style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 18,
                                   fontFamily: 'Coiny-Regular-font'
                               ),))
                       ],
                     ),
                   )
               ),
             ),
           )
         ],
       ),
     ),
    );
  }
  Future<void> SelectDate(BuildContext context)async {
    final DateTime? picked= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
    if(picked!=null){
      setState(() {
        String formatDate ='${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
        _dateController.text=formatDate;
      });
    }
  }
}