import 'package:community_feedback/features/notes/presentation/providers/note_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/constant/sizes.dart';
import '../../../../../utils/shared_widgets/button.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({super.key});

  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final _formKey = GlobalKey<FormState>();
  final _noteContentController = TextEditingController();

  @override
  void dispose() {
    _noteContentController.dispose();
    super.dispose();
  }

  void _submitNote() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    ref
        .read(noteNotifierProvider.notifier)
        .addNote(_noteContentController.text.trim());

    Navigator.pop(context);
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
              Text('Note Baru', style: textTheme.titleMedium),
              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                controller: _noteContentController,
                decoration: const InputDecoration(
                  labelText: 'Isi Note',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                minLines: 2,
                maxLines: 3,
                maxLength: 200,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Note tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: MyButton(
                  onPressed: _submitNote,
                  text: const Text(
                    'Unggah',
                    style: TextStyle(color: Colors.white),
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
