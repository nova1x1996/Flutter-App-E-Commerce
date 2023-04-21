import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lab9_app_shopping/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthLogin extends StatelessWidget {
  static const routerName = "/authLogin";
  AuthLogin({super.key});

  final _emailText = TextEditingController();
  final _passText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void handleSubmit() {
      Provider.of<AuthProvider>(context, listen: false)
          .login(_emailText.text, _passText.text);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _emailText,
                decoration: InputDecoration(labelText: "Email"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  controller: _passText,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      handleSubmit();
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 19),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
