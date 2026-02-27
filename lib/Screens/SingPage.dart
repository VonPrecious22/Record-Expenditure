import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';
import 'package:recordexpenditure/Screens/ForgotPassword.dart';
import 'package:recordexpenditure/Screens/MenuPage.dart';
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
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  massagebar('Successfully Login', context);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>Menupage()));
    }
    on FirebaseAuthException catch(e){
      massagebar(e.toString(), context);
    }

  }


  bool isvisible = false;
  final TextEditingController useremailcontroller = TextEditingController();
  final TextEditingController userpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
     double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
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
            children: [
              Container(
                child:Column(
                  children: [
                Text('HELLO',style: TextStyle(
              color:  const Color(0xFF05406F),
              fontSize: 50,
              fontWeight: FontWeight.bold,
              ),) ,
              Text('Please enter Login details!!!',style: TextStyle(
                color: Colors.black,
                fontSize: 12
              ),)
                  ],
                )),
              SizedBox(height: 150,),
              Container(
                height: 45,
                width: double.infinity,
               child: TextFormField(
                controller: useremailcontroller,
              keyboardType: TextInputType.emailAddress,
              
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email,color: const Color(0xFF05406F),),
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
              Container(
                height: 45,
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