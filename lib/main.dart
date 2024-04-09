import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SensorApp(),
    );
  }
}

class SensorApp extends StatelessWidget {
  const SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 가로모드 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    final centerX = MediaQuery.of(context).size.width / 2 - 50;
    final centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<AccelerometerEvent>(
              stream: accelerometerEventStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // data가 없는 경우 로딩표시
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final event = snapshot.data!;
                // x, y, z의 의미는 센서마다 달라서 문서를 보고 파악해야함
                List<double> accelerometerValues = [event.x, event.y, event.z];
                print(accelerometerValues);

                return Positioned(
                  left: centerX,
                  top: centerY,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    width: 100,
                    height: 100,
                  ),
                );
              })
        ],
      ),
    );
  }
}
