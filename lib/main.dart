import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kubus_app/screens/choose_camera_screen.dart';
import 'package:kubus_app/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // late CameraDescription camera = const CameraDescription(
  //     name: '', lensDirection: CameraLensDirection.front, sensorOrientation: 1);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx, snapshot) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const ChooseCameraScreen(),
      );
    });
  }
}
