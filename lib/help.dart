import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              "FAQ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const ExpansionTile(
              title: Text("How to use the dashboard?"),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Go to Dashboard page to see live sensor data and control irrigation.",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Currently unavailble due to error code.",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const ExpansionTile(
              title: Text("Can I monitor remotely?"),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Yes, the app uses IoT to fetch live sensor data from the field.",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Currently unavailble due to error code.",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}