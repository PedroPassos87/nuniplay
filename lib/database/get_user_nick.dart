import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserNick extends StatelessWidget {
  final String documentId;

  GetUserNick({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Text(
              '${data['username']}',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 21,
                  fontWeight: FontWeight.w700),
            ),
          );
        }
        return Text('Loading......');
      },
    );
  }
}
