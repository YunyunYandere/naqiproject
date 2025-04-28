import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

import 'help.dart';
import 'profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DatabaseReference databaseRef;
  double temperature = 0;
  double humidity = 0;
  bool isLoading = true;
  String errorMessage = '';

  final List<FlSpot> temperatureData = [];
  final List<FlSpot> humidityData = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    try {
      databaseRef = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://fir-auth-4a084-default-rtdb.asia-southeast1.firebasedatabase.app",
      ).ref();
      _initializeDatabase();
    } catch (e) {
      setState(() {
        errorMessage = "Initialization error: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  Future<void> _initializeDatabase() async {
    try {
      final snapshot = await databaseRef.child("sensor_data").get();
      if (snapshot.exists) {
        listenToSensorData();
      } else {
        setState(() {
          errorMessage = "No data found at 'sensor_data'";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Connection failed: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  void listenToSensorData() {
    databaseRef.child("sensor_data").onValue.listen((event) {
      final rawData = event.snapshot.value;
      if (rawData is Map) {
        setState(() {
          temperature = _parseDouble(rawData['temperature']);
          humidity = _parseDouble(rawData['humidity']);
          isLoading = false;

          _addDataToCharts();
        });
      } else {
        setState(() {
          errorMessage = "Unexpected data format.";
          isLoading = false;
        });
      }
    }, onError: (error) {
      setState(() {
        errorMessage = "Live data error: ${error.toString()}";
        isLoading = false;
      });
    });
  }

  double _parseDouble(dynamic value) {
    try {
      return double.tryParse(value.toString()) ?? 0;
    } catch (_) {
      return 0;
    }
  }

  void _addDataToCharts() {
    if (temperatureData.length >= 20) {
      temperatureData.removeAt(0);
      humidityData.removeAt(0);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch.toDouble();
    temperatureData.add(FlSpot(timestamp, temperature));
    humidityData.add(FlSpot(timestamp, humidity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportPage()));
          } else {
            setState(() => _currentIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return _buildDashboard();
  }

  Widget _buildDashboard() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(errorMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _initializeDatabase,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("🌱 Smart Farming Dashboard"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("📊 Live Sensor Data", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildSensorCards(),
          const SizedBox(height: 24),
          _buildChart("🌡 Temperature (°C)", Colors.orange, temperatureData),
          _buildChart("💧 Humidity (%)", Colors.blue, humidityData),
        ],
      ),
    );
  }

  Widget _buildSensorCards() {
    return Row(
      children: [
        _buildValueCard("🌡 Temp", "$temperature°C", Colors.orange),
        _buildValueCard("💧 Humidity", "$humidity%", Colors.blue),
      ],
    );
  }

  Widget _buildValueCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 8),
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(String title, Color color, List<FlSpot> data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.black12)),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data,
                      isCurved: true,
                      color: color,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: color.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
