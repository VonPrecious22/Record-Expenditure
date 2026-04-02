import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/Color.dart';

class Profiledetailpage extends StatefulWidget {
  const Profiledetailpage({super.key});

  @override
  State<Profiledetailpage> createState() => _ProfiledetailpageState();
}

class _ProfiledetailpageState extends State<Profiledetailpage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
//
Future <DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  return await FirebaseFirestore.instance
              .collection("User")
              .doc(uid)
              .get();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, size: 18, color: Colors.white,)),
        backgroundColor: CustomColor.primaryColor,
        title: Text('Profile details',style: TextStyle(
          color: Colors.white, fontSize: 18
        ),),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot <Map<String, dynamic >>> (
        future: getUserDetails(),
        builder:(context, snapshot){
          // loading
           if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(color: CustomColor.primaryColor,),
            );
           }
           //error
           else if( snapshot.hasError ){
            return Text('Error ${snapshot.error}');
           }
              //received data
           else if(snapshot.hasData){
              Map<String, dynamic> ? User = snapshot.data!.data();
              return Column(
                children: [
                 profileTile('Name', Icons.person, User?['Name'] ?? "N/A"),
                  SizedBox(height: 24,),
                  profileTile('Email', Icons.email, User?['Email'] ?? currentUser?.email?? "N/A"),
                  SizedBox(height: 24,),
                  profileTile('Phone Number', Icons.phone, User?['phone'] ?? "N/A")
                
             ] );
           }
           else{
           return Text('No data');
           }
       

        }  ,
        
        ),
    );
  }
   Widget profileTile (String label, IconData icon, String value){
   return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(icon, color: CustomColor.primaryColor,),
      SizedBox(width: 8,),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Text(label, style: TextStyle(
        color: Colors.black,
      ),),
      SizedBox(width: 8,),
      Text(value, style: TextStyle(color: Colors.black),)
        ],
      )
    ],
   );
   }
}

