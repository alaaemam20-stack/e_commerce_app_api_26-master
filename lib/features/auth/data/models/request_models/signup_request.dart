class SignupRequestModel {
   String name;
  String email;
   String password;

   SignupRequestModel({required this.name,required this.email,required this.password});



   Map<String,dynamic>tojson(){
    final Map<String,dynamic> data={};
     data["name"]=name;
     data["email"]=email;
     data["password"]=password;
    data["avatar"]="https://picsum.photos/800";
     return data;

   }


}