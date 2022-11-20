import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class MainScreen extends StatefulWidget {
  final CameraDescription camera;
  const MainScreen({Key? key, required this.camera}) : super(key: key);
  static const routeName = 'main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var cameras;
  XFile? image;
  File? fileImage;
  double delay = 3.0;
  void takePicture() async {
    try {
      await _initializeControllerFuture;
      image = await _controller.takePicture();
      final Directory directory =
          // ignore: await_only_futures
          await syspaths.getApplicationDocumentsDirectory();
      setState(() {
        fileImage = File(image!.path);
      });

      final imageName = basename(fileImage!.path);
      await File(image!.path).copy('${directory.path}/$imageName');
      GallerySaver.saveImage(image!.path, albumName: 'KUBUS');
    } catch (err) {
      print(err);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras().then((val) => cameras = val),
      builder: (ctx, snapshot) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xff252525),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (image != null) Image.file(File(image!.path)),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await Future.delayed(Duration(seconds: delay.round()));
                      takePicture();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60, 90)),
                    child: const Text('kubus'),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Ustaw opóźnienie: ${delay.round()}s',
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 300,
                      child: CupertinoSlider(
                          value: delay,
                          min: 1,
                          max: 10,
                          divisions: 10,
                          onChanged: (val) {
                            setState(() {
                              delay = val;
                            });
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
