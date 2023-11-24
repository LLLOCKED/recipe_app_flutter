import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/app_icon.dart';
import 'package:recipe_app/widgets/medium_text.dart';
import 'package:camera/camera.dart';

class TopBar extends StatefulWidget {
  final String title;
  final bool rightIcon;
  final CameraController? controller;

  const TopBar(
      {super.key,
      required this.title,
      required this.rightIcon,
      this.controller});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  FlashMode _currentFlashMode = FlashMode.off;

  void toggleFlashMode() {
    setState(() {
      switch (_currentFlashMode) {
        case FlashMode.off:
          _currentFlashMode = FlashMode.always;
          break;
        case FlashMode.always:
          _currentFlashMode = FlashMode.auto;
          break;
        case FlashMode.auto:
          _currentFlashMode = FlashMode.off;
          break;
        default:
          break;
      }
      widget.controller?.setFlashMode(_currentFlashMode);
    });
  }

  IconData getFlashModeIcon() {
    switch (_currentFlashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.auto:
        return Icons.flash_auto;
      default:
        return Icons.flash_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
      width: 1.sw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIcon(
            icon: Icons.arrow_back_ios_sharp,
            opacity: 0.4,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4)),
                child: Center(
                    child: MediumText(
                  text: widget.title,
                  color: Colors.white,
                ))),
          ),
          widget.rightIcon
              ? Row(children: [
                  SizedBox(width: 15.w),
                  AppIcon(
                    icon: getFlashModeIcon(),
                    opacity: 0.4,
                    onPressed: () {
                      toggleFlashMode();
                    },
                  )
                ])
              : const SizedBox()
        ],
      ),
    );
  }
}
