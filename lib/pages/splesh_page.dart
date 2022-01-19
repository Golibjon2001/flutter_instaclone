import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/hom_page.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
class SpleshPage extends StatefulWidget {
  static final String id="splesh";
  const SpleshPage({Key? key}) : super(key: key);

  @override
  _SpleshPageState createState() => _SpleshPageState();
}

class _SpleshPageState extends State<SpleshPage> {
  _initTimer(){
    Timer(Duration(seconds:2),(){
      _callHomPage();
    });
  }

  _callHomPage(){
    Navigator.pushReplacementNamed(context,HomPage.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        width:MediaQuery.of(context).size.width,
        decoration:const BoxDecoration(
          gradient:LinearGradient(
            begin:Alignment.topCenter,
            end:Alignment.bottomCenter,
            colors:[
              Color.fromRGBO(193, 53,132,1),
              Color.fromRGBO(131, 58,180,1),
            ]
          ),
        ),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.end,
          children:  const [
            Expanded(
                child:Center(
                  child:Text("Instagram",style:TextStyle(color:Colors.white,fontSize:45,fontFamily:'Billabong'),),
                ),
            ),
            Text("All rights reserved",style:TextStyle(color:Colors.white,fontSize:16),),
            SizedBox(height:10,),
          ],
        ),
      ),
    );
  }
}

