
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final void Function() ontap;
  const CustomButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;
  final orientation  = MediaQuery.of(context).orientation;
  final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        height: screenHeight*0.06,
        width: double.infinity,
        child: ElevatedButton(
           style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF05406F),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
           ),
          onPressed: ontap, child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
      ),
    );

  }
}


// class CustomExpenseRecord extends StatelessWidget {
//   final String Note;
//   final String amount;
//   final DateTime date;
//  // final String type;
// final void Function() ontap;
//   const CustomExpenseRecord({
//     super.key,
//     required this.Note,
//     required this.amount,
//     required this.date,
//     required this.ontap, 
//     //required this.type,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//     onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>Transactionsdetatils(
//         Note: Note, 
//         amount: amount, 
//         date: date,
//         type: type,
//         Category: Category,
//         )));
//     },
//       child: Card(
//         color: Colors.white,
//         elevation: 2,
//         margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ListTile(
          
//           leading: CircleAvatar(
//             radius: 25,
//             backgroundColor: Colors.white,
//             child:Icon(
//               Icons.book,
//               color: Colors.red,
//             ),
//           ),
//           title: Text(
//             Note,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           subtitle: Text(
//             "${date}",
//             style: const TextStyle(fontSize: 13),
//           ),
//           trailing: Text(
//             "- \$${amount}",
//             style: TextStyle(
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


