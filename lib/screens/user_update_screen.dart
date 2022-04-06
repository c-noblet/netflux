import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflux/components/forms/user_form.dart';

import '../models/user_model.dart';


class UserUpdateScreen extends StatelessWidget {
  const UserUpdateScreen({Key? key}) : super(key: key);

  Stream<DocumentSnapshot> getUserDatas () {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: getUserDatas(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            UserModel user = UserModel.fromSnapshot(snapshot.data);
            
            return UserForm(user: user);
          } else if (snapshot.hasError) {
            return const Text('Internal error');
          }

          return const CircularProgressIndicator();
        }
      ),
    );
  }
}