import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';

class Transactionsdetatils extends StatelessWidget {
  final String Note;
  final String amount;
  final DateTime date;
  final String type; 
  final String Category;
  Transactionsdetatils( {super.key, required this.Note, required this.amount, required this.date, required this.type, required this.Category});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: ListView(
          children: [
            Text('Type',style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),),
            Container(
              color: Colors.grey.shade100,
              child: ListTile(
                
                title: Text(type,style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
            SizedBox(height: 14,),
            Text('Category',style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),),
            Container(
              color: Colors.grey.shade100,
              child: ListTile(
                
                title: Text(Category,style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
             SizedBox(height: 14,),
            Text('Note',style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),),
            Container(
              color: Colors.grey.shade100,
              child: ListTile(
                
                title: Text(Note,style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
             SizedBox(height: 14,),
            Text('Amount',style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),),
            Container(
              color: Colors.grey.shade100,
              child: ListTile(
                
                title: Text('${amount.toString()} FCFA',style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
             SizedBox(height: 14,),
            Text('Date',style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),),
            Container(
              color: Colors.grey.shade100,
              child: ListTile(
                
                title: Text(date.toIso8601String().split('T').first,style: TextStyle(color: Colors.black, fontSize: 16),),
              ),
            ),
            SizedBox(height: 70,),
            CustomButton(text: 'Save', ontap: (){
              Navigator.pop(context);
            })
            
          ],
          
        ),
      ),
   
  );}
}