import 'firestore_service.dart';

abstract class Database {}

class FirestoreDataBase implements Database {
  FirestoreDataBase({required this.uid});

  final String uid;

  final _service = FirestoreService.instance;
}
