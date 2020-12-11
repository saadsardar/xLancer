// import 'package:flutter/material.dart';
// import 'package:xlancer/Widgets/tag_screen.dart';
// //import 'package:project_app/screens/tag_screen.dart';

// //import 'package:project_app/model/project.dart';
// class PostJob extends StatefulWidget {
//       static const routeName = '/uploadproject-screen';
//   @override
//   _PostJobState createState() => _PostJobState();
// }

// class _PostJobState extends State<PostJob> {


//   var _experienceLevel = [
//     'entry level',
//     'intermediate level',
//     'hard level',
//   ];
//   String _pName;
//   double _pBudget;
//   String _pDeadline;
//   String _pDescription;

//   final projName = TextEditingController();
//   final projBudget = TextEditingController();
//   final projDeadline = TextEditingController();
//   final projDescription = TextEditingController();

//   String _currentItemSelected;
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     projName.dispose();
//     projBudget.dispose();
//     projDeadline.dispose();
//     projDescription.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('post job'),
//         centerTitle: true,
//         elevation: 10,
//       ),
//       body: ListView(
//         children: [
//           Column(
//             //mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 25,
//                   right: 20,
//                   top: 50,
//                   bottom: 10,
//                 ),
//                 child: Text(
//                   'Enter the name of your job post',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//               ),
//               Card(
//                 //margin: EdgeInsets.all(),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: TextField(
                    
//                     controller: projName,
                    
//                     decoration: InputDecoration(
//                       hintText: 'eg: carpool app',
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 25,
//                   right: 20,
//                   top: 50,
//                   bottom: 10,
//                 ),
//                 child: Text(
//                   'Enter the budget of your job post',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//               ),
//               Card(
//                 //margin: EdgeInsets.all(),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: TextField(
//                     controller: projBudget,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: 'price',
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 25,
//                   right: 20,
//                   top: 50,
//                   bottom: 10,
//                 ),
//                 child: Text(
//                   'Enter the deadline of your job post',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//               ),
//               Card(
//                 //margin: EdgeInsets.all(),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: TextField(
//                     controller: projDeadline,
//                     decoration: InputDecoration(
//                       hintText: 'eg: closes in 2 days',
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 25,
//                   right: 20,
//                   top: 50,
//                   bottom: 10,
//                 ),
//                 child: Text(
//                   'Enter the description of your job post',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//               ),
//               Card(
//                 //margin: EdgeInsets.all(),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: TextField(
//                     controller: projDescription,
//                     decoration: InputDecoration(
//                       helperText: 'minimum 50 word',
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 25,
//                   right: 20,
//                   top: 50,
//                   bottom: 10,
//                 ),
//                 child: Text(
//                   'Enter the skilld that is required for your job post',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//               ),
//               //TagScreen(),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 25,
//                   right: 20,
//                   top: 50,
//                   bottom: 10,
//                 ),
//                 child: Text(
//                   'Enter the experience level of your job post',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: DropdownButton<String>(
//                   icon: Icon(Icons.arrow_drop_down),
//                   iconSize: 36,
//                   elevation: 8,
//                   style: TextStyle(color: Colors.black),
//                   items: _experienceLevel.map((String dropDownStringItem) {
//                     return DropdownMenuItem<String>(
//                       value: dropDownStringItem,
//                       child: Text(
//                         dropDownStringItem,
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                   hint: Text(
//                     'Choose from below',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                     ),
//                   ),
//                   onChanged: (String newValueSelected) {
//                     setState(() {
//                       _currentItemSelected = newValueSelected;
//                     });
//                   },
//                   value: _currentItemSelected,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: RaisedButton(
//                   color: Theme.of(context).primaryColor,
//                   child: Text(
//                     'submit project',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _pName = projName.text;
//                       _pBudget = double.parse(projBudget.text);
//                       _pDeadline = projDeadline.text;
//                       _pDescription = projDescription.text;
//                     });
//                     print(_pName);
//                     print(_pBudget);
//                     print(_pDeadline);
//                     print(_pDescription);
//                   },
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
