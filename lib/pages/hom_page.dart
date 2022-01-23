import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/servise/utilis_servise.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';
class HomPage extends StatefulWidget {
  static final String id="homPage";
  const HomPage({Key? key}) : super(key: key);

  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  PageController? _pageController;
  int _currenTab=0;
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController=PageController();
    _initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        controller:_pageController,
        children:[
          MyfeedPage(pageController:_pageController),
          const SearchPage(),
          UploadPage(pageController:_pageController),
          const LikesPage(),
          const ProfilePage(),
        ],
        onPageChanged:(int index){
          setState(() {
            _currenTab=index;
          });
        },
      ),
      bottomNavigationBar:CupertinoTabBar(
        onTap:(int index){
          setState(() {
            _currenTab=index;
            _pageController!.animateToPage(index,duration:Duration(milliseconds:200),curve:Curves.easeIn);
          });
        },
        currentIndex:_currenTab,
        activeColor:const Color.fromRGBO(193, 53,132,1),
        items: const [
          BottomNavigationBarItem(
               icon:Icon(Icons.home,size:32,),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.search,size:32,),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.add_box,size:32,),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.favorite,size:32,),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.account_circle,size:32,),
          ),
        ],
      ),
    );
  }
}
