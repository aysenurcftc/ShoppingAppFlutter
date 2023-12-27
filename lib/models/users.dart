

class User {
  late String? id;
  late String name;
  late String surname;
  late String username;
  late String email;
  late String phone;
  late String password;


  User({
    this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.phone,
  });

  toJson(){
    return {"name" : name, "surname":surname, "email": email, "phone number":phone, "password":password};
  }

}