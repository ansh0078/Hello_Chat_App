import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/model/notes.dart';
import 'package:hello/pages/notes/newNotesPage.dart';
import 'package:intl/intl.dart';

class NoteTitle extends StatelessWidget {
  final Note note;
  // final String title;
  // final String subTitle;
  // final String lastTime;
  const NoteTitle({
    super.key,
    // required this.title,
    // required this.subTitle,
    // required this.lastTime,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(NewNotesPage(isNewNote: false));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (note.title != null) ...[
                          Text(
                            note.title!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                        const SizedBox(height: 5),
                        if (note.content != null) ...[
                          Text(
                            note.content!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("dd MMM, y").format(DateTime.fromMicrosecondsSinceEpoch(note.dateModified)),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(note.dateModified)),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
