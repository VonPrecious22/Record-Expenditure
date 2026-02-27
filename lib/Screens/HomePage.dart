import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';
import 'package:recordexpenditure/Screens/SingPage.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 80, right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Singpage()));
                  },
                  child: Container(
                    child: Text('Skip'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 90,),
            Container(child: Text('WELCOME',style: TextStyle(
              color:  const Color(0xFF05406F),
              fontSize: 50,
              fontWeight: FontWeight.bold
            ),),),
              RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
        text: 'Welcome to smartExpenses\n',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
              ),
              TextSpan(
        text: 'Your Simple and Powerful tool for managing everyday expenses.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black
        
        ),
              ),
            ],
          ),
        ),
        SizedBox(height: 45,),
        CustomButton(text: 'Welcome', ontap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Singpage()));
        })
      
          ],
        ),
      ),
    );
  }
}

