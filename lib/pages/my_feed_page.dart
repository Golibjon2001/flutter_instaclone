import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/post/post_image.dart';
import 'package:flutter_instaclone/servise/auth_servise.dart';
import 'package:flutter_instaclone/servise/data_servise.dart';
import 'package:flutter_instaclone/servise/utilis_servise.dart';
class MyfeedPage extends StatefulWidget {
  PageController? pageController;
  MyfeedPage({this.pageController});
  @override
  _MyfeedPageState createState() => _MyfeedPageState();
}

class _MyfeedPageState extends State<MyfeedPage> {

  List<Post> itms=[];

  bool isLoading=true;

  void _apiLoadFeds(){
    DataServise.loadFeeds().then((value) => {
      _resLoadFeeds(value),
    });
  }

  void _resLoadFeeds(List<Post>posts){
    setState(() {
      itms=posts;
    });
  }

  void _apiPostLike(Post post) async {
    setState(() {
      isLoading = true;
    });
    await DataServise.likePost(post, true);
    setState(() {
      isLoading = false;
      post.liked = true;
    });
  }

  void _apiPostUnLike(Post post) async {
    setState(() {
      isLoading = true;
    });
    await DataServise.likePost(post, false);
    setState(() {
      isLoading = false;
      post.liked = false;
    });
  }

  _actionRemovePosts(Post post)async{
    var result=await Utils.dialogCommon(context, "Insta Clone", "Do you  want to remove this post?", false);
    if(result!=null&&result){
      setState(() {
        isLoading=true;
      });
      DataServise.removePost(post).then((value) =>{
        _apiLoadFeds(),
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadFeds();
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
              icon:const Icon(Icons.camera_alt,color: Color.fromRGBO(193, 53, 132,1),),
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
            padding:const EdgeInsets.symmetric(horizontal:10,vertical:10),
            child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:BorderRadius.circular(40),
                      child:(post.img_user==null||post.img_user.isEmpty)? const Image(
                        image:AssetImage('assets/images/instagram-user.png'),
                        width:40,
                        height:40,
                        fit:BoxFit.cover,
                      ):Image.network(post.img_user,width:40,height:40,fit:BoxFit.cover,)
                    ),
                    const SizedBox(width:10,),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:  [
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
                    icon: const Icon(SimpleLineIcons.options),
                ):const SizedBox.shrink(),
              ],
            ),
          ),
          //*image
          //Image.network(post.postImage,fit:BoxFit.cover,),
          CachedNetworkImage(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.width,
            imageUrl:post.img_post,
            placeholder: (context, url) => const Center(child:CircularProgressIndicator(),),
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
                        if(!post.liked){
                          _apiPostLike(post);
                        }else{
                          _apiPostUnLike(post);
                        }
                      },
                      icon:post.liked?
                      const Icon(FontAwesome.heart,color:Colors.red,)
                          :const Icon(FontAwesome.heart_o),
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
