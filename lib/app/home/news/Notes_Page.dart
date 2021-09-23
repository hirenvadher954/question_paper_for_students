import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtu_question_paper/app/home/news/bloc/notes_bloc.dart';
import 'package:gtu_question_paper/common_widgets/pdf_viewer_page.dart';
import 'package:gtu_question_paper/repository/notes_section/firebase_notes_repository.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<NotesBloc>(
      create: (_) {
        return NotesBloc(notesRepository: FirebaseNotesRepository())
          ..add(LoadNotes());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Notes")),
        ),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is! NotesLoaded) {
              return SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final notesList = state.notesList;
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 800),
                  child: SlideAnimation(
                    child: buildCard(
                        context,
                        size,
                        notesList.elementAt(index).name,
                        notesList.elementAt(index).pdfLink),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildCard(context, Size size, String title, String pdfLink) {
    return InkWell(
      onTap: () => openPDF(context, pdfLink, title),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: GradientColors.facebookMessenger),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.robotoCondensed(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void openPDF(BuildContext context, String url, String title) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(url: url, title: title)),
      );
}
