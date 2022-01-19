
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UploadPage extends StatefulWidget {
  PageController? pageController;
  UploadPage({this.pageController});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  var captioncontroler=TextEditingController();

  File? _image;

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _uploadNewPost(){
    String caption=captioncontroler.text.toString().trim();
    if(caption.isEmpty)return;
    if(_image==null)return;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        elevation:0,
        backgroundColor:Colors.white,
        centerTitle:true,
        title:const Text("Upload",style:TextStyle(color:Colors.black,fontSize:25,fontFamily:'Billabong'),),
        actions: [
          IconButton(
              onPressed:(){
                _uploadNewPost();
                widget.pageController!.animateToPage(0,duration:Duration(milliseconds:200),curve:Curves.easeIn);
              },
              icon:const Icon(Icons.post_add,color:Color.fromRGBO(245, 96, 64, 1),),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child:Container(
          height:MediaQuery.of(context).size.height,
          child:Column(
            children: [
              GestureDetector(
                onTap:(){
                  _imgFromGallery();
                },
                child:Container(
                  width:double.infinity,
                  height:MediaQuery.of(context).size.width,
                  color:Colors.grey.withOpacity(0.2),
                  child:_image==null? const Center(
                    child:Icon(Icons.add_a_photo,size:60,color:Colors.grey,),
                  ):Stack(
                    children: [
                      Image.file(_image!,fit:BoxFit.cover,height:double.infinity,width:double.infinity,),
                      Container(
                        width:double.infinity,
                        color:Colors.black12,
                        padding:EdgeInsets.all(20),
                        child:Column(
                          crossAxisAlignment:CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed:(){
                                  setState(() {
                                    _image=null;
                                  });
                                },
                                icon:Icon(Icons.highlight_remove,color:Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.only(left:10,right:10,top:10),
                child:  TextField(
                  controller:captioncontroler,
                  style:const TextStyle(color:Colors.black),
                  keyboardType:TextInputType.multiline,
                  minLines:1,
                  decoration:const InputDecoration(
                    hintText: 'Caption',
                    hintStyle:TextStyle(color:Colors.black54,fontSize:17.0)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
