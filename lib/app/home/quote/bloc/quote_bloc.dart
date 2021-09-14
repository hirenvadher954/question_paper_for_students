import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtu_question_paper/app/home/quote/model/random_quote.dart';
import 'package:http/http.dart' as http;

part 'quote_event.dart';

part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteEmpty());

  @override
  Stream<QuoteState> mapEventToState(
    QuoteEvent event,
  ) async* {
    if (event is FetchingQuote) {
      yield QuoteLoading();
      try {
        final url = "http://api.quotable.io/random?maxLength=50";
        final http.Response randomQuoteResponse =
            await http.get(Uri.parse(url));
        if (randomQuoteResponse.statusCode != 200) {
          throw new Exception('error getting quotes');
        }
        RandomQuote randomQuote =
            RandomQuote.fromJson(json.decode(randomQuoteResponse.body));
        yield QuoteLoaded(randomQuote: randomQuote);
      } catch (e) {
        yield QuotesError();
      }
    }
  }
}
