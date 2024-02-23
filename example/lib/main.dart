import 'package:flutter/material.dart';
import 'package:smart_edge_alert/smart_edge_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Edge Alert',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Smart Edge Alert'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                SmartEdgeAlert.show(
                  context,
                  title: 'Title',
                  description: 'Description',
                  gravity: SmartEdgeAlert.top,
                  closeButtonColor: Colors.white,
                  duration: SmartEdgeAlert.lengthVeryLong,
                );
              },
              child: const Text('Alert From Top'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                SmartEdgeAlert.show(context,
                    title: 'Title',
                    description: 'Description',
                    gravity: SmartEdgeAlert.bottom,
                    closeButtonColor: Colors.white,
                    duration: SmartEdgeAlert.lengthVeryLong);
              },
              child: const Text('Alert From Bottom'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                SmartEdgeAlert.show(context,
                    title: 'SUCCESS',
                    description: 'Description',
                    backgroundColor: Colors.green,
                    gravity: SmartEdgeAlert.top,
                    closeButtonColor: Colors.white,
                    duration: SmartEdgeAlert.lengthVeryLong);
              },
              child: const Text('Colorful Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                SmartEdgeAlert.show(context,
                    title: 'Title',
                    description:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s.',
                    backgroundColor: Colors.red,
                    gravity: SmartEdgeAlert.bottom,
                    closeButtonColor: Colors.white,
                    duration: SmartEdgeAlert.lengthVeryLong);
              },
              child: const Text('Long Description Alert'),
            ),
          ],
        ),
      ),
    );
  }
}
