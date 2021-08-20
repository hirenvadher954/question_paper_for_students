part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class BranchLoadData extends HomeEvent {}

class BrachDataUpdated extends HomeEvent {
  final List<Branch> branches;

  const BrachDataUpdated(this.branches);

  @override
  List<Object?> get props => [branches];
}
