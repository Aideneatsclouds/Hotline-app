// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class PoliceReportPage extends StatelessWidget {
  // For the sake of this example, we're using a fixed officer ID.
  // Replace this with current officer's ID from Firebase Authentication.
  final String officerId = 'officer123';

  const PoliceReportPage({super.key}); // Replace with current officer's ID

  // Method to handle accepting a report and getting the police coordinates
  Future<void> _acceptReport(
      BuildContext context, String reportId, String officerId) async {
    try {
      // Get the current user's position (police officer)
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double lat1 = position.latitude;
      double long1 = position.longitude;

      // Update the report's status and store police coordinates in Firestore
      await FirebaseFirestore.instance
          .collection('reports')
          .doc(reportId)
          .update({
        'status': 'accepted',
        'acceptedBy': officerId,
        'lat1': lat1, // Police latitude
        'long1': long1, // Police longitude
      });

      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report accepted successfully!')),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Reports'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reports') // Correct collection name
            .orderBy('timestamp',
                descending: true) // Sort by timestamp (most recent first)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final reports = snapshot.data!.docs;

          if (reports.isEmpty) {
            return const Center(child: Text("No reports available"));
          }

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              final details = report['details'];
              final timestamp = (report['timestamp'] as Timestamp).toDate();
              final latitude = report['latitude'];
              final longitude = report['longitude'];
              final status = report['status'];
              final reportId = report.id;

              // Change the color based on the report status
              final cardColor =
                  status == 'accepted' ? Colors.lightGreen : Colors.grey[300];

              return Card(
                color: cardColor,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Report'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Details: $details'),
                      const SizedBox(height: 5),
                      Text('Submitted at: ${timestamp.toLocal()}'),
                      const SizedBox(height: 5),
                      Text('Coordinates: ($latitude, $longitude)'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.check_circle),
                    onPressed: () {
                      // Handle the report acceptance
                      _acceptReport(context, reportId, officerId);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
