import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
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
  late XFile? _image = null;
  bool _isCameraInitialized = false;
  bool scanning = false;

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

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _isCameraInitialized
          ? Stack(children: [
              _image != null
                  ? Container(
                      height: 1.sh,
                      child: Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
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
                padding: EdgeInsets.all(20.r),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.black26),
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () async {
                      try {
                        _isCameraInitialized;

                        setState(() {
                          scanning = true;
                        });

                        final image = await controller?.takePicture();

                        if (!mounted) return;

                        final scanResult = await visionImage(
                            file: _image != null
                                ? File(_image!.path)
                                : File(image!.path));

                        setState(() {
                          scanning = false;
                        });

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PictureScreen(
                              imagePath:
                                  _image != null ? _image!.path : image!.path,
                              scanResult: scanResult,
                            ),
                          ),
                        );
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.black26),
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: _getImage,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                ),
              ),
              scanning
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container()
            ])
          : Container(),
    );
  }
}
