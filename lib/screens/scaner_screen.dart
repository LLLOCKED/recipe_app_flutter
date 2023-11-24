import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/screens/picture_screen.dart';
import 'package:recipe_app/widgets/top_bar.dart';

import '../main.dart';
import '../providers/vision_provider.dart';

class ScanerScreen extends StatefulWidget {
  const ScanerScreen({super.key});

  @override
  State<ScanerScreen> createState() => _ScanerScreenState();
}

class _ScanerScreenState extends State<ScanerScreen> {
  CameraController? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _isCameraInitialized
          ? Stack(children: [
              Container(
                child: controller!.buildPreview(),
              ),
              Positioned(
                  top: 30.h,
                  left: 10.w,
                  right: 10.w,
                  child: TopBar(
                    controller: controller,
                    title: "Scanner",
                    rightIcon: true,
                  )),
              Padding(
                padding: const EdgeInsets.all(20).r,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 3, color: Colors.black26),
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () async {
                      try {
                        _isCameraInitialized;

                        final image = await controller?.takePicture();

                        if (!mounted) return;

                        final scanResult =
                            await visionImage(file: File(image!.path));

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PictureScreen(
                              imagePath: image.path,
                              scanResult: scanResult,
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              )
            ])
          : Container(),
    );
  }
}
