import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/sqldb.dart';
import 'package:notes_app_sqflite/views/notes_view.dart';
import 'package:notes_app_sqflite/widgets/custom_button.dart';
import 'package:notes_app_sqflite/widgets/custom_text_form_field.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({
    super.key,
  });

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  SqlDb sqlDb = SqlDb();
  String? title, content, color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              hint: "title",
              onChanged: (p0) {
                title = p0;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              onChanged: (p0) {
                content = p0;
              },
              hint: "subTitle",
              maxLines: 6,
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              onChanged: (p0) {
                color = p0;
              },
              hint: "color",
              maxLines: 6,
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              title: "Add Note",
              onTap: () async {
                await sqlDb.insertData('''
INSERT INTO notes ("title","color","content")
VALUES ("$title","$color","$content")


''',);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesView(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
