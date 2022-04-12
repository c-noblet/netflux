import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String email = FirebaseAuth.instance.currentUser?.email ?? '';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350.0,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                    color: Colors.white
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.user.image),
                  fit: BoxFit.cover
                ),
              ),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              widget.user.firstname + ' ' + widget.user.lastname,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade700,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.event,
                            color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade500 : Colors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.user.birthdate,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade500 : Colors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.user.country,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            Icons.domain,
                            color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade500 : Colors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.user.city,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
  );
  }
}
