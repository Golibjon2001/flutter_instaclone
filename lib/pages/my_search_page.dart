import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/post/user_post.dart';
import 'package:flutter_instaclone/servise/data_servise.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading=false;
  List<User> itms=[];
  var searccontroler=TextEditingController();

  void _apiSearchUser(String keyword){
    setState(() {
      isLoading=true;
    });
    DataServise.searchUsers(keyword).then((user) =>{
      _respSearchUser(user),
    });
  }

  void _respSearchUser(List<User>users){
    setState(() {
      itms=users;
      isLoading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiSearchUser("");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation:0,
        centerTitle:true,
        title:const Text("Search",style:TextStyle(color:Colors.black,fontSize:30,fontFamily:'Billabong'),),
      ),
      body:Stack(
        children: [
          Container(
            padding:EdgeInsets.only(left:20,right:20),
            child:Column(
              children: [
                //#searchuser
                Container(
                  height:45,
                  margin:const EdgeInsets.only(bottom:10),
                  padding:const EdgeInsets.only(left:10,right:10),
                  decoration:BoxDecoration(
                    color:Colors.grey.withOpacity(0.2),
                    borderRadius:BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller:searccontroler,
                    style:TextStyle(color:Colors.black87),
                    onChanged:(input){
                      print(input);
                      _apiSearchUser(input);
                    },
                    decoration:const InputDecoration(
                      hintText:"Search",
                      border:InputBorder.none,
                      hintStyle:TextStyle(color:Colors.grey,fontSize:18),
                      icon:Icon(Icons.search,color:Colors.grey,),
                    ),
                  ),
                ),
                Expanded(
                  child:ListView.builder(
                      itemCount:itms.length,
                      itemBuilder:(ctx,x){
                        return itemOf(itms[x]);
                      }
                  ),
                ),
              ],
            ),
          ),
          isLoading ?
          const Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }
  Widget itemOf(User user){
    return Container(
      height:90,
      child:Row(
        children: [
          //#userImage
          Container(
            padding:EdgeInsets.all(2),
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(70),
              border:Border.all(width:1.5,color:Color.fromRGBO(193, 53, 132,1),),
            ),
            child:ClipRRect(
              borderRadius:BorderRadius.circular(22.5),
              child:user.img_url.isEmpty? const Image(
                image:AssetImage("assets/images/instagram-user.png"),
                height:45,
                width:45,
                fit:BoxFit.cover,
              ):Container(
                height:45,
                width:45,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(70),
                ),
                child:Image.network(user.img_url,fit:BoxFit.cover,),
              ),
            ),
          ),
          SizedBox(width:15,),
          Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(user.fullname,style:TextStyle(fontWeight:FontWeight.bold),),
              Text(user.email,style:TextStyle(color:Colors.black87),),
            ],
          ),
          Expanded(
              child:Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Container(
                    height:30,
                    width:100,
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(3),
                      border:Border.all(width:1,color:Colors.grey),
                    ),
                    child:const Center(
                      child:Text("Follow"),
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
