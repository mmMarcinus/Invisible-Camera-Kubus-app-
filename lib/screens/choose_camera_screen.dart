import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kubus_app/screens/main_screen.dart';

class ChooseCameraScreen extends StatelessWidget {
  const ChooseCameraScreen({Key? key}) : super(key: key);

  void goToMainScren(CameraDescription camera, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MainScreen(
              camera: camera,
            )));
  }

  @override
  Widget build(BuildContext context) {
    List<CameraDescription> cameras = [];
    return Scaffold(
      body: FutureBuilder(
          future: availableCameras().then((value) => cameras = value),
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? Column(
                    children: <Widget>[
                      Expanded(
                          child: ElevatedButton(
                        child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text('Przednia',
                                    style: TextStyle(fontSize: 40)))),
                        onPressed: () => goToMainScren(cameras[0], context),
                      )),
                      const Divider(),
                      Expanded(
                          child: ElevatedButton(
                        child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              'Tylnia',
                              style: TextStyle(fontSize: 40),
                            ))),
                        onPressed: () => goToMainScren(cameras[1], context),
                      ))
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
