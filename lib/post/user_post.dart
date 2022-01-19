class User{
  String uid;
  String fullname;
  String img_url;
  String password;
  String email;

  bool follwed=false;
  int follovers_count=0;
  int following_count=0;

  User({required this.fullname,required this.email,required this.password}):img_url='',uid="";

  User.fromJson(Map<String,dynamic> json)
  :uid=json['uid'],
  fullname=json['fullname'],
  img_url=json['img_url'],
  password=json['password'],
  email=json['email'];

  Map<String,dynamic> toJson()=>{
  'uid':uid,
  'fullname':fullname,
  'img_url':img_url,
  'password':password,
  'email':email,
  };

  @override
  bool operator==(other){

    return (other is User) && other.uid==uid;
  }
}