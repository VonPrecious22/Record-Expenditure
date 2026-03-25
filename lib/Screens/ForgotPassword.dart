import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';

class Forgotpassword extends StatefulWidget {
   const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
 final TextEditingController useremailcontroller = TextEditingController();

  @override
   void dispose(){
    useremailcontroller.dispose();
    super.dispose();
  }


    Future passwordReset() async{
      final email = useremailcontroller.text.trim();
      try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
       ScaffoldMessenger.of(context).showSnackBar(
      
        SnackBar(
          backgroundColor: CustomColor.primaryColor,
        content: AnimatedContainer(
          duration: Duration(
            microseconds: 1
          ), child: Text('Password resest. check your email!!')),));
      
    }
    
  
  on FirebaseAuthException catch (e){
    print(e);
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
  }
  }

    @override
 
  Widget build(BuildContext context) {
   final screenWidth  = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;
  final orientation  = MediaQuery.of(context).orientation;
  final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
      
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Align(
            alignment: Alignment.center,
            child: Text('Enter your Email and we will send you a password reset link',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(height: 19,),
          Container(
          height: 55,
          child: TextFormField(
            
            controller: useremailcontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('Email Address',style: TextStyle(
                color:  const Color(0xFF05406F),
                fontStyle: FontStyle.italic,
              ),),
              suffixIcon: Icon(Icons.email,color:  const Color(0xFF05406F),),
              hintText: 'Enter Email',hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color:  const Color(0xFF05406F)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color:  const Color(0xFF05406F))
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color:  const Color(0xFF05406F))
              ),
              fillColor: Colors.white,
              filled: true
            ),
            
          ),
          ),
          SizedBox(height: 16,),
          CustomButton(text: 'Reset Password', ontap: passwordReset,)
        
          ],
        ),
      ),
    );
  }
}