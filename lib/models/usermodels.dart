class User{
  String firstname = '';
  String lastname = '';
  String middlename = '';
  String email = '';
  String phone = '';
  User();

  factory User.fromJson(Map<String,dynamic> json){
    User user = User();
    user.phone = json['phone'];
    user.firstname = json['first_name'];
    user.middlename = json['middle_name'];
    user.lastname = json['last_name'];
    user.email = json['email'];
    return user;
  }
}