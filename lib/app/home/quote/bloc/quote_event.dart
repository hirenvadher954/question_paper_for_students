part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();
}

class FetchingQuote extends QuoteEvent {
  @override
  List<Object?> get props => [];
}
