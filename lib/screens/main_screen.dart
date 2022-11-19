import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class MainScreen extends StatefulWidget {
  final CameraDescription camera;
  const MainScreen({Key? key, required this.camera}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var cameras;
  XFile? image;
  File? fileImage;

  void takePicture() async {
    await Future.delayed(const Duration(seconds: 3));
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
      GallerySaver.saveImage(image!.path);
      //print('${directory.path}/$imageName');
      //print(localImage.path);

    } catch (err) {
      print(err);
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
      future: availableCameras().then((val) => cameras = val.first),
      builder: (ctx, snapshot) {
        return SafeArea(
          child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: takePicture,
            //   child: const Icon(Icons.camera_alt),
            // ),
            body: Column(
              children: <Widget>[
                if (image != null) Image.file(File(image!.path)),
                Center(
                  child: ElevatedButton(
                    onPressed: takePicture,
                    child: const Text('kubus'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
