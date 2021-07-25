import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String desc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[700],
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ))),
                    ),
                    ElevatedButton(
                      onPressed: add,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "lato",
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.lightBlue,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: const TextStyle(
                          fontSize: 25,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        onChanged: (_val) {
                          title = _val;
                        },
                      ),
                      //
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: const TextStyle(
                            fontSize: 19,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                          onChanged: (_val) {
                            desc = _val;
                          },
                          maxLines: 20,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    //save to database
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': desc,
      'created': DateTime.now(),
    };
    ref.add(data);
    //
    Navigator.pop(context);
  }
}
