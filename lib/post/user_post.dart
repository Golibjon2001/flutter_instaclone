class User{
  String uid;
  String fullname;
  String img_url;
  String password;
  String email;

  String? device_id="";
  String? device_type="";
  String? device_token="";

  bool follwed=false;
  int follovers_count=0;
  int following_count=0;

  User({required this.fullname,required this.email,required this.password}):img_url='',uid="";

  User.fromJson(Map<String,dynamic> json)
  :uid=json['uid'],
  fullname=json['fullname'],
  img_url=json['img_url'],
  password=json['password'],
  email=json['email'],
  device_id=json['device_id'],
  device_type=json['device_type'],
  device_token=json['device_token'];

  Map<String,dynamic> toJson()=>{
  'uid':uid,
  'fullname':fullname,
  'img_url':img_url,
  'password':password,
  'email':email,
  'device_id':device_id,
  'device_type':device_type,
  'device_token':device_token,
  };

  @override
  bool operator==(other){

    return (other is User) && other.uid==uid;
  }
}