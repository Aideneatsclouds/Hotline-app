import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotline_app/MyTextField.dart';
import 'package:hotline_app/my_button.dart';
import 'package:hotline_app/sign_up_page.dart'; // Ensure you import the SignUpPage file

class LoginCitizen extends StatefulWidget {
  const LoginCitizen({super.key});

  @override
  State<LoginCitizen> createState() => _LoginCitizenState();
}

class _LoginCitizenState extends State<LoginCitizen> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Method to show a generic error message using SnackBar
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Sign user in method
  void signUserIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );

    try {
      // Attempt to sign in with the provided email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If successful, pop loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException {
      // Pop loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      // Show generic error message
      showErrorMessage('An error occurred. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back!
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Enter Email',
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Enter Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),
              const SizedBox(height: 50),

              // GestureDetector to navigate to the sign-up page
              GestureDetector(
                onTap: () {
                  // Navigate to sign-up page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SignUpPage()), // Replace 'SignUpPage' with your actual sign-up page class name
                  );
                },
                child: const Text(
                  'Don\'t have an account? Register now.',
                  style: TextStyle(color: Color.fromARGB(255, 70, 104, 216)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
