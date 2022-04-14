import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflux/components/cards/profile_card.dart';
import 'package:netflux/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Stream<DocumentSnapshot> getUserDatas () {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getUserDatas(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          UserModel user = UserModel.fromSnapshot(snapshot.data);
          
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.black, 
                  Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100 : Colors.grey
                ]
              )
            ),
            child: Column(
              children: [
                  ProfileCard(user: user),
                  const SizedBox(
                    height: 100.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    child: Container(
                      height: 53,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60),
                        borderRadius: BorderRadius.circular(100),                
                      ),                
                      child: Text('Edit profile',                
                        style: TextStyle(                
                          color: Colors.white.withOpacity(.8),                
                          fontSize: 15,                
                          fontWeight: FontWeight.bold
                        )
                      ),                
                    ),
                  ),
                  ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Internal error'));
        }

        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}
