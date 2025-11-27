import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/notes/data/models/note_model.dart';
import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:community_feedback/utils/constant/secrets.dart';
import 'package:dio/dio.dart';

abstract class NoteRemoteDataSource {
  Future<List<NoteModel>> getListNotes();
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final Dio dio;

  const NoteRemoteDataSourceImpl(this.dio);

  @override
  Future<List<NoteModel>> getListNotes() async {
    try {
      final response = await dio.get('${TSecrets.baseUrl}/api/notes');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data['data'] != null && data['data']['notes'] != null) {
          final List<dynamic> listNotes = data['data']['notes'];
          return listNotes.map((note) => NoteModel.fromJson(note)).toList();
        } else {
          return [];
        }
      } else {
        throw Failure.fromDioException(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
