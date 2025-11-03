import 'package:community_feedback/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_state.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/sticky_note.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note_entity.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TransformationController _transformationController =
      TransformationController();

  static const double _canvasWidth = 3000.0;
  static const double _canvasHeight = 3000.0;

  bool _isDraggingNote = false;

  late int _currentScalePercent;

  @override
  void initState() {
    super.initState();

    _currentScalePercent = 100;
    _transformationController.addListener(_onScaleUpdate);
  }

  void _onScaleUpdate() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    final newPercent = (scale * 100).round();

    if (newPercent != _currentScalePercent) {
      setState(() {
        _currentScalePercent = newPercent;
      });
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _transformationController.removeListener(_onScaleUpdate);
    super.dispose();
  }

  void _setDragging(bool dragging) {
    setState(() {
      _isDraggingNote = dragging;
    });
  }

  void _zoomIn() {
    const double maxScale = 2.0;
    const double scaleFactor = 1.2;

    // Get current scale from transformation matrix
    final currentScale = _transformationController.value.getMaxScaleOnAxis();

    // Calculate new scale after zoom in
    final newScale = currentScale * scaleFactor;

    // Check if new scale exceeds maximum
    if (newScale > maxScale) {
      // If already at or above max, don't zoom further
      if (currentScale >= maxScale) {
        return;
      }
      // Limit to max scale
      final limitedScaleFactor = maxScale / currentScale;
      _applyZoom(limitedScaleFactor);
    } else {
      _applyZoom(scaleFactor);
    }
  }

  void _zoomOut() {
    const double minScale = 0.8;
    const double scaleFactor = 0.8;

    // Get current scale from transformation matrix
    final currentScale = _transformationController.value.getMaxScaleOnAxis();

    // Calculate new scale after zoom out
    final newScale = currentScale * scaleFactor;

    // Check if new scale goes below minimum
    if (newScale < minScale) {
      // If already at or below min, don't zoom further
      if (currentScale <= minScale) {
        return;
      }
      // Limit to min scale
      final limitedScaleFactor = minScale / currentScale;
      _applyZoom(limitedScaleFactor);
    } else {
      _applyZoom(scaleFactor);
    }
  }

  /// Helper method to apply zoom transformation
  void _applyZoom(double scaleFactor) {
    final screenCenter = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );

    final canvasFocus = MatrixUtils.transformPoint(
      Matrix4.inverted(_transformationController.value),
      screenCenter,
    );

    final newMatrix = _transformationController.value.clone()
      ..translate(canvasFocus.dx, canvasFocus.dy)
      ..scale(scaleFactor)
      ..translate(-canvasFocus.dx, -canvasFocus.dy);

    _transformationController.value = newMatrix;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: Stack(
        children: [
          BlocBuilder<NotesCubit, NotesState>(
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
                    right: 2650,
                    bottom: 2400,
                    left: 50,
                    top: 50,
                  ),
                  minScale: 0.5,
                  maxScale: 5,
                  clipBehavior: Clip.none,
                  child: SizedBox(
                    width: _canvasWidth,
                    height: _canvasHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Dotted background pattern - covers entire canvas
                        Positioned.fill(
                          child: CustomPaint(
                            painter: DottedPatternPainter(
                              canvasWidth: _canvasWidth,
                              canvasHeight: _canvasHeight,
                            ),
                          ),
                        ),
                        // Notes on top
                        ...state.notes.map((note) {
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
                        }),
                      ],
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

          // fab
          Positioned(
            bottom: 165.0, // Memberi jarak dari bottom nav bar (jika ada)
            right: 16.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // fab persentase scale
                _buildZoomIndicator(heroTag: 'scalePercentage'),

                // fab zoom in
                _buildFabClusterButton(
                  heroTag: 'zoomInFab',
                  icon: const Icon(Icons.zoom_in, size: 30),
                  onPressed: _zoomIn,
                ),

                // fab zoom out
                _buildFabClusterButton(
                  heroTag: 'zoomOutFab',
                  icon: const Icon(Icons.zoom_out, size: 30),
                  onPressed: _zoomOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoomIndicator({required String heroTag}) {
    final textTheme = Theme.of(context).textTheme;

    return FloatingActionButton.small(
      heroTag: heroTag,
      onPressed: null,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: TColors.primaryColor,
      foregroundColor: Colors.white,
      child: Center(
        child: Text(
          '$_currentScalePercent%',
          style: textTheme.labelMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Helper widget untuk membuat tombol FAB yang lebih kecil dan konsisten
  Widget _buildFabClusterButton({
    required String heroTag,
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton.small(
      heroTag: heroTag,
      onPressed: onPressed,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: TColors.primaryColor,
      foregroundColor: Colors.white,
      child: icon,
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

// Custom Painter for dotted pattern background
class DottedPatternPainter extends CustomPainter {
  final double canvasWidth;
  final double canvasHeight;

  static const double _dotSpacing = 20.0;
  static const double _dotRadius = 1.5;
  static const Color _dotColor = Color(0xFF9E9E9E); // Gray color for dots

  DottedPatternPainter({required this.canvasWidth, required this.canvasHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _dotColor
      ..style = PaintingStyle.fill;

    // Draw dots in a grid pattern covering entire canvas
    for (double x = 0; x < canvasWidth; x += _dotSpacing) {
      for (double y = 0; y < canvasHeight; y += _dotSpacing) {
        canvas.drawCircle(Offset(x, y), _dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DottedPatternPainter oldDelegate) =>
      oldDelegate.canvasWidth != canvasWidth ||
      oldDelegate.canvasHeight != canvasHeight;
}
