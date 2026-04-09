import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';

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

    File? selectdImage;
    final ImagePicker picker = ImagePicker();
    Future<void> pickAnImage(ImageSource source) async {
   try{
    final pickedImage = await picker.pickImage(source: source);
   if(pickedImage != null){
    setState(() {
      selectdImage = File(pickedImage.path);
    });
   }
   }on PlatformException {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: CustomColor.primaryColor,
      content: Text('Failed to upload image')));
   } catch(e){
    print(e);
   }
  }

  Future<void> showOptionToPickAnImage(BuildContext context)async{
    final ImageSource? source = await showModalBottomSheet(
      context: context, 
    
      builder: (context){
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                  
                },
             
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              )
            ],
          ));
      });
           if(source != null){
            pickAnImage(source);
           }
}
 Widget profileTile (String label, IconData icon, String value){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),),
          Container(
           height: 55,
           width: double.infinity,
           decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
           ),
             child: Padding(
               padding: const EdgeInsets.only(left: 10, right: 10),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: CustomColor.primaryColor,),
                  SizedBox(width: 14,),
                  Text(value, style: TextStyle(color: Colors.black),)
                ],
               ),
             ),
           )
        ],
      ),
    );

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
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                    SizedBox(height: 40,),
                    Stack(
              children: [
               ClipOval(
                child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
               
                  color: Colors.white70,
                  shape: BoxShape.circle,
                
                  boxShadow: [
                    BoxShadow(
                     color: CustomColor.primaryColor.withOpacity(0.5),
                     offset: Offset(0, 1),
                     blurRadius: 1,
                     spreadRadius: 1,
                    )
                  ]
                ),
                child: selectdImage != null ? 
                Image.file(selectdImage!,
                fit: BoxFit.cover,)
                : Icon(Icons.person, size: 100,),
              ),
              ),
              
              Positioned(
                right: 1,
                bottom: 1,
                child: IconButton.filled(
                  color: Colors.white,
                focusColor: CustomColor.primaryColor,
                onPressed: (){
                showOptionToPickAnImage(context);
                            }, icon: Icon(Icons.camera_alt)),
              ),
              ],
              
            ),
                 profileTile('Full Name', Icons.person, User?['Name'] ?? "N/A"),                  
                  profileTile('Email Address', Icons.email, User?['Email'] ?? currentUser?.email?? "N/A"),
                  profileTile('Phone Number', Icons.phone, User?['phone'] ?? "N/A"),
                SizedBox(height: 38,),
                 CustomButton(text: 'Save', ontap: (){
                  Navigator.pop(context);
                 })
                           ] );
           }
           else{
           return Text('No data');
           }
       

        }  ,
        
        ),
    );
  }
}

