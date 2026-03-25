import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';

class Changepassword extends StatefulWidget {
  
  Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final TextEditingController oldpasswordController = TextEditingController();
 final TextEditingController newpasswordController = TextEditingController();
 final TextEditingController emailcontroller = TextEditingController();
  Future<void> changePassword(String email, String oldpassword, String newpassowrd) async{
  
    try{
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
         password: oldpassword
         );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newpassowrd);
        Navigator.pop(context);
        oldpasswordController.clear();
        newpasswordController.clear();
        emailcontroller.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          
          SnackBar(
            backgroundColor: CustomColor.primaryColor,
            content: Text(
          'Password Changed Successfully'
        )));
    } catch(e){
      print('Error$e');
    }
  }
  bool isvissible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: CustomColor.primaryColor,
       leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, size: 30, color: Colors.white,)),
      title: Text('Change Password',style: TextStyle(color: Colors.white,fontSize: 18),),),
     backgroundColor: Colors.white,
     body: Padding(
       padding: const EdgeInsets.only(left: 10, right: 10),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         RichText(
          textAlign: TextAlign.center,
          text: 
         TextSpan(
          children: [
              TextSpan(text: "HELLO\n",style: GoogleFonts.poppins(
              color: CustomColor.primaryColor,
              fontSize: 70,
              fontWeight: FontWeight.bold
              )),
               TextSpan(text: 'Filled The Form Below And Change Your Password!!',style: TextStyle(color: Colors.black, fontSize: 18))
             ]
             
         )),
         SizedBox(height: 24,),
           SizedBox(
            height: 55,
            child: TextFormField(
              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration:InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomColor.primaryColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomColor.primaryColor)
                  ),
                  hintText: 'Enter Email',labelStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  labelText: 'Email Address',hintStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  
              
            ),
          )
       ),
       SizedBox(height:24 ,),
          SizedBox(
            height: 55,
            child: TextFormField(
              controller: oldpasswordController,
              obscureText: isvissible,
              keyboardType: TextInputType.text,
              decoration:InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomColor.primaryColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomColor.primaryColor)
                  ),
                  hintText: 'Enter Old Password',labelStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  labelText: 'Old Password',hintStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isvissible != isvissible;
                      });
                    },
                    child: Icon(isvissible? Icons.visibility_off: Icons.visibility,color:  const Color(0xFF05406F),),
              ),
              
            ),
          )
       ),
       SizedBox(height: 30,),
        SizedBox(
            height: 55,
            child: TextFormField(
              controller: newpasswordController,
              obscureText: isvissible,
              keyboardType: TextInputType.text,
              decoration:InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomColor.primaryColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: CustomColor.primaryColor)
                  ),
                  hintText: 'Enter New Password',hintStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  labelText: ' New Password',labelStyle: TextStyle(
                    fontStyle: FontStyle.italic
                  ),
                  
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isvissible =! isvissible;
                      });
                    },
                    child: Icon(isvissible? Icons.visibility_off: Icons.visibility,color:  const Color(0xFF05406F),),
              ),
              
            ),
          )
       ),
       SizedBox(height: 50,),
       CustomButton(text: 'Change Passowrd', ontap: (){
       changePassword(emailcontroller.text.trim(), oldpasswordController.text.trim(), newpasswordController.text.trim());
       })
       ]

       ),
     ),
    );
  }
}