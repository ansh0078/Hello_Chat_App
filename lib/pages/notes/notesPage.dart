import 'package:flutter/material.dart';
import 'package:hello/config/images.dart';
import 'package:hello/controller/noteProvider.dart';
import 'package:hello/model/notes.dart';
import 'package:hello/pages/notes/widgets/notesTitle.dart';
import 'package:provider/provider.dart';

class Notespage extends StatelessWidget {
  const Notespage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsImage.notes,
                        color: Colors.white,
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "You have no notes yet\nStart creating by presing the + button below",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteTitle(
                      note: notes[index],
                    );
                  });
        },
      ),
    );
  }
}
