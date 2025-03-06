import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  //text controller
  final TextEditingController textController = TextEditingController();

  //open dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                //button to save
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    //add a new note
                    if (docID == null) {
                      firestoreService.addNote(textController.text);
                    }
                    //update an existing note
                    else {
                      firestoreService.updateNote(docID, textController.text);
                    }

                    //clear the text controller
                    textController.clear();

                    //close the box
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add",
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Title(
          color: Colors.teal,
          child: Text(
            "Notes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          //if we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                //get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                //get note from aech doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                //display inside container
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.lightGreen.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: ListTile(
                    title: Text(
                      noteText,
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //update
                        IconButton(
                          onPressed: () => openNoteBox(docID: docID),
                          icon: Icon(Icons.settings),
                        ),
                        SizedBox(width: 10),
                        //delete
                        IconButton(
                          onPressed: () => firestoreService.deleteNote(docID),
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  ),
                );

                //display as a list title
              },
            );
          }
          // if there is no data rerturn nothing
          else {
            return const Text("No notes..");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: openNoteBox,
        backgroundColor: Colors.lightGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
