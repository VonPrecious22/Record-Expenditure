import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/MenuPage.dart';
import 'package:recordexpenditure/Screens/SettingPage.dart';

class Bottomnavigationpage extends StatefulWidget {
  const Bottomnavigationpage({super.key});

  @override
  State<Bottomnavigationpage> createState() => _BottomnavigationpageState();
}
 
class _BottomnavigationpageState extends State<Bottomnavigationpage> {
  int currentIndex = 0;
 final List<Widget> pages =[
  Menupage(),
  Settingpage()
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: Colors.white,
        elevation: 2,
        selectedItemColor: Color(0xFF05406F),
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (value) => setState(() {
          currentIndex = value;
        
        }),
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ]),
    );
  }
}