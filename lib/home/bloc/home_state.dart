part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class DataLoading extends HomeState {}

class BranchDataLoaded extends HomeState {
  final List<Branch> branches;

  const BranchDataLoaded([this.branches = const []]);

  @override
  List<Object?> get props => [branches];

  @override
  String toString() => "Data Loaded {branches:$branches}";
}

class DataNotLoaded extends HomeState {}
