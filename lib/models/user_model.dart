class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String profile;
  late String cover;
  late String bio;


  UserModel(this.name, this.email, this.phone, this.uId,this.profile,this.cover,this.bio);

  UserModel.fromjson(json){
    name= json['name'];
    email= json['email'];
    phone= json['phone'];
    uId= json['uId'];
    profile= json['profile'];
    cover= json['cover'];
    bio= json['bio'];
  }
  Map<String,dynamic> toMap()
  {
    return{
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'profile': profile,
      'cover': cover,
      'bio': bio,
  };

  }
}