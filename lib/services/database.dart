abstract class Database {}

class FirestoreDataBase implements Database {
  FirestoreDataBase({required this.uid});

  final String uid;
}
