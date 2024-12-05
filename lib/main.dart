// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotline_app/auth_page.dart';
import 'package:hotline_app/firebase_options.dart';
import 'package:hotline_app/info_page.dart';
import 'package:hotline_app/police_report_page.dart';
import 'package:hotline_app/profile_page.dart';
import 'package:hotline_app/report_page.dart'; // for logging out

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AuthPage(), // Starting point is AuthPage
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> updates = [];

  @override
  void initState() {
    super.initState();
    _fetchLiveUpdates();
  }

  // Fetch current user's location and police data
  Future<void> _fetchLiveUpdates() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get police data from Firestore (assuming collection is 'reports')
      QuerySnapshot policeReports =
          await FirebaseFirestore.instance.collection('reports').get();

      List<Map<String, dynamic>> fetchedUpdates = [];
      for (var doc in policeReports.docs) {
        String status = doc['status']; // Get status of report
        Timestamp timestamp = doc['timestamp']; // Get timestamp of report

        // Get police coordinates
        double lat1 = doc['lat1']; // Police latitude
        double long1 = doc['long1']; // Police longitude
        double lat2 = doc['latitude']; // Report latitude
        double long2 = doc['longitude']; // Report longitude

        String timeAgo = _timeAgo(timestamp);

        // Calculate distance between police and report
        double distance = _calculateDistance(lat1, long1, lat2, long2);

        print('Distance: $distance km');
        print('Coords: Police ($lat1, $long1), Report ($lat2, $long2)');

        if (status == 'accepted') {
          fetchedUpdates.add({
            'status':
                'Police accepted report ($timeAgo ago) - $distance km away',
            'timestamp': timestamp,
            'distance': distance,
          });
        } else {
          fetchedUpdates.add({
            'status':
                'Police report pending ($timeAgo ago) - $distance km away',
            'timestamp': timestamp,
            'distance': distance,
          });
        }
      }

      // Sort updates by timestamp in descending order (newest first)
      fetchedUpdates.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

      // Update the state with the sorted updates
      setState(() {
        updates = fetchedUpdates;
      });
    }
  }

  // Function to calculate the time difference
  String _timeAgo(Timestamp timestamp) {
    DateTime reportTime = timestamp.toDate();
    Duration diff = DateTime.now().difference(reportTime);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours';
    } else {
      return '${(diff.inDays)} days';
    }
  }

  // Function to calculate distance between two coordinates (in km)
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Earth radius in km

    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in km
  }

  // Helper function to convert degrees to radians
  double _degToRad(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(), // Sign out
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text('Hotline App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Live Update',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: updates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(updates[index]['status']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        onTap: (index) async {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          } else if (index == 1) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              DocumentSnapshot userDoc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();
              String role = userDoc['role'];
              if (role == 'citizen') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportPage()));
              } else if (role == 'police') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PoliceReportPage()));
              }
            }
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InfoPage()));
          }
        },
      ),
    );
  }
}
