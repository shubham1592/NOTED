import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noted/controller/google_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 180.0,
                    left: 48.0,
                ),
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/edit.png"),
                  ),
                ),
              ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              child: Text(
                "Create and Manage your Notes\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "lato",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
              ),
              child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Continue With",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "lato",
                      ),
                    ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      //
                      Image.asset(
                        'assets/images/google.png',
                        height: 28.0,
                      ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[700],
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 12,
                    ))),
              ),
            ),
            const SizedBox(
              height: 220.0,
            ),
          ],
        ),

      ),
    );
  }
}
