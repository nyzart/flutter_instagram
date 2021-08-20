import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_instagram/Requests/authentication_services.dart';

import '../Components/inputField.dart';

import '../Views/login.dart';

class Model {
  String name;
  String username;
  String email;
  String password;
  String biography;

  Model(
      {this.name = "",
      this.username = "",
      this.email = "",
      this.password = "",
      this.biography = ""});
}

class RegisterPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(body: RegisterForm());
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            InputField(
              type: 'name',
              icon: Icons.badge,
              onSaved: (value) {
                model.name = value;
              },
            ),
            SizedBox(height: 25.0),
            InputField(
              type: 'username',
              icon: Icons.account_box,
              onSaved: (value) {
                model.username = value;
              },
            ),
            SizedBox(height: 25.0),
            InputField(
              type: 'email',
              icon: Icons.email,
              onSaved: (value) {
                model.email = value;
              },
            ),
            SizedBox(height: 25.0),
            InputField(
              type: 'password',
              icon: Icons.lock,
              onSaved: (value) {
                model.password = value;
              },
            ),
            SizedBox(height: 25.0),
            InputField(
              type: 'biography',
              icon: Icons.description,
              multiline: true,
              onSaved: (value) {
                model.biography = value;
              },
            ),
            SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthenticationService>().signUp(
                        model.name,
                        model.username,
                        model.email,
                        model.password,
                        model.biography);
                    Navigator.pop(context);
                  }
                },
                child: Text('Sign up'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Sign in.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
