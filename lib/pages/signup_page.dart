import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/hom_page.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
import 'package:flutter_instaclone/post/user_post.dart';
import 'package:flutter_instaclone/servise/auth_servise.dart';
import 'package:flutter_instaclone/servise/data_servise.dart';
import 'package:flutter_instaclone/servise/prefs_servise.dart';
import 'package:flutter_instaclone/servise/utilis_servise.dart';

class SignUpPage extends StatefulWidget {
  static final String id="siginup";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var emailcontroler=TextEditingController();
  var passwordcontroler=TextEditingController();
  var fulnamecontroler=TextEditingController();
  var confirmpasswordcontroler=TextEditingController();

  _doSignUp(){
    String name = fulnamecontroler.text.toString().trim();
    String email = emailcontroler.text.toString().trim();
    String password = passwordcontroler.text.toString().trim();
    String cpassword = confirmpasswordcontroler.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;

    if(cpassword!=password){
      Utils.fireToast("Passsword and confirm password  does  not match");
      return;
    }

    setState(() {
      isLoading = true;
    });
    User user=User(fullname: name, email: email, password: password);
    AuthService.signUpUser(context, name, email, password).then((value) => {
      _getFirebaseUser(user,value),
    });
  }

  _getFirebaseUser(User user,Map<String,FirebaseUser> map) async {
    setState(() {
      isLoading = false;
    });

    FirebaseUser? firebaseUser;
    if (!map.containsKey("SUCCESS")) {
      if (map.containsKey("ERROR_EMAIL_ALREADY_IN_USE"))
        Utils.fireToast("Email already in use");
      if (map.containsKey("ERROR"))
        Utils.fireToast("Try again later");
      return;
    }
    firebaseUser = map["SUCCESS"];
    if (firebaseUser == null) return;

      await Prefs.saveUserId(firebaseUser.uid);
      DataServise.storeUser(user).then((value) => {
        Navigator.pushReplacementNamed(context, HomPage.id),
      });
    }

  _callSiginInPage(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
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
                        //#fulname
                        Container(
                          height:50,
                          padding:const EdgeInsets.only(right:10,left:10),
                          decoration:BoxDecoration(
                            color:Colors.white54.withOpacity(0.2),
                            borderRadius:BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller:fulnamecontroler,
                            style:const TextStyle(color:Colors.white),
                            decoration:const InputDecoration(
                              hintText:'Fullname',
                              border:InputBorder.none,
                              hintStyle:TextStyle(fontSize:17.0,color:Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height:10,),
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
                        //Conforn password
                        Container(
                          height:50,
                          padding:const EdgeInsets.only(right:10,left:10),
                          decoration:BoxDecoration(
                            color:Colors.white54.withOpacity(0.2),
                            borderRadius:BorderRadius.circular(7),
                          ),
                          child: TextField(
                            obscureText:true,
                            controller:confirmpasswordcontroler,
                            style:const TextStyle(color:Colors.white),
                            decoration:const InputDecoration(
                              hintText:'Confirm Password',
                              border:InputBorder.none,
                              hintStyle:TextStyle(fontSize:17.0,color:Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height:10,),
                        //#signun
                        GestureDetector(
                          onTap:(){
                            _doSignUp();
                          },
                          child:Container(
                            height:50,
                            padding:const EdgeInsets.only(left:10,right: 10),
                            decoration:BoxDecoration(
                              border:Border.all(color:Colors.white54.withOpacity(0.2),width:2),
                              borderRadius:BorderRadius.circular(7),
                            ),
                            child:const Center(
                              child:Text('Sign In',style:TextStyle(color:Colors.white,fontSize:17),),
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
                        const Text("Already have an account?",style:TextStyle(color:Colors.white,fontSize:16),),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap:(){
                            _callSiginInPage();
                          },
                          child:const Text("Sign In",style:TextStyle(color:Colors.white,fontSize:17,fontWeight:FontWeight.bold),),
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
      ),
    );
  }
}
