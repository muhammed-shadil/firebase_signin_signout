class usermodel {
  String? uid;
  String? email;
  String? username;
  String? phone;
  String? age;
  usermodel({this.uid, this.age, this.email, this.phone, this.username});

  factory usermodel.fromMap(map) {
    return usermodel(
        uid: map['uid'],
        username: map['username'],
        email: map['email'],
        phone: map['phone'],
        age: map['age']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'phone': phone,
      'age': age
    };
  }
}
