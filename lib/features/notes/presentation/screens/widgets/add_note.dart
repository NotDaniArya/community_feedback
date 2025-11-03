import 'dart:io';

import 'package:community_feedback/features/notes/presentation/screens/widgets/notes_image_picker.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/helper_functions/helper.dart';
import 'package:community_feedback/utils/shared_widgets/button_radius_eight.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/shared_widgets/button.dart';
import '../../cubit/notes_cubit.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();
  final _noteContentController = TextEditingController();
  final _noteTitleController = TextEditingController();
  late Color _selectedColor;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedColor = TColors.pastelColors[0];
  }

  @override
  void dispose() {
    _noteContentController.dispose();
    _noteTitleController.dispose();
    super.dispose();
  }

  void _submitNote() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    try {
      await context.read<NotesCubit>().addNote(
        noteTitle: _noteTitleController.text.trim(),
        noteContent: _noteContentController.text.trim(),
        color: _selectedColor,
      );

      if (!mounted) return;
      Navigator.pop(context);
      MyHelperFunction.showToast(
        context,
        'Succes',
        'Your notes are now on canvas',
        ToastificationType.success,
      );
    } catch (e) {
      if (!mounted) return;

      MyHelperFunction.showToast(
        context,
        e.toString().replaceFirst('Exception: ', ''),
        'Your notes have an error',
        ToastificationType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.backgroundColor,
        centerTitle: true,

        title: Text(
          'Add New Feedback',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.scaffoldPadding).copyWith(
            bottom:
                MediaQuery.of(context).viewInsets.bottom + TSizes.mediumSpace,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Title',
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                TextFormField(
                  controller: _noteTitleController,
                  decoration: const InputDecoration(
                    hintText: 'Add title...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  minLines: 1,
                  maxLines: 2,
                  maxLength: 80,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Note title cannot be empty!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description',
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                TextFormField(
                  controller: _noteContentController,
                  decoration: const InputDecoration(
                    hintText: 'Write your feedback...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  minLines: 5,
                  maxLines: 5,
                  maxLength: 250,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Note description cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image',
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.smallSpace),
                SizedBox(
                  width: double.infinity,
                  child: DottedBorder(
                    options: const RoundedRectDottedBorderOptions(
                      radius: Radius.circular(10),
                      color: Color(0xFFB2B2B2),
                      dashPattern: [10, 10],
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: NotesImagePicker(onImageSelected: (image) {}),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: TColors.pastelColors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedColor == color
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: ButtonRadiusEight(
                    textTheme,
                    textColor: Colors.white,
                    child: [
                      Text(
                        'Add to Canvas',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    bgColor: TColors.primaryColor,
                    onPressed: _submitNote,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
