import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recordexpenditure/Screens/BottomNavigationPage.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';
import 'package:recordexpenditure/Screens/SingPage.dart';

class SingUPPage extends StatefulWidget {
  const SingUPPage({super.key});

  @override
  State<SingUPPage> createState() => _SingUPPageState();
}

class _SingUPPageState extends State<SingUPPage> {
 void handleSignUp(BuildContext context) async {
  final email = useremailcontroller.text.trim();
  final name = usernamecontroller.text.trim();
  final password = userpassword.text.trim();
  final phone = userphonecontroller.text.trim();
  

  if (email.isEmpty || name.isEmpty || password.isEmpty || phone.isEmpty) {
    showSnackBar(context, "Please fill the form");
    return;
  }

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    showSnackBar(
      
      context, "Account created successfully!",);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottomnavigationpage()));
  } 
  on FirebaseAuthException catch (e) {
    showSnackBar(context, e.message ?? "Signup failed");
  }
   catch (e) {
    showSnackBar(context, "Something went wrong");
  }
}
void showSnackBar(
  BuildContext context,
  String Error,
){
  ScaffoldMessenger.of(context).showSnackBar(
    
    SnackBar(content: Text(Error)));
}
  
  bool isvisible = false;

  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController useremailcontroller = TextEditingController();
  final TextEditingController userphonecontroller = TextEditingController();
  final TextEditingController userpassword = TextEditingController();
  @override
  void dispose () {
    usernamecontroller.dispose();
    useremailcontroller.dispose();
    userphonecontroller.dispose();
    userpassword.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color:  const Color(0xFF05406F),)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(),
                SizedBox(height: 60,),
                RichText(
                  textAlign: TextAlign.center,
                   text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'HELLO\n',style: GoogleFonts.poppins(
                          color: CustomColor.primaryColor,
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      TextSpan(
                        text: 'Please Enter Your Sign Up Details Below!!',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        )
                      )
                    ]
                   ),),
                   SizedBox(height: 16,),
                SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: usernamecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      hintText: 'Name',hintStyle: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),
                      label: Text('Name',style: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),),
                      
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.person,color:  const Color(0xFF05406F),)
                    ),
                    
                  ),
                ),
                SizedBox(height: 35,),
                 SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: TextField(
                    controller: useremailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      hintText: 'Enter Email',hintStyle: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),
                      label: Text('Email Address',style: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.email,color:  const Color(0xFF05406F),)
                    ),
                    
                  ),
                ),
                SizedBox(height: 35,),
                 SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: TextField(
                    controller: userphonecontroller,
                    keyboardType:TextInputType.number,
                    decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      hintText: 'Enter Phone Number',hintStyle: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),
                      label: Text('Phone Number',style: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.call,color:  const Color(0xFF05406F),)
                    ),
                    
                  ),
                ),
                SizedBox(height: 35,),
                 SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: TextField(
                    controller: userpassword,
                    obscureText: isvisible,
                    keyboardType:TextInputType.text,
                    decoration: InputDecoration(
                      
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color:  const Color(0xFF05406F),)
                      ),
                      hintText: 'Enter Password',hintStyle: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),
                      label: Text('Password',style: TextStyle(
                         fontStyle: FontStyle.italic,
                         color:  const Color(0xFF05406F),
                      ),),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.lock,color:  const Color(0xFF05406F),),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isvisible = !isvisible;
                        });
                      }, icon: Icon(isvisible? Icons.visibility_off: Icons.visibility,color:  const Color(0xFF05406F),),)
                    ),
                    
                  ),
                ),
                SizedBox(height: 70,),
                CustomButton(text: 'Sign Up', ontap:()=> handleSignUp(context)),
                SizedBox(height: 12,),
                Row(children: [
                  Text('Already have an Account?'),
                  SizedBox(width: 6,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Singpage()));
                    },
                    child: Text('Sign In',style: TextStyle(color:  const Color(0xFF05406F),),))
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}