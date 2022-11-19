import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kubus_app/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // // This widget is the root of your application.
  // late CameraDescription camera = const CameraDescription(
  //     name: '', lensDirection: CameraLensDirection.front, sensorOrientation: 1);
  @override
  Widget build(BuildContext context) {
    late CameraDescription camera;
    return FutureBuilder(
        future: availableCameras().then((value) => camera = value.first),
        builder: (ctx, snapshot) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.purple,
              ),
              home: snapshot.connectionState == ConnectionState.done
                  ? MainScreen(
                      camera: camera,
                    )
                  : Container());
        });
  }
}
