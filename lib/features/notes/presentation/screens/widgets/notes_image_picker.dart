import 'dart:io';

import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class NotesImagePicker extends StatefulWidget {
  const NotesImagePicker({super.key, required this.onImageSelected});

  final void Function(File? image) onImageSelected;

  @override
  State<NotesImagePicker> createState() => _NotesImagePickerState();
}

class _NotesImagePickerState extends State<NotesImagePicker> {
  File? _pickedImageFile;

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (pickedImage == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Sesuaikan Gambar',
          toolbarColor: TColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile == null) return;

    setState(() {
      _pickedImageFile = File(croppedFile.path);
    });

    widget.onImageSelected(_pickedImageFile!);
  }

  void _showImagesourceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsetsGeometry.all(TSizes.mediumSpace),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        _pickedImageFile != null
            ? Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(_pickedImageFile!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonRadiusEight(
                        textTheme,
                        bgColor: Colors.white,
                        textColor: TColors.secondaryText,
                        child: [
                          const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            size: 25,
                            color: TColors.secondaryText,
                          ),
                          const SizedBox(width: TSizes.smallSpace),
                          Text(
                            'Ganti',
                            style: textTheme.bodyLarge!.copyWith(
                              color: TColors.secondaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        onPressed: () {
                          _showImagesourceSheet(context);
                        },
                      ),
                      const SizedBox(width: TSizes.mediumSpace),
                      ButtonRadiusEight(
                        textTheme,
                        bgColor: Colors.red,
                        textColor: Colors.white,
                        child: [
                          Text(
                            'Hapus',
                            style: textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        onPressed: () {
                          setState(() {
                            _pickedImageFile = null;
                          });
                          widget.onImageSelected(null);
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/pick_image.png'),
                  const SizedBox(height: TSizes.smallSpace),
                  Text(
                    'Ketuk untuk unggah atau ambil foto',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TSizes.smallSpace),
                  Text(
                    'Format yang didukung: JPG, PNG Kurang dari 2 MB.',
                    style: textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.smallSpace),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonRadiusEight(
                        textTheme,
                        child: [
                          const Icon(Icons.file_upload_outlined, size: 25),
                          const SizedBox(width: TSizes.smallSpace),
                          Text(
                            'Pilih Foto',
                            style: textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        bgColor: TColors.primaryColor,
                        textColor: Colors.white,
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                      const SizedBox(width: TSizes.mediumSpace),
                      ButtonRadiusEight(
                        textTheme,
                        child: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            size: 25,
                            color: TColors.secondaryText,
                          ),
                          const SizedBox(width: TSizes.smallSpace),
                          Text(
                            'Ambil Foto',
                            style: textTheme.bodyLarge!.copyWith(
                              color: TColors.secondaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        bgColor: Colors.white,
                        textColor: TColors.secondaryText,
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }
}
