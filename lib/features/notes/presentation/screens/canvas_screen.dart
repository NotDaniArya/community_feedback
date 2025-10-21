import 'package:community_feedback/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_state.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/sticky_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note_entity.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final TransformationController _transformationController =
      TransformationController();

  static const double _canvasWidth = 1000.0;
  static const double _canvasHeight = 1000.0;

  bool _isDraggingNote = false;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _setDragging(bool dragging) {
    setState(() {
      _isDraggingNote = dragging;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sticky Notes Canvas'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotesLoaded) {
            return InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: !_isDraggingNote,
              scaleEnabled: !_isDraggingNote,
              boundaryMargin: const EdgeInsets.only(
                right: 1000,
                bottom: 1000,
                left: 100,
                top: 100,
              ),
              minScale: 0.5,
              maxScale: 5,
              clipBehavior: Clip.none,
              child: SizedBox(
                width: _canvasWidth,
                height: _canvasHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: state.notes.map((note) {
                    return DraggableStickyNote(
                      key: ValueKey(note.id),
                      note: note,
                      transformationController: _transformationController,
                      onDragStart: () {
                        context.read<NotesCubit>().bringToFront(note.id);
                        _setDragging(true);
                      },
                      onDragEnd: () => _setDragging(false),
                      onPositionUpdate: (newPosition) {
                        context.read<NotesCubit>().updateNotePosition(
                          note.id,
                          newPosition,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          }
          if (state is NotesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(
            child: Text('Ketuk tombol + untuk menambah catatan!'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final viewportMatrix = _transformationController.value;
          final screenCenter = Offset(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2,
          );
          final canvasCenter = MatrixUtils.transformPoint(
            Matrix4.inverted(viewportMatrix),
            screenCenter,
          );

          context.read<NotesCubit>().addNote(initialPosition: canvasCenter);
        },
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DraggableStickyNote extends StatefulWidget {
  final NoteEntity note;
  final TransformationController transformationController;
  final VoidCallback onDragStart;
  final VoidCallback onDragEnd;
  final Function(Offset) onPositionUpdate;

  const DraggableStickyNote({
    super.key,
    required this.note,
    required this.transformationController,
    required this.onDragStart,
    required this.onDragEnd,
    required this.onPositionUpdate,
  });

  @override
  State<DraggableStickyNote> createState() => _DraggableStickyNoteState();
}

class _DraggableStickyNoteState extends State<DraggableStickyNote> {
  late Offset _currentPosition;
  Offset _startDragPosition = Offset.zero;
  Offset _cumulativeDelta = Offset.zero;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.note.position;
  }

  @override
  void didUpdateWidget(DraggableStickyNote oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isDragging && oldWidget.note.position != widget.note.position) {
      _currentPosition = widget.note.position;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _currentPosition.dx,
      top: _currentPosition.dy,
      child: GestureDetector(
        onPanStart: (details) {
          widget.onDragStart();
          setState(() {
            _isDragging = true;
            _startDragPosition = _currentPosition;
            _cumulativeDelta = Offset.zero;
          });
        },
        onPanUpdate: (details) {
          final matrix = widget.transformationController.value;
          final scale = matrix.getMaxScaleOnAxis();

          final canvasDelta = details.delta / scale;

          setState(() {
            _cumulativeDelta += canvasDelta;
            _currentPosition = _startDragPosition + _cumulativeDelta;

            _currentPosition = Offset(
              _currentPosition.dx.clamp(0, 1000),
              _currentPosition.dy.clamp(0, 1000),
            );
          });
        },
        onPanEnd: (details) {
          widget.onDragEnd();
          setState(() {
            _isDragging = false;
          });
          widget.onPositionUpdate(_currentPosition);
        },
        onPanCancel: () {
          widget.onDragEnd();
          setState(() {
            _isDragging = false;
            _currentPosition = widget.note.position;
          });
        },
        child: Opacity(
          opacity: _isDragging ? 0.7 : 1.0,
          child: StickyNote(note: widget.note),
        ),
      ),
    );
  }
}
