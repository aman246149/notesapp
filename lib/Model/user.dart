import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String username;

  User(
      {required this.email,
 
      required this.username,
      required this.uid});

  //method convert class into object

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "uid": uid,
      "email": email,

    };
  }

  //converting object into user
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data()! as Map<String, dynamic>;

    return User(
      email: snapshot['username'],
     
      username: snapshot["username"],
      uid: snapshot["uid"],
    );
  }
}
