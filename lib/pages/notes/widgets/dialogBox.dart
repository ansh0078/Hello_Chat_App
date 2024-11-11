import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController();
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: MediaQuery.viewInsetsOf(context),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add Tags",
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            TextFormField(
              autofocus: true,
              key: tagKey,
              controller: tagController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                hintText: "Add tag (< 16 characters)",
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "No tags added";
                } else if (value.trim().length > 16) {
                  return "Tags should not be more than 16 characters";
                }
                return null;
              },
              onChanged: (value) {
                tagKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (tagKey.currentState?.validate() ?? false) {
                  Navigator.pop(context, tagController.text.trim());
                }
              },
              child: const Text("Add Tag"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            )
          ],
        ),
      ),
    );
  }
}
