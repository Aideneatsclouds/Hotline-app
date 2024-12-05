import 'package:flutter/material.dart';

class RoleSetupPage extends StatefulWidget {
  final String role; // Role passed from the ProfilePage

  const RoleSetupPage({super.key, required this.role});

  @override
  State<RoleSetupPage> createState() => _RoleSetupPageState();
}

class _RoleSetupPageState extends State<RoleSetupPage> {
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display role-based form
            if (widget.role == 'police') ...[
              const Text(
                'Police Profile Setup',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Police Officer Name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Police Badge ID',
                ),
              ),
            ] else if (widget.role == 'citizen') ...[
              const Text(
                'Citizen Profile Setup',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'Identification Number',
                ),
              ),
            ] else ...[
              const Text('No role selected yet.'),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save the profile information to Firestore
                // You could save the role-specific data here
                // For now, just show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile setup complete!')),
                );
              },
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
