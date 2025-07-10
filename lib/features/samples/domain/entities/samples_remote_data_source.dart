import 'package:aqua_inspector/features/samples/data/models/sample_item_model.dart';

abstract class SamplesRemoteDataSource {
  Future<List<SampleItemModel>> getSamplesSummaryByUser(int userId, DateTime date);
}
