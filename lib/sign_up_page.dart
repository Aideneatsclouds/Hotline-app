import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotline_app/main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Text controllers for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonenumberController = TextEditingController();

  // Role selection variable
  String selectedRole = 'citizen'; // Default to 'citizen'

  // Method to show error message using SnackBar
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Sign-up user method
  void signUpUser() async {
    try {
      // Create user in Firebase Auth
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Get the user UID
      String uid = userCredential.user!.uid;

      // Save user role to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': emailController.text,
        'role': selectedRole,
        'phone number':
            phonenumberController.text // Store the selected role in Firestore
      });

      // Navigate to the next page (e.g., home page or a role-based page)
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomePage()), // Replace with actual HomePage based on the role
      );
    } catch (e) {
      // Handle sign-up errors
      showErrorMessage('Error during sign-up. Please try again.');
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
              // Logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 50),
              // Welcome text
              const Text(
                'Create Account!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Email textfield
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Password textfield
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              //Phone number textfield
              TextField(
                controller: phonenumberController,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Role selection (Radio buttons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'citizen',
                        groupValue: selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                      const Text('Citizen'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'police',
                        groupValue: selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                      const Text('Police'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Sign up button
              ElevatedButton(
                onPressed: signUpUser,
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 50),
              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to the login page
                    },
                    child: const Text(
                      'Login here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
