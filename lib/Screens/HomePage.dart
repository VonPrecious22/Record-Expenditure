import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/BottomNavigationPage.dart';
import 'package:recordexpenditure/Screens/WelcomePage.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
   final screenWidth  = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;
  final orientation  = MediaQuery.of(context).orientation;
  final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        
        builder: (context, snapshot) {
        
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);

        }
        if(snapshot.hasError){
          return Center(
            child: Text('Unable to Log in'),
          );
        }
        if(snapshot.hasData){
          return Bottomnavigationpage();
        }
        else{
          return Welcomepage();
        }
        })
    );
  }}




