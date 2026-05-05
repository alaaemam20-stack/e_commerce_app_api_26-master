class LoginRequestModel {
  String?email;
  String?password;
  LoginRequestModel({this.email,this.password});
  Map<String,dynamic>tojson(){
   final Map<String,dynamic> data={};
    data["email"]=email;
    data["password"]=password;
    
    return data;

  }




}