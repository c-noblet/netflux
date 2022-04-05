import 'package:flutter/material.dart';

import '../../models/user_model.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(widget.user.image),
        Text(widget.user.firstname),
        Text(widget.user.lastname),
        Text(widget.user.birthdate),
        Text(widget.user.country),
        Text(widget.user.city)
      ],
    );
  }
}
