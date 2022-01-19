import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/post/post_image.dart';
class MyfeedPage extends StatefulWidget {
  PageController? pageController;
  MyfeedPage({this.pageController});
  @override
  _MyfeedPageState createState() => _MyfeedPageState();
}

class _MyfeedPageState extends State<MyfeedPage> {



  List<Post> itms=[];

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
        title:const Text('Instagram',style:TextStyle(color:Colors.black,fontSize:30,fontFamily:'Billabong')),
        actions: [
          IconButton(
              onPressed: (){
                widget.pageController!.animateToPage(2,duration:Duration(milliseconds:200),curve:Curves.easeIn);
              },
              icon:const Icon(Icons.camera_alt,color:Colors.black,),
          ),
        ],
      ),
      body:ListView.builder(
        itemCount:itms.length,
          itemBuilder:(ctx,x){
          return _itemOf(itms[x]);
          }
      ),
    );
  }
  Widget _itemOf(Post post){
    return Container(
      color:Colors.white,
      child:Column(
        children: [
          Divider(),
          //*userInfo
          Container(
            padding:EdgeInsets.symmetric(horizontal:10,vertical:10),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:BorderRadius.circular(40),
                      child:const Image(
                        image:AssetImage('assets/images/instagram-user.png'),
                        width:40,
                        height:40,
                        fit:BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width:10,),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: const [
                        Text("Username",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold),),
                        Text("February 2, 2020",style:TextStyle(color:Colors.black,fontWeight:FontWeight.normal),),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed:(){},
                    icon:const Icon(SimpleLineIcons.options),
                ),
              ],
            ),
          ),
          //*image
          //Image.network(post.postImage,fit:BoxFit.cover,),
          CachedNetworkImage(
            imageUrl:post.postImage,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          //*likeshere
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed:(){},
                      icon:Icon(FontAwesome.heart_o),
                  ),
                  IconButton(
                      onPressed:(){},
                      icon:Icon(FontAwesome.send),
                  )
                ],
              ),
            ],
          ),

          Container(
            width:MediaQuery.of(context).size.width,
            margin:EdgeInsets.only(left:10,right:10,bottom:10),
            child:RichText(
              softWrap:true,
              overflow:TextOverflow.visible,
              text:TextSpan(
                children:[
                  TextSpan(
                    text:"${post.caption}",
                    style:const TextStyle(color:Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
