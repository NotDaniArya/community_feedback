import 'dart:io';

import 'package:community_feedback/features/notes/presentation/screens/widgets/notes_image_picker.dart';
import 'package:community_feedback/utils/constant/colors.dart';
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

      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: const Text('Sukses'),
        alignment: Alignment.bottomRight,
        autoCloseDuration: const Duration(seconds: 5),
        icon: const Icon(Icons.check),
      );
    } catch (e) {
      if (!mounted) return;
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: Text(e.toString().replaceFirst('Exception: ', '')),
        alignment: Alignment.bottomRight,
        autoCloseDuration: const Duration(seconds: 5),
        icon: const Icon(Icons.check),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.scaffoldPadding).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + TSizes.mediumSpace,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              Text('Add New Feedback', style: textTheme.titleMedium),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
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
              SizedBox(
                width: double.infinity,
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
              NotesImagePicker(
                onImageSelected: (image) {
                  setState(() {
                    _selectedImage = image;
                  });
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text('Pilih warna sticky notes', style: textTheme.labelSmall),
              const SizedBox(height: TSizes.smallSpace),
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
                child: MyButton(
                  onPressed: _submitNote,
                  text:  Text(
                    'Add to Canvas',
                    style: textTheme.bodyLarge !.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
