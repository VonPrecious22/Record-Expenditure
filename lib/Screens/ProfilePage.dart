import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recordexpenditure/Screens/ChangePassword.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/ProfileDetailPage.dart';
import 'package:recordexpenditure/Screens/WelcomePage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}
class _ProfilepageState extends State<Profilepage> {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
 
  
 Future<void> pickAnImage(ImageSource source) async {
   try{
    final pickedImage = await picker.pickImage(source: source);
   if(pickedImage != null){
    setState(() {
      selectedImage = File(pickedImage.path);
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
  Future<void> showOptionToPickAnImage(BuildContext context) async{
   final  ImageSource? source = await showModalBottomSheet<ImageSource>(
    backgroundColor: Colors.white,
      context: context,
      enableDrag: true,
      showDragHandle: true,
       builder: (context){
        return SafeArea(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camara'),
              onTap: () {
                Navigator.pop(context,ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Gallary'),
              onTap: () {
                Navigator.pop(context, ImageSource.gallery);
              },
            )
          ],
        ));
       });
       if(source != null){
        await pickAnImage(source);
       }
        }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       
        title: Text('Profile',style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: CustomColor.primaryColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, size: 18, color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                child: selectedImage != null ? 
                Image.file(selectedImage!,
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
            
            SizedBox(height: 14,),

            SizedBox(height: 12,),
            CustomProfile(icon: Icon(Icons.person), text: 'Profile Details', ontap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Profiledetailpage()));
            },),
            SizedBox(height: 12,),
            CustomProfile(icon: Icon(Icons.lock), text: 'Change Password', ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Changepassword()));
            }),
             SizedBox(height: 12,),
            CustomProfile(icon: Icon(Icons.logout), text: 'Log Out', ontap: (){
             showDialog(
              
              barrierDismissible: false,
              context: context, builder: (context){
             return AlertDialog(
              
              
              title: Text('Log Out',style: TextStyle(color: Colors.black, fontSize: 16,),),
              content: Text('Are you sure you want to Log Out?',style: TextStyle(color: Colors.black, fontSize: 16,),),
              actions: [
                 TextButton(onPressed: () {
                  Navigator.pop(context);
                  
                },
                child: Text('Cancel',style: TextStyle(color: Colors.black),),),
                 TextButton(
                 style:  FilledButton.styleFrom(
                    
                    
                  ),
                  onPressed: () {
                  FirebaseAuth.instance.signOut();
                  
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Welcomepage()), (route)=> false, );
                                 },
                                 child: Text('Log Out',style: TextStyle(color: Colors.red),),),
              ]);
              
             }
             
             );
            
  })
          ]
        ),
      ),
    );
  }
}

class CustomProfile extends StatelessWidget {
  final Widget icon;
  final String text; 
   final void Function() ontap;
  const CustomProfile({super.key, required this.icon, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
         // border: Border.all(color: CustomColor.primaryColor),
          boxShadow: [
            BoxShadow(
              color:CustomColor.primaryColor.withOpacity(0.3),
              offset: Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 1
            )
          ]
        ),
       child: ListTile(
       title: Text(text, style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        
       ),),
       leading: icon,
       ),
      ),
    );
  }
}


