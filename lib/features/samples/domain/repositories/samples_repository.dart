import '../entities/sample_item.dart';

abstract class SamplesRepository {
  Future<List<SampleItem>> getSamplesSummaryByUser(int userId, DateTime date);
  Future<List<SampleItem>> getSampleItemsFromAssets();
}
