import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sample_item.dart';

part 'samples_state.freezed.dart';

enum SamplesStatus { initial, loading, loaded, error }

@freezed
abstract class SamplesState with _$SamplesState {
  const factory SamplesState({
    @Default(SamplesStatus.initial) SamplesStatus status,
    @Default([]) List<SampleItem> samples,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _SamplesState;

  const SamplesState._();
  bool get hasData => samples.isNotEmpty;
  bool get hasError => status == SamplesStatus.error;
}
