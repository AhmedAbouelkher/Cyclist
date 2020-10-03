// import 'package:cyclist/models/responses/show_cat_products.dart';
// import 'package:cyclist/utils/locales/app_translations.dart';
// import 'package:flutter/material.dart';

//! DESAPELED
// class SpcItem extends StatefulWidget {
//   final Specifications spc;
//   final Function onChanged;
//   SpcItem({this.spc, this.onChanged});
//   @override
//   _SpcItemState createState() => _SpcItemState();
// }

// class _SpcItemState extends State<SpcItem> {
//   bool val = false;
//   @override
//   Widget build(BuildContext context) {
//     final AppTranslations trs = AppTranslations.of(context);
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           val = !val;
//           widget.onChanged(widget.spc);
//         });
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             child: Row(
//               children: <Widget>[
//                 Checkbox(
//                   value: val,
//                   onChanged: (value) {
//                     setState(() {
//                       val = value;
//                       widget.onChanged(widget.spc);
//                     });
//                   },
//                 ),
//                 Text(
//                   trs.locale.languageCode == 'ar' ? widget.spc.nameAr : widget.spc.nameEn,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.black45,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Text(
//             widget.spc.price.toString(),
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.black45,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
