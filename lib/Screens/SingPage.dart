
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordexpenditure/Screens/BottomNavigationPage.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';
import 'package:recordexpenditure/Screens/ForgotPassword.dart';
import 'package:recordexpenditure/Screens/SignUp.dart';

class Singpage extends StatefulWidget {
  const Singpage({super.key});

  @override
  State<Singpage> createState() => _SingpageState();
}

class _SingpageState extends State<Singpage> {
  void massagebar (String message, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  void handleLogin( BuildContext context) async{
    final email = useremailcontroller.text.trim();
    final password = userpassword.text.trim();
    if(email.isEmpty || password.isEmpty){
      return massagebar('Please fill in the form', context);
    } 
    try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email, 
    password: password
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: CustomColor.primaryColor,
      content: Text('Login Successfully')));
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Bottomnavigationpage()),
  (route) => false);
    }
    on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: CustomColor.primaryColor,
      content: Text(' Unable to Login, Wrong password!!')));
    }

  }


  bool isvisible = false;
  final TextEditingController useremailcontroller = TextEditingController();
  final TextEditingController userpassword = TextEditingController();
  @override
  void dispose (){
    useremailcontroller.dispose();
    userpassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap:() => FocusScope.of(context).unfocus(),
      child: Scaffold(
        
        backgroundColor: Colors.white,
       body: SingleChildScrollView(
        reverse: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
         child: Padding(
          
           padding: const EdgeInsets.only(left: 10, right: 10),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'HELLO\n',style: GoogleFonts.poppins(
                        color:  const Color(0xFF05406F),
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        ),
                        ) ,
                
                        TextSpan(
                        text: 'Please Enter Login Details!!!',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18))
                                ])
                  ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 55,
                width: double.infinity,
               child: TextFormField(
                controller: useremailcontroller,
              keyboardType: TextInputType.emailAddress,
              
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email,color: CustomColor.primaryColor),
                  border: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(8),
                
                    
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF05406F),),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF05406F),),
                    borderRadius: BorderRadius.circular(8)
                  ),
              
                  hintText: 'Enter Email',hintStyle: TextStyle(fontStyle: FontStyle.italic,color: const Color(0xFF05406F),),
                  label: Text('Email Address',style: TextStyle(fontStyle: FontStyle.italic, color:const Color(0xFF05406F), ),)
                ),
                
               ),
              
              ),
              SizedBox(height: 35,),
              SizedBox(
                height: 55,
                child: TextFormField(
                  controller: userpassword,
                  obscureText: isvisible,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: const Color(0xFF05406F),)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: const Color(0xFF05406F),)),
                    prefixIcon: Icon(Icons.lock,color: const Color(0xFF05406F),),
                    suffixIcon: GestureDetector(onTap: () {
                        setState(() {
                        isvisible = !isvisible;
                      });
                    }, 
                    child: Icon(isvisible? Icons.visibility_off: Icons.visibility,color:  const Color(0xFF05406F),),
                    ),
                    
                    hintText: 'Enter Password',hintStyle: TextStyle(
                      fontStyle: FontStyle.italic, color: const Color(0xFF05406F),
                    ) ,
                    label: Text('Password', style: TextStyle(fontStyle: FontStyle.italic, color: const Color(0xFF05406F),),)
                  ),
                ),
              ),
              SizedBox(height: 6,),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Forgotpassword();
                    }));
                  },
                  child: Text('Forgot Password?'))),
              SizedBox(height: 50,),
              CustomButton(text: 'Sign In', ontap: () => handleLogin(context)),
              SizedBox(height: 12,),
              Row(children: [
                Text('Don\'t have an Account?'),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SingUPPage()));
                  },
                  child: Text('Sign Up',style: TextStyle(color: const Color(0xFF05406F)),))
               
              ],)
            ],
           ),
         ),
       ),
      ),
    );
  }
}