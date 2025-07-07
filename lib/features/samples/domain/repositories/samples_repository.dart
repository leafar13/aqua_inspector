import 'package:aqua_inspector/features/samples/domain/entities/sample_item.dart';

abstract class SamplesRepository {
  Future<List<SampleItem>> getSamplesSummaryByUser(int userId, DateTime date);
}