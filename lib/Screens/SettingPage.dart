import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/ProfilePage.dart';
import 'package:recordexpenditure/Screens/WelcomePage.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('Settings',style: TextStyle(color: Colors.black, fontSize: 16),),
      ),
      body: Padding(
        padding: const EdgeInsets.only( top: 12),
       child: Column(
        children: [
           ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Details',style: TextStyle(color: Colors.black),),
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=> Profilepage()));
            },
        
            
            ),

            Divider(color: Colors.black,),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode',style: TextStyle(color: Colors.black),),
             trailing: Switch(
              activeThumbColor:  CustomColor.primaryColor,
              inactiveThumbColor: Colors.grey.shade100,
              value: isOn, onChanged: (value){
                setState(() {
                  isOn = value;
                });
              })
            ),
            Divider(color: Colors.black,),
              ListTile(
            leading: Icon(Icons.language),
            title: Text('Language',style: TextStyle(color: Colors.black),),
            onTap: () {
             
            },
            
            
            ),

            Divider(color: Colors.black,),
              ListTile(
            leading: Icon(Icons.feedback),
            title: Text('FeedBack',style: TextStyle(color: Colors.black),),
            onTap: () {
             
            },
            
            
            ),

            Divider(color: Colors.black,),
              ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out',style: TextStyle(color: Colors.black),),
            onTap: () {
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
                  onPressed: () async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => Welcomepage()),
    (route) => false, 
  );
},
                                 child: Text('Log Out',style: TextStyle(color: Colors.red),),),
              ]);
              
             }
             
             );
            },
          //  trailing: Icon(Icons.logout),
            
            
            ),

            Divider(color: Colors.black,),
        ],
       ),
      ),

    );
  }
}

