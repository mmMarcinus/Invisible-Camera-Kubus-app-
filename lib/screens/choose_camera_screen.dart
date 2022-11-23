import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubus_app/screens/main_screen.dart';

double delay = 3;
void goToMainScren(
    CameraDescription camera, double delay, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainScreen(
            camera: camera,
            delay: delay,
          )));
}

class ChooseCameraScreen extends StatefulWidget {
  const ChooseCameraScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCameraScreen> createState() => _ChooseCameraScreenState();
}

class _ChooseCameraScreenState extends State<ChooseCameraScreen> {
  @override
  Widget build(BuildContext context) {
    List<CameraDescription> cameras = [];

    return Scaffold(
      backgroundColor: const Color(0xff252525),
      body: SafeArea(
        child: FutureBuilder(
            future: availableCameras().then((value) => cameras = value),
            builder: (ctx, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 100,
                        ),
                        const Center(child: Slider()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ElevatedButton(
                                onPressed: () =>
                                    goToMainScren(cameras[0], delay, context),
                                child: const Text('Tylnia')),
                            ElevatedButton(
                                onPressed: () =>
                                    goToMainScren(cameras[1], delay, context),
                                child: const Text('Przednia'))
                          ],
                        )
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
      ),
    );
  }
}

class Slider extends StatefulWidget {
  const Slider({Key? key}) : super(key: key);

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
    );
  }
}
