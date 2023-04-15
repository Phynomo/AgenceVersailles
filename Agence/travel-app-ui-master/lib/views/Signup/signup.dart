import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;


class Signupscreen extends StatelessWidget {
  const Signupscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class Signupscreen extends StatefulWidget {
//   const Signupscreen({Key key}) : super(key: key);

//   @override
//   State<Signupscreen> createState() => _SignupscreenState();
// }

// class _SignupscreenState extends State<Signupscreen> {
//   @override
//   Widget build(BuildContext context) {
//       return Form(   
//       child: Column(  
//         crossAxisAlignment: CrossAxisAlignment.start,  
//         children: <Widget>[  
//           TextFormField(  
//             decoration: const InputDecoration(  
//               icon: const Icon(Icons.person),  
//               hintText: 'Enter your name',  
//               labelText: 'Name',  
//             ),  
//           ),  
//           TextFormField(  
//             decoration: const InputDecoration(  
//               icon: const Icon(Icons.phone),  
//               hintText: 'Enter a phone number',  
//               labelText: 'Phone',  
//             ),  
//           ),  
//           TextFormField(  
//             decoration: const InputDecoration(  
//             icon: const Icon(Icons.calendar_today),  
//             hintText: 'Enter your date of birth',  
//             labelText: 'Dob',  
//             ),  
//            ),  
//           new Container(  
//               padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
//               child: new ElevatedButton(  
//                 child: const Text('Submit'),  
//                   onPressed: null,  
//               )),  
//         ],  
//       ),  
//     );  
//   }
// }