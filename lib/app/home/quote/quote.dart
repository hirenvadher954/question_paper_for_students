import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/quote/bloc/quote_bloc.dart';

class Quote extends StatelessWidget {
  Quote({required this.fontSize});

  final QuoteBloc quoteBloc = QuoteBloc();

  final fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteBloc>(
      create: (context) => quoteBloc,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteEmpty) {
              BlocProvider.of<QuoteBloc>(context).add(FetchingQuote());
            }
            if (state is QuoteLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Hero(
                    tag: 'quoteText',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        state.randomQuote.content,
                        style: GoogleFonts.robotoSlab(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      " - " + state.randomQuote.author,
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              );
            }
            if (state is QuotesError) {
              return Center(
                child: Text(
                  "Something went wrong :(",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
