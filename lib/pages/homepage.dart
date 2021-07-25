import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noted/pages/addnote.dart';
import 'package:noted/pages/viewnote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color> myColors = [
    const Color(0xffff7575),
    const Color(0xffffa870),
    const Color(0xffffdb53),
    const Color(0xffb3ff5d),
    const Color(0xff3cff86),
    const Color(0xff03d7b7),
    const Color(0xff628df4),
    const Color(0xffb169ff),
    const Color(0xfffd8dff),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          )
              .then((value) {
            print("calling set state! ");
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey[700],
      ),
      appBar: AppBar(
        title: const Text(
          "My Notes",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "lato",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xff070706),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No saved Notes!",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Random random = Random();
                    Color bg = myColors[random.nextInt(4)];
                    Map? data = snapshot.data!.docs[index].data() as Map?;
                    DateTime myDateTime = data!['created'].toDate();
                    String formattedTime =
                        DateFormat.yMMMd().add_jm().format(myDateTime);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewNote(
                            data,
                            formattedTime,
                            snapshot.data!.docs[index].reference,
                          ),
                        )
                        ).then((value) {
                          setState((){});
                        });
                      },
                      child: Card(
                        color: bg,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  formattedTime,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "lato",
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text("loading..."),
              );
            }
          }),
    );
  }
}
