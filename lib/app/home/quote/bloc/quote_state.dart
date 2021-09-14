part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}

class QuoteEmpty extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoading extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuotesError extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoaded extends QuoteState {
  final RandomQuote randomQuote;

  QuoteLoaded({required this.randomQuote});

  @override
  List<Object?> get props => [randomQuote];
}
