import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/post/post_image.dart';
import 'package:flutter_instaclone/servise/auth_servise.dart';
import 'package:image_picker/image_picker.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var axsis=1;
  List<Post> itms=[];
  File? _image;

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  String post_img1='https://firebasestorage.googleapis.com/v0/b/fire-post-d2cb9.appspot.com/o/post_images%2Fimage_2022-01-09%2008%3A05%3A38.932848?alt=media&token=422c6751-a71b-4099-b2f3-55';
  String post_img2='https://firebasestorage.googleapis.com/v0/b/fire-post-d2cb9.appspot.com/o/post_images%2Fimage_2022-01-09%2008%3A07%3A21.954007?alt=media&token=abbf240f-1430-401e-a737-9a922414b2b4';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itms.add(Post(postImage:post_img1,caption:"Discover more great images on our sponsor's site"));
    itms.add(Post(postImage:post_img2,caption:"Discover more great images on our sponsor's site"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation:0,
        centerTitle:true,
        title:const Text("Profile",style:TextStyle(color:Colors.black,fontSize:30,fontFamily:'Billabong'),),
        actions: [
          IconButton(
              onPressed:(){
                AuthService.signOutUser(context);
              },
              icon:Icon(Icons.exit_to_app),
            color:Colors.black87,
          ),
        ],
      ),
      body:Container(
        width:double.infinity,
        padding:EdgeInsets.all(10),
        child:Column(
          children:  [
            //#myphoto
            Stack(
              children: [
                Container(
                  padding:EdgeInsets.all(2),
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(70),
                      border:Border.all(width:1,color:Color.fromRGBO(193, 53, 132,1),)
                  ),
                  child:ClipRRect(
                    borderRadius:BorderRadius.circular(70),
                    child:_image==null?const Image(
                      image:AssetImage("assets/images/instagram-user.png"),
                      height:70,
                      width:70,
                      fit:BoxFit.cover,
                    ):Container(
                      height:70,
                      width:70,
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(70),
                      ),
                      child:Image.file(_image!,fit:BoxFit.cover,),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    _imgFromGallery();
                  },
                  child:Container(
                    height:80,
                    width:80,
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.end,
                      crossAxisAlignment:CrossAxisAlignment.end,
                      children: const [
                        Icon(Icons.add_circle,color:Colors.purple,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //#myinfos
            const SizedBox(height:10,),
            Text("Khurshidbek".toUpperCase(),style:const TextStyle(color:Colors.black,fontSize:16,fontWeight:FontWeight.bold),),
            const SizedBox(height:3,),
            const Text("khurshid@gmail.com",style:TextStyle(fontSize:14,color:Colors.black,fontWeight:FontWeight.normal),),
            //#myinfos
            Container(
              height:80,
              child:Row(
                children: [
                  Expanded(
                      child:Center(
                        child:Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: const [
                            Text("675",style:TextStyle(color:Colors.black,fontSize:16,fontWeight:FontWeight.bold),),
                            SizedBox(height:3,),
                            Text("POST",style:TextStyle(color:Colors.grey,fontSize:14,fontWeight:FontWeight.normal),),
                          ],
                        ),
                      ),
                  ),
                  Container(height:20,width:1,color:Colors.grey,),
                  Expanded(
                    child:Center(
                      child:Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: const [
                          Text("675",style:TextStyle(color:Colors.black,fontSize:16,fontWeight:FontWeight.bold),),
                          SizedBox(height:3,),
                          Text("FOLLOWERS",style:TextStyle(color:Colors.grey,fontSize:14,fontWeight:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                  Container(height:20,width:1,color:Colors.grey,),
                  Expanded(
                    child:Center(
                      child:Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: const [
                          Text("675",style:TextStyle(color:Colors.black,fontSize:16,fontWeight:FontWeight.bold),),
                          SizedBox(height:3,),
                          Text("FOLLOWING",style:TextStyle(color:Colors.grey,fontSize:14,fontWeight:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height:40,
              padding:EdgeInsets.all(10),
              child:Row(
                children: [
                  Expanded(
                    child:IconButton(
                      onPressed:(){
                        setState(() {
                          axsis=1;
                        });
                      },
                      icon:Icon(Icons.list_alt),
                    ),
                  ),
                  Expanded(
                    child:IconButton(
                      onPressed:(){
                        setState(() {
                          axsis=2;
                        });
                      },
                      icon:Icon(Icons.grid_view),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:axsis),
                itemCount:itms.length,
                itemBuilder:(ctx,x){
                  return _itmOfPost(itms[x]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _itmOfPost(Post post){
    return Container(
      margin:EdgeInsets.all(5),
      child:Column(
        children: [
          Expanded(
            child:CachedNetworkImage(
              imageUrl:post.postImage,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height:3,),
          Text(post.caption,style:TextStyle(color:Colors.black87.withOpacity(0.7)),maxLines:2,),
        ],
      ),
    );
  }
}
