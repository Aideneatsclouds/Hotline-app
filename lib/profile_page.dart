// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:hotline_app/role_setup_page.dart'; // Import logger package

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Create a Logger instance
  final logger = Logger();

  // User data (for demonstration purposes)
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  String role = '';
  String phonenumber = '';
  // Initialize role and phonenumber as empty

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  // Fetch the user's role and phone number from Firestore
  void _fetchUserRole() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        setState(() {
          // Safely accessing data using data()? to prevent null exceptions
          role = userDoc.data()?['role'] ?? '';
          phonenumber = userDoc.data()?['phone number'] ??
              ''; // Ensure field name is correct
        });
      } else {
        logger.e('User document does not exist.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User document does not exist')),
        );
      }
    } catch (e) {
      // Log the error for better troubleshooting
      logger.e('Error fetching role: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching user role')),
      );
    }
  }

  // Method to handle logout
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(
        context, '/login'); // Navigate to login page after sign-out
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display role if available
            Text(
              'Role: ${role.isEmpty ? 'Loading...' : role}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),

            const SizedBox(height: 20),

            // Display phone number if available
            Text(
              'Phone Number: ${phonenumber.isEmpty ? 'Loading...' : phonenumber}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),

            const SizedBox(height: 20),

            // Set up profile button - navigates to role-specific setup page
            ElevatedButton(
              onPressed: () {
                if (role.isNotEmpty) {
                  // Navigate to the role setup page based on the user's role
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoleSetupPage(role: role),
                    ),
                  );
                }
              },
              child: const Text('Set Up Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
