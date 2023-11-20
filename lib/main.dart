import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mobile Data Switcher',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      MethodChannel('com.example.mobile_data_switcher/network_settings');

  Future<void> _openNetworkSettings() async {
    // Capture the ScaffoldMessenger at the top of the method to ensure it's available later.
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await platform.invokeMethod('openNetworkSettings');
    } on PlatformException catch (e) {
      // Use the captured ScaffoldMessenger to show a Snackbar.
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Failed to open network settings: ${e.message}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Data Switcher'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openNetworkSettings,
          child: const Text('Open Network Settings'),
        ),
      ),
    );
  }
}
