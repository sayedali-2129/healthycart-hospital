// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authenication_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenicationState {
  bool get loading => throw _privateConstructorUsedError;
  Option<Either<MainFailure, String>> get failureOrSuccessOption =>
      throw _privateConstructorUsedError;
  Option<Either<MainFailure, String>> get otpFailureOrSucess =>
      throw _privateConstructorUsedError;
  AdminType? get adminType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenicationStateCopyWith<AuthenicationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenicationStateCopyWith<$Res> {
  factory $AuthenicationStateCopyWith(
          AuthenicationState value, $Res Function(AuthenicationState) then) =
      _$AuthenicationStateCopyWithImpl<$Res, AuthenicationState>;
  @useResult
  $Res call(
      {bool loading,
      Option<Either<MainFailure, String>> failureOrSuccessOption,
      Option<Either<MainFailure, String>> otpFailureOrSucess,
      AdminType? adminType});
}

/// @nodoc
class _$AuthenicationStateCopyWithImpl<$Res, $Val extends AuthenicationState>
    implements $AuthenicationStateCopyWith<$Res> {
  _$AuthenicationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? failureOrSuccessOption = null,
    Object? otpFailureOrSucess = null,
    Object? adminType = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccessOption: null == failureOrSuccessOption
          ? _value.failureOrSuccessOption
          : failureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, String>>,
      otpFailureOrSucess: null == otpFailureOrSucess
          ? _value.otpFailureOrSucess
          : otpFailureOrSucess // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, String>>,
      adminType: freezed == adminType
          ? _value.adminType
          : adminType // ignore: cast_nullable_to_non_nullable
              as AdminType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthenicationStateImplCopyWith<$Res>
    implements $AuthenicationStateCopyWith<$Res> {
  factory _$$AuthenicationStateImplCopyWith(_$AuthenicationStateImpl value,
          $Res Function(_$AuthenicationStateImpl) then) =
      __$$AuthenicationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      Option<Either<MainFailure, String>> failureOrSuccessOption,
      Option<Either<MainFailure, String>> otpFailureOrSucess,
      AdminType? adminType});
}

/// @nodoc
class __$$AuthenicationStateImplCopyWithImpl<$Res>
    extends _$AuthenicationStateCopyWithImpl<$Res, _$AuthenicationStateImpl>
    implements _$$AuthenicationStateImplCopyWith<$Res> {
  __$$AuthenicationStateImplCopyWithImpl(_$AuthenicationStateImpl _value,
      $Res Function(_$AuthenicationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? failureOrSuccessOption = null,
    Object? otpFailureOrSucess = null,
    Object? adminType = freezed,
  }) {
    return _then(_$AuthenicationStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      failureOrSuccessOption: null == failureOrSuccessOption
          ? _value.failureOrSuccessOption
          : failureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, String>>,
      otpFailureOrSucess: null == otpFailureOrSucess
          ? _value.otpFailureOrSucess
          : otpFailureOrSucess // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, String>>,
      adminType: freezed == adminType
          ? _value.adminType
          : adminType // ignore: cast_nullable_to_non_nullable
              as AdminType?,
    ));
  }
}

/// @nodoc

class _$AuthenicationStateImpl implements _AuthenicationState {
  const _$AuthenicationStateImpl(
      {required this.loading,
      required this.failureOrSuccessOption,
      required this.otpFailureOrSucess,
      required this.adminType});

  @override
  final bool loading;
  @override
  final Option<Either<MainFailure, String>> failureOrSuccessOption;
  @override
  final Option<Either<MainFailure, String>> otpFailureOrSucess;
  @override
  final AdminType? adminType;

  @override
  String toString() {
    return 'AuthenicationState(loading: $loading, failureOrSuccessOption: $failureOrSuccessOption, otpFailureOrSucess: $otpFailureOrSucess, adminType: $adminType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenicationStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.failureOrSuccessOption, failureOrSuccessOption) ||
                other.failureOrSuccessOption == failureOrSuccessOption) &&
            (identical(other.otpFailureOrSucess, otpFailureOrSucess) ||
                other.otpFailureOrSucess == otpFailureOrSucess) &&
            (identical(other.adminType, adminType) ||
                other.adminType == adminType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, failureOrSuccessOption,
      otpFailureOrSucess, adminType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenicationStateImplCopyWith<_$AuthenicationStateImpl> get copyWith =>
      __$$AuthenicationStateImplCopyWithImpl<_$AuthenicationStateImpl>(
          this, _$identity);
}

abstract class _AuthenicationState implements AuthenicationState {
  const factory _AuthenicationState(
      {required final bool loading,
      required final Option<Either<MainFailure, String>> failureOrSuccessOption,
      required final Option<Either<MainFailure, String>> otpFailureOrSucess,
      required final AdminType? adminType}) = _$AuthenicationStateImpl;

  @override
  bool get loading;
  @override
  Option<Either<MainFailure, String>> get failureOrSuccessOption;
  @override
  Option<Either<MainFailure, String>> get otpFailureOrSucess;
  @override
  AdminType? get adminType;
  @override
  @JsonKey(ignore: true)
  _$$AuthenicationStateImplCopyWith<_$AuthenicationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
