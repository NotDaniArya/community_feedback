import 'package:community_feedback/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_state.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/add_note.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/sticky_note.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:community_feedback/utils/shared_widgets/pagination_bar.dart'; // Pastikan import ini ada
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // State untuk pagination
  int _currentPage = 1;
  final int _totalPages = 10; // Nanti bisa diambil dari API/Cubit

  @override
  void initState() {
    super.initState();
    // Memanggil data awal saat layar dibuka
    Future.microtask(() => context.read<NotesCubit>().fetchNotes());
  }

  void _onPageChanged(int newPage) {
    if (newPage < 1 || newPage > _totalPages) return;
    setState(() {
      _currentPage = newPage;
    });
    // TODO: Panggil fungsi fetch dengan page baru di Cubit
    // context.read<NotesCubit>().fetchNotes(page: newPage);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.backgroundColor,
        title: Text(
          'Feedback Notes',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // Opsional: Tombol refresh manual di AppBar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<NotesCubit>().fetchNotes(),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotesError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.scaffoldPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text('Terjadi Kesalahan', style: textTheme.titleMedium),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<NotesCubit>().fetchNotes(),
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is NotesLoaded) {
              if (state.notes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.note_alt_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada catatan.',
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<NotesCubit>().fetchNotes();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(TSizes.scaffoldPadding),
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    // Kita bungkus StickyNote dengan Center atau Align
                    // agar lebarnya tidak memaksa memenuhi layar jika StickyNote punya lebar tetap
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: TSizes.spaceBtwItems,
                        ),
                        child: StickyNote(note: note),
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      // Floating Action Button untuk menambah Note
      floatingActionButton: FloatingActionButton(
        heroTag: 'addNoteFab',
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          //   ),
          //   builder: (context) => const AddNote(),
          // );
        },
        backgroundColor: TColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      // Pagination Bar di bagian bawah
      bottomNavigationBar: PaginationBar(
        currentPage: _currentPage,
        totalPages: _totalPages,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
