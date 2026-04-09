import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';
import 'package:recordexpenditure/Screens/FireBaseServices.dart';

class Profiledetailpage extends StatefulWidget {
  const Profiledetailpage({super.key});

  @override
  State<Profiledetailpage> createState() => _ProfiledetailpageState();
}

class _ProfiledetailpageState extends State<Profiledetailpage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  
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

  Future<void> fillForm(Map<String,dynamic>? data)async {
    nameController.text = data?['Name'] ?? '';
    emailController.text = data?['Email'] ?? currentUser?.email?? '';
    phoneController.text = data?['phone'] ?? '';
  }

  Future<void> showOptionToPickAnImage(BuildContext context)async{
    final ImageSource? source = await showModalBottomSheet(
      context: context, 
      enableDrag: true,
      showDragHandle: true,
      builder: (context){
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo),
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
 Widget profileTile (String label, IconData icon,TextEditingController controller,{TextInputType keyboardType = TextInputType.text}){
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
         SizedBox(height: 4,),
         TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: CustomColor.primaryColor,),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade100),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.primaryColor, width:2 )
            )
          ),
         )
        ],
      ),
    );

  }

  Future<void> SaveProfile() async{
    final firebaseservice = Firebaseservices();
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final number = phoneController.text.trim();
    try{
      await firebaseservice.UpdateProfile(
        Name: name,
         email:  email,
         number: number);
    }catch(e){
      throw Exception('Failled to update the profile details!!$e');
    }
  }
   @override
   void dispose(){
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
              Map<String, dynamic> ? 
              User = snapshot.data!.data();
              fillForm(User);
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
                SizedBox(height: 55,
              ),
               profileTile('Full Name',   Icons.person, nameController, keyboardType: TextInputType.text),
               profileTile('Email Address',   Icons.email, emailController, keyboardType: TextInputType.emailAddress),
               profileTile('Phone Number',Icons.phone, phoneController, keyboardType: TextInputType.number),
                SizedBox(height: 38,),
                 CustomButton(text: 'Save', ontap: () async{
                  try{
                    await SaveProfile();
                    if(mounted){
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar
                      (
                        backgroundColor: CustomColor.primaryColor,
                        content: Text('You\'ve updated your  profile details successfully!!')));
                    }
                  }catch(e){
                   if(mounted){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: CustomColor.primaryColor,
                      content: Text('Failled to updated profile details!!')));
                   } 
                  }
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

  // profileTile('Email Address', Icons.email, User?['Email'] ?? currentUser?.email?? "N/A"),
  //                 profileTile('Phone Number', Icons.phone, User?['phone'] ?? "N/A"),