import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subject_repository/branch_repository.dart';

import 'entities/entities.dart';

class FirebaseBranchRepository implements BranchRepository {
  final branchCollections = FirebaseFirestore.instance.collection('branchList');

  @override
  Stream<List<Branch>> branchData() {
    return branchCollections.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Branch.fromEntity(BranchEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
