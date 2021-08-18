import 'models/models.dart';

abstract class BranchRepository {
  Stream<List<Branch>> branchData();
}