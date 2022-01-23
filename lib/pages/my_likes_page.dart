import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/post/post_image.dart';
import 'package:flutter_instaclone/servise/data_servise.dart';
import 'package:flutter_instaclone/servise/utilis_servise.dart';
class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  bool isLoading=true;
  List<Post> itms=[];

  void _apiLoadLikes(){
    setState(() {
      isLoading=true;
    });
    DataServise.loadLikes().then((value) => {
      _resLoadLikes(value),
    });
  }

  void _apiPostUnLike(Post post) async {
    setState(() {
      isLoading = true;
      post.liked = false;
    });
    await DataServise.likePost(post, false).then((value) => {
      _apiLoadLikes(),
    });
  }

  void  _resLoadLikes(List<Post> post){
    setState(() {
      itms=post;
      isLoading=false;
    });
  }

  _actionRemovePosts(Post post)async{
    var result=await Utils.dialogCommon(context, "Insta Clone", "Do you  want to remove this post?", false);
    if(result!=null&&result){
      setState(() {
        isLoading=true;
      });
      DataServise.removePost(post).then((value) =>{
        _apiLoadLikes(),
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadLikes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation:0,
        centerTitle:true,
        title:const Text('Likes',style:TextStyle(color:Colors.black,fontSize:30,fontFamily:'Billabong')),

      ),
      body:Stack(
        children: [
          itms.length > 0?
          ListView.builder(
              itemCount:itms.length,
              itemBuilder:(ctx,x){
                return _itemOf(itms[x]);
              }
          ):const Center(
            child:Text("No liked posts",style:TextStyle(fontSize:20,color:Colors.black87,fontWeight:FontWeight.bold),),
          ),

          isLoading ?
          const Center(
            child: CircularProgressIndicator(),
          ): const SizedBox.shrink(),
        ],
      ),
    );
  }
  Widget _itemOf(Post post){
    return Container(
      color:Colors.white,
      child:Column(
        children: [
          const Divider(),
          //*userInfo
          Container(
            padding:const EdgeInsets.symmetric(horizontal:10,vertical:10),
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
                      children: [
                        Text(post.fullname,style:const TextStyle(color:Colors.black,fontWeight:FontWeight.bold),),
                        Text(post.date,style:const TextStyle(color:Colors.black,fontWeight:FontWeight.normal),),
                      ],
                    ),
                  ],
                ),post.mine?
                IconButton(
                  onPressed:(){
                    _actionRemovePosts(post);
                  },
                  icon:const Icon(SimpleLineIcons.options),
                ):const SizedBox.shrink(),
              ],
            ),
          ),
          //*image
          //Image.network(post.postImage,fit:BoxFit.cover,),
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            imageUrl:post.img_post,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit:BoxFit.cover,
          ),
          //*likeshere
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed:(){
                      if(post.liked){
                        _apiPostUnLike(post);
                      }
                    },
                    icon:post.liked?
                    const Icon(FontAwesome.heart,color:Colors.red,):
                        const Icon(FontAwesome.heart_o),
                  ),
                  IconButton(
                    onPressed:(){},
                    icon:const Icon(Icons.share),
                  )
                ],
              ),
            ],
          ),

          Container(
            width:MediaQuery.of(context).size.width,
            margin:const EdgeInsets.only(left:10,right:10,bottom:10),
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
