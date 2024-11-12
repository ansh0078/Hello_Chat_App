import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/config/string.dart';
import 'package:hello/controller/newNoteController.dart';
import 'package:hello/controller/noteProvider.dart';
import 'package:hello/pages/notes/widgets/dialogBox.dart';
import 'package:hello/widgets/primaryBtn.dart';
import 'package:provider/provider.dart';

class NewNotesPage extends StatefulWidget {
  const NewNotesPage({
    super.key,
    required this.isNewNote,
  });
  final bool isNewNote;

  @override
  State<NewNotesPage> createState() => _NewNotesPageState();
}

class _NewNotesPageState extends State<NewNotesPage> {
  late final NewNoteController newNoteController;
  late final TextEditingController titleController;
  late final QuillController quillController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read<NewNoteController>();
    titleController = TextEditingController(text: newNoteController.title);
    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });
    focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
        quillController.document = newNoteController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }
        final bool? shouldSave = await showDialog<bool?>(
            context: context,
            builder: (_) => Center(
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.75,
                      margin: MediaQuery.viewInsetsOf(context),
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Do you want to save the note?",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryBtn(
                                btnName: "No",
                                ontap: () => Navigator.pop(context, false),
                                color: Colors.red,
                              ),
                              const SizedBox(width: 20),
                              PrimaryBtn(
                                btnName: "Yes",
                                ontap: () => Navigator.pop(context, true),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ));
        if (shouldSave == null) return;
        if (!context.mounted) return;
        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewNote ? "New Notes" : "Edit Note"),
          actions: [
            // GestureDetector(
            //   onTap: () {

            //     // context.read<NotesProvider>().deleteNote(note);
            //   },
            //   child: FaIcon(FontAwesomeIcons.trash),
            // ),
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) => newNoteController.readOnly,
              builder: (context, readOnly, child) => IconButton(
                onPressed: () {
                  newNoteController.readOnly = !readOnly;
                  if (newNoteController.readOnly) {
                    FocusScope.of(context).unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen),
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder: (_, canSaveNote, __) => IconButton(
                onPressed: canSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
                icon: const Icon(Icons.save_alt_outlined),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, read, child) => TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: "Tittle here...",
                    hintStyle: TextStyle(color: Colors.grey.shade300),
                  ),
                  canRequestFocus: !read,
                  onChanged: (newValue) {
                    newNoteController.title = newValue;
                  },
                ),
              ),
              if (!widget.isNewNote) ...[
                Row(
                  children: [
                    const Expanded(flex: 3, child: Text("Last Modified :")),
                    Expanded(flex: 5, child: Text(toLongDate(newNoteController.note!.dateModified))),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 3, child: Text("Created :")),
                    Expanded(flex: 5, child: Text(toLongDate(newNoteController.note!.dateCreated))),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        const Text("Tags"),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () async {
                            final String? tag = await showDialog<String?>(
                              context: context,
                              builder: (context) => const Center(
                                child: DialogBox(),
                              ),
                            );
                            if (tag != null) {
                              newNoteController.addTag(tag);
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.circlePlus),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(),
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          iconSize: 18,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Selector<NewNoteController, List<String>>(
                      selector: (_, NewNoteController) => newNoteController.tags,
                      builder: (_, tags, __) => tags.isEmpty
                          ? const Text("No tags added")
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  tags.length,
                                  (index) => NoteTag(
                                    label: tags[index],
                                    onClosed: () {
                                      newNoteController.removeTag(index);
                                    },
                                    onTap: () async {
                                      final String? tag = await showDialog<String?>(
                                        context: context,
                                        builder: (context) => Center(
                                          child: DialogBox(
                                            tag: tags[index],
                                          ),
                                        ),
                                      );
                                      // if (tag != null) {
                                      //   newNoteController.addTag(tag);
                                      // }
                                      if (tag != null && tag != tags[index]) {
                                        newNoteController.updateTag(tag, index);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Expanded(
                child: Column(
                  children: [
                    QuillSimpleToolbar(
                      controller: quillController,
                      configurations: const QuillSimpleToolbarConfigurations(
                        multiRowsDisplay: false,
                      ),
                    ),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: quillController,
                        configurations: const QuillEditorConfigurations(
                          placeholder: "Notes here...",
                          expands: true,
                        ),
                        focusNode: focusNode,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoteTag extends StatelessWidget {
  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;
  const NoteTag({
    super.key,
    required this.label,
    this.onClosed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8, top: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onClosed != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onClosed,
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
