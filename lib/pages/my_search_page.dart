import 'package:flutter/material.dart';
import 'package:flutter_instaclone/post/user_post.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> itms=[];
  var searccontroler=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // itms.add(User(fullname: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
    // itms.add(User(username: "G'olibjon", email:"yuldashev@gmail.com"));
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
      body:Container(
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
              child:const Image(
                image:AssetImage("assets/images/instagram-user.png"),
                height:45,
                width:45,
                fit:BoxFit.cover,
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
                    child:Center(
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
