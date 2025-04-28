import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Developer Profile"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4F0CD9), Color(0xFF1F2E00), Color(0xFFFFDEB4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Naqiudin Nabil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Diploma in Electronic Engineering",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                _buildGlassCard(
                  title: "My Info",
                  icon: Icons.person_outline,
                  content:
                  "placeholder",
                ),
                _buildGlassCard(
                  title: "Contact",
                  icon: Icons.email_outlined,
                  content: "nabilnaqiuddin570@gmail.com\nPhone: 01111585793",
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({
    required String title,
    IconData? icon,
    String? content,
    List<Widget>? children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(icon, color: Colors.black, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (content != null)
            Text(
              content,
              style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
            ),
          if (children != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
                  .map((widget) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                  child: widget,
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}