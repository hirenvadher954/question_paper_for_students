part of 'find_paper_bloc.dart';

abstract class FindPaperEvent extends Equatable {
  const FindPaperEvent();

  @override
  List<Object?> get props => [];
}

class LoadFindPapers extends FindPaperEvent {}

class FindPaperUpdated extends FindPaperEvent {
  final List<FindPaper> paperList;

  const FindPaperUpdated(this.paperList);

  @override
  List<Object> get props => [paperList];
}
