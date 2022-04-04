// import 'package:flutter/material.dart';
//
// import '../../repos/variables.dart' show MyColors;
// import 'common_components.dart' show ColorCircle;
//
// class AndroidAddColor extends StatelessWidget {
//   const AndroidAddColor({Key? key}) : super(key: key);
//   static const String routeName = "/addColor";
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: MediaQuery.of(context).viewInsets,
//       padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
//       height: 130.0,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: TextField(
//                   cursorColor: MyColors.primary,
//                   decoration: InputDecoration(
//                     hintText: "Title",
//                     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.primary)),
//                     contentPadding: EdgeInsets.only(bottom: 8.0, top: 10.0),
//                     isDense: true,
//                   ),
//                 ),
//               ),
//               ColorCircle(color: _provider.newColor),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Text("Available Colors", style: Theme.of(context).textTheme.bodyText1),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemBuilder: (_, int index) => ColorCircle(
//                 color: _provider.eventColors[index],
//                 onTap: _provider.changeNewColor,
//               ),
//               itemCount: _provider.eventColors.length,
//               scrollDirection: Axis.horizontal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
