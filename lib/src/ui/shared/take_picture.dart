import 'dart:io';

import 'package:base_flutter/src/ui/shared/dialog.dart';
import 'package:base_flutter/src/ui/styles/colors.dart';
import 'package:base_flutter/src/ui/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class TakePicture {
  BuildContext context;
  Function(File?) onSuccess;

  TakePicture({
    required this.context,
    required this.onSuccess,
  });
  void take() {
    showDialogBottom(
      context: context,
      content: TakePictureDialog(
        onSelected: (source) async {
          Navigator.pop(context);
          if (source == ImageSource.gallery) {
            _checkPermissionGallery();
          } else if (source == ImageSource.camera) {
            _checkPermissionCamera();
          }
        },
      ),
    );
  }

  void _checkPermissionGallery() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    PermissionStatus checkPermission = sdkInt >= 33
        ? await Permission.photos.request()
        : await Permission.storage.request();

    if (checkPermission.isGranted) {
      _openImagePicker(ImageSource.gallery);
    } else {
      if (checkPermission.isGranted) {
        _openImagePicker(ImageSource.gallery);
      } else if (checkPermission.isPermanentlyDenied) {
        _showPermissionDialog(ImageSource.gallery);
      }
    }
  }

  void _checkPermissionCamera() async {
    if (await Permission.camera.request().isGranted) {
      _openImagePicker(ImageSource.camera);
    } else {
      if (await Permission.camera.request().isGranted) {
        _openImagePicker(ImageSource.camera);
      } else if (await Permission.camera.request().isPermanentlyDenied) {
        _showPermissionDialog(ImageSource.camera);
      }
    }
  }

  Future<void> _showPermissionDialog(ImageSource source) async {
    await showDialog(
      context: context,
      builder: (_context) {
        final brightness = Theme.of(context).brightness;
        return AlertDialog(
          title: Text(
            source == ImageSource.camera
                ? "dialog.title_permission_camera".tr()
                : "dialog.title_permission_camera".tr(),
            style: AppTextStyle.boldStyle.copyWith(
              fontSize: 16,
              color: brightness == Brightness.dark ? textColor2 : textColor,
            ),
          ),
          content: Text(
              source == ImageSource.camera
                  ? "dialog.message_permission_camera".tr()
                  : "dialog.message_permission_camera".tr(),
              style: AppTextStyle.regularStyle.copyWith(
                fontSize: 16,
                color: brightness == Brightness.dark ? textColor2 : textColor,
              )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("dialog.cancel".tr()),
            ),
            SizedBox(width: 4),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _openImagePicker(ImageSource source) {
    ImagePicker().pickImage(source: source).then((value) {
      if (value != null) {
        _cropImage(context, value.path);
      }
    }).catchError((e) {
      print(e);
    });
  }

  void _cropImage(BuildContext context, String path) {
    final settings = [
      AndroidUiSettings(
        activeControlsWidgetColor: primary,
        toolbarWidgetColor: primary,
        toolbarColor: backgroundColor,
        initAspectRatio: CropAspectRatioPreset.ratio4x3,
        // lockAspectRatio: false,
      ),
    ];
    ImageCropper().cropImage(
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      compressQuality: 50,
      sourcePath: path,
      maxWidth: 1080,
      maxHeight: 1080,
      uiSettings: settings,
    ).then((value) {
      if (value != null) {
        final theFile = File(value.path);
        onSuccess(theFile);
      }
    });
  }
}

class TakePictureDialog extends StatelessWidget {
  final Function(ImageSource) onSelected;
  const TakePictureDialog({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Center(
            child: Text(
              "Ambil Gambar",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.boldStyle.copyWith(
                  fontSize: 16,
                  color:
                      brightness == Brightness.dark ? textColor2 : textColor),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => onSelected(ImageSource.camera),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera,
                    size: 16,
                    color:
                        brightness == Brightness.dark ? textColor2 : textColor),
                SizedBox(width: 10),
                Text("Kamera",
                    style: AppTextStyle.regularStyle.copyWith(
                        fontSize: 16,
                        color: brightness == Brightness.dark
                            ? textColor2
                            : textColor)),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => onSelected(ImageSource.gallery),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.photo,
                    size: 16,
                    color:
                        brightness == Brightness.dark ? textColor2 : textColor),
                SizedBox(width: 10),
                Text("Galeri",
                    style: AppTextStyle.regularStyle.copyWith(
                        fontSize: 16,
                        color: brightness == Brightness.dark
                            ? textColor2
                            : textColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
