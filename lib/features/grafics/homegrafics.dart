// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List? get chartData => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(15),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.teal,
//                   style: BorderStyle.solid,
//                   width: 2,
//                 ),
//                 color: Colors.teal[100],
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Line Chart',
//                     style: TextStyle(
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   MyLineChart(chartData),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }