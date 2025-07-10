import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/sample_item_model.dart';

abstract class SamplesLocalDataSource {
  Future<List<SampleItemModel>> getSampleItemsFromAssets();
}

class SamplesLocalDataSourceImpl implements SamplesLocalDataSource {
  @override
  Future<List<SampleItemModel>> getSampleItemsFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/sample_items.json');

      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<dynamic> samplesJson = jsonData['samples'] as List<dynamic>;

      final List<SampleItemModel> samples = samplesJson.map((json) => SampleItemModel.fromJson(json as Map<String, dynamic>)).toList();

      return samples;
    } catch (e) {
      return [];
    }
  }
}

class SamplesLocalDataSourceException implements Exception {
  final String message;

  SamplesLocalDataSourceException(this.message);

  @override
  String toString() => 'SamplesLocalDataSourceException: $message';
}
