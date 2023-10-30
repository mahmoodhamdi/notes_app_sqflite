import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/sqldb.dart';
import 'package:notes_app_sqflite/views/add_note_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> notes = await sqlDb.readData("SELECT * FROM 'notes'");
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNoteView(),
                ));
          },
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () async {
                    await sqlDb.insertData(
                      '''
INSERT INTO notes ("title","color","content")
VALUES ("title","color","content")


''',
                    );
                    setState(() {});
                  },
                  child: const Text("insert ")),
              InkWell(
                  onTap: () async {
                    await sqlDb.deleteMyDatabase();

                    setState(() {});
                  },
                  child: const Text("delete all ")),
              InkWell(
                  onTap: () async {
                    int response = await sqlDb
                        .deleteData("DELETE FROM 'notes' WHERE id=20");

                    setState(() {});
                  },
                  child: const Text("delete ")),
              InkWell(
                  onTap: () async {
                    int response = await sqlDb.updateData(
                        "UPDATE 'notes' SET 'title'='titleALPH' WHERE ID=5 ");

                    setState(() {});
                  },
                  child: const Text("update ")),
            ],
          ),
        ),
        body: FutureBuilder(
          future: readData(),
          builder: (context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("${snapshot.data![index]}"),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
