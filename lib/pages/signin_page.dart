import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signup_page.dart';
import 'package:flutter_instaclone/servise/auth_servise.dart';
import 'package:flutter_instaclone/servise/prefs_servise.dart';
import 'package:flutter_instaclone/servise/utilis_servise.dart';
import 'hom_page.dart';
class SignInPage extends StatefulWidget {
  static final String id="siginIn";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading=false;
  var emailcontroler=TextEditingController();
  var passwordcontroler=TextEditingController();

  _doSignIn() {
    String email = emailcontroler.text.toString().trim();
    String password = passwordcontroler.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(context, email, password).then((value) => {
      _getFirebaseUser(value),
    });
  }

  _getFirebaseUser(Map<String, FirebaseUser> map) async {
    setState(() {
      isLoading = false;
    });
    FirebaseUser? firebaseUser;
    if (!map.containsKey("SUCCES")) {
      if (map.containsKey("ERROR"))
        Utils.fireToast("Check your email or password");
      return;
    }
     firebaseUser =map["SUCCES"];
      if(firebaseUser==null) return;
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context,HomPage.id);
    }


  _callSiginUpPage(){
    Navigator.pushReplacementNamed(context,SignUpPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.all(20),
          height:MediaQuery.of(context).size.height,
          decoration:const BoxDecoration(
            gradient:LinearGradient(
              begin:Alignment.topCenter,
              end:Alignment.bottomCenter,
              colors:[
                Color.fromRGBO(193, 53, 132,1),
                Color.fromRGBO(131, 58, 180,1),
              ],
            ),
          ),
          child:Stack(
            children: [
              Column(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Expanded(
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text("Instagram",style:TextStyle(color:Colors.white,fontSize:45,fontFamily:'Billabong'),),
                        const SizedBox(height:20,),
                        //#email
                        Container(
                          height:50,
                          padding:const EdgeInsets.only(right:10,left:10),
                          decoration:BoxDecoration(
                            color:Colors.white54.withOpacity(0.2),
                            borderRadius:BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller:emailcontroler,
                            style:const TextStyle(color:Colors.white),
                            decoration:const InputDecoration(
                              hintText:'Email',
                              border:InputBorder.none,
                              hintStyle:TextStyle(fontSize:17.0,color:Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height:10,),
                        //#password
                        Container(
                          height:50,
                          padding:const EdgeInsets.only(right:10,left:10),
                          decoration:BoxDecoration(
                            color:Colors.white54.withOpacity(0.2),
                            borderRadius:BorderRadius.circular(7),
                          ),
                          child: TextField(
                            obscureText:true,
                            controller:passwordcontroler,
                            style:const TextStyle(color:Colors.white),
                            decoration:const InputDecoration(
                              hintText:'Password',
                              border:InputBorder.none,
                              hintStyle:TextStyle(fontSize:17.0,color:Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height:10,),
                        //#signin
                        GestureDetector(
                          onTap:(){
                            _doSignIn();
                          },
                          child:Container(
                            height:50,
                            padding:const EdgeInsets.only(left:10,right: 10),
                            decoration:BoxDecoration(
                              border:Border.all(color:Colors.white54.withOpacity(0.2),width:2),
                              borderRadius:BorderRadius.circular(7),
                            ),
                            child:const Center(
                              child:Text('Sign Up',style:TextStyle(color:Colors.white,fontSize:17),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child:Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",style:TextStyle(color:Colors.white,fontSize:16),),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap:(){
                            _callSiginUpPage();
                          },
                          child:const Text("Sign Up",style:TextStyle(color:Colors.white,fontSize:17,fontWeight:FontWeight.bold),),
                        ),
                        const SizedBox(width:20,),
                      ],
                    ),
                  ),
                ],
              ),
              isLoading ?
              const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox.shrink(),
            ],
          ),
        ),
      )
    );
  }
}
