import 'package:flutter/material.dart';
import 'package:netflux/components/forms/register_form.dart';

import '../services/theme_builder.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Netflux'),
        actions: [
          IconButton(
            onPressed: () {
              ThemeBuilder.of(context)?.changeTheme();
            },
            icon: const Icon(Icons.dark_mode)
          )
        ],
      ),
      body: const SafeArea(
        child: RegisterForm(),
      ),
    );
  }
}