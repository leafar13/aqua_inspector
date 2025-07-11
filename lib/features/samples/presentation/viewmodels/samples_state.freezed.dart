// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'samples_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SamplesState {

 SamplesStatus get status; List<SampleItem> get samples; String? get errorMessage; bool get isLoading;
/// Create a copy of SamplesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SamplesStateCopyWith<SamplesState> get copyWith => _$SamplesStateCopyWithImpl<SamplesState>(this as SamplesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SamplesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.samples, samples)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(samples),errorMessage,isLoading);

@override
String toString() {
  return 'SamplesState(status: $status, samples: $samples, errorMessage: $errorMessage, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $SamplesStateCopyWith<$Res>  {
  factory $SamplesStateCopyWith(SamplesState value, $Res Function(SamplesState) _then) = _$SamplesStateCopyWithImpl;
@useResult
$Res call({
 SamplesStatus status, List<SampleItem> samples, String? errorMessage, bool isLoading
});




}
/// @nodoc
class _$SamplesStateCopyWithImpl<$Res>
    implements $SamplesStateCopyWith<$Res> {
  _$SamplesStateCopyWithImpl(this._self, this._then);

  final SamplesState _self;
  final $Res Function(SamplesState) _then;

/// Create a copy of SamplesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? samples = null,Object? errorMessage = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SamplesStatus,samples: null == samples ? _self.samples : samples // ignore: cast_nullable_to_non_nullable
as List<SampleItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SamplesState].
extension SamplesStatePatterns on SamplesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SamplesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SamplesState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SamplesState value)  $default,){
final _that = this;
switch (_that) {
case _SamplesState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SamplesState value)?  $default,){
final _that = this;
switch (_that) {
case _SamplesState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SamplesStatus status,  List<SampleItem> samples,  String? errorMessage,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SamplesState() when $default != null:
return $default(_that.status,_that.samples,_that.errorMessage,_that.isLoading);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SamplesStatus status,  List<SampleItem> samples,  String? errorMessage,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _SamplesState():
return $default(_that.status,_that.samples,_that.errorMessage,_that.isLoading);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SamplesStatus status,  List<SampleItem> samples,  String? errorMessage,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _SamplesState() when $default != null:
return $default(_that.status,_that.samples,_that.errorMessage,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _SamplesState extends SamplesState {
  const _SamplesState({this.status = SamplesStatus.initial, final  List<SampleItem> samples = const [], this.errorMessage, this.isLoading = false}): _samples = samples,super._();
  

@override@JsonKey() final  SamplesStatus status;
 final  List<SampleItem> _samples;
@override@JsonKey() List<SampleItem> get samples {
  if (_samples is EqualUnmodifiableListView) return _samples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_samples);
}

@override final  String? errorMessage;
@override@JsonKey() final  bool isLoading;

/// Create a copy of SamplesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SamplesStateCopyWith<_SamplesState> get copyWith => __$SamplesStateCopyWithImpl<_SamplesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SamplesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._samples, _samples)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_samples),errorMessage,isLoading);

@override
String toString() {
  return 'SamplesState(status: $status, samples: $samples, errorMessage: $errorMessage, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$SamplesStateCopyWith<$Res> implements $SamplesStateCopyWith<$Res> {
  factory _$SamplesStateCopyWith(_SamplesState value, $Res Function(_SamplesState) _then) = __$SamplesStateCopyWithImpl;
@override @useResult
$Res call({
 SamplesStatus status, List<SampleItem> samples, String? errorMessage, bool isLoading
});




}
/// @nodoc
class __$SamplesStateCopyWithImpl<$Res>
    implements _$SamplesStateCopyWith<$Res> {
  __$SamplesStateCopyWithImpl(this._self, this._then);

  final _SamplesState _self;
  final $Res Function(_SamplesState) _then;

/// Create a copy of SamplesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? samples = null,Object? errorMessage = freezed,Object? isLoading = null,}) {
  return _then(_SamplesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SamplesStatus,samples: null == samples ? _self._samples : samples // ignore: cast_nullable_to_non_nullable
as List<SampleItem>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
