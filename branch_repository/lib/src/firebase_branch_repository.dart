import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:branch_repository/branch_repository.dart';

import 'entities/entities.dart';

class FirebaseBranchRepository implements BranchRepository {
  final branchCollection = FirebaseFirestore.instance.collection('branchList');

  @override
  Stream<List<Branch>> branchData() {
    return branchCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Branch.fromEntity(BranchEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
