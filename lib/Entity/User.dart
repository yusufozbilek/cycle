class firebaseUser{
  String? userID;
  String? username;
  String? email;
  DateTime? creationDate;
  firebaseUser({
    required this.userID,
    required this.username,
    required this.email,
    required this.creationDate
  });
  firebaseUser.empty(){
    userID = "";
    username = "Null";
    email = "";
    creationDate = DateTime.now();
  }
}