part of 'find_paper_bloc.dart';

abstract class FindPaperState extends Equatable {
  const FindPaperState();

  @override
  List<Object?> get props => [];
}

class FindPaperLoading extends FindPaperState {}

class FindPaperLoaded extends FindPaperState {
  final List<FindPaper> paperList;

  const FindPaperLoaded([this.paperList = const []]);

  @override
  List<Object> get props => [paperList];

  @override
  String toString() => 'FindPaperLoadSuccess { paperList: $paperList }';
}

class FindPaperNotLoaded extends FindPaperState {}
