import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_instagram/Requests/authentication_services.dart';

import '../Components/inputField.dart';

import '../Views/register.dart';

class Model {
  String email;
  String password;

  Model({this.email = "", this.password = ""});
}

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(body: LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context
                        .read<AuthenticationService>()
                        .logIn(model.email, model.password);
                  }
                },
                child: Text('Log in'),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text('Sign up.'),
                  ),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
