// Mocks generated by Mockito 5.4.4 from annotations
// in avatar_maker/test/src/customizer/widgets/customizer_body_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:ui' as _i12;

import 'package:avatar_maker/l10n/app_localizations.dart' as _i3;
import 'package:avatar_maker/src/core/controllers/avatar_maker_controller.dart'
    as _i5;
import 'package:avatar_maker/src/core/enums/property_category_ids.dart' as _i7;
import 'package:avatar_maker/src/core/models/customized_property_category.dart'
    as _i6;
import 'package:avatar_maker/src/core/models/property_item.dart' as _i8;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/src/animation/curves.dart' as _i13;
import 'package:get/get.dart' as _i2;
import 'package:get/get_state_manager/src/simple/list_notifier.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRxString_0 extends _i1.SmartFake implements _i2.RxString {
  _FakeRxString_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAppLocalizations_1 extends _i1.SmartFake
    implements _i3.AppLocalizations {
  _FakeAppLocalizations_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInternalFinalCallback_2<T> extends _i1.SmartFake
    implements _i2.InternalFinalCallback<T> {
  _FakeInternalFinalCallback_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDuration_3 extends _i1.SmartFake implements Duration {
  _FakeDuration_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAnimation_4<T> extends _i1.SmartFake implements _i4.Animation<T> {
  _FakeAnimation_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTickerFuture_5 extends _i1.SmartFake implements _i4.TickerFuture {
  _FakeTickerFuture_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AvatarMakerController].
///
/// See the documentation for Mockito's code generation for more information.
class MockAvatarMakerController extends _i1.Mock
    implements _i5.AvatarMakerController {
  @override
  _i2.RxString get displayedAvatarSVG => (super.noSuchMethod(
        Invocation.getter(#displayedAvatarSVG),
        returnValue: _FakeRxString_0(
          this,
          Invocation.getter(#displayedAvatarSVG),
        ),
        returnValueForMissingStub: _FakeRxString_0(
          this,
          Invocation.getter(#displayedAvatarSVG),
        ),
      ) as _i2.RxString);

  @override
  set displayedAvatarSVG(_i2.RxString? _displayedAvatarSVG) =>
      super.noSuchMethod(
        Invocation.setter(
          #displayedAvatarSVG,
          _displayedAvatarSVG,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i6.CustomizedPropertyCategory> get propertyCategories =>
      (super.noSuchMethod(
        Invocation.getter(#propertyCategories),
        returnValue: <_i6.CustomizedPropertyCategory>[],
        returnValueForMissingStub: <_i6.CustomizedPropertyCategory>[],
      ) as List<_i6.CustomizedPropertyCategory>);

  @override
  set propertyCategories(
          List<_i6.CustomizedPropertyCategory>? _propertyCategories) =>
      super.noSuchMethod(
        Invocation.setter(
          #propertyCategories,
          _propertyCategories,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i6.CustomizedPropertyCategory> get displayedPropertyCategories =>
      (super.noSuchMethod(
        Invocation.getter(#displayedPropertyCategories),
        returnValue: <_i6.CustomizedPropertyCategory>[],
        returnValueForMissingStub: <_i6.CustomizedPropertyCategory>[],
      ) as List<_i6.CustomizedPropertyCategory>);

  @override
  set displayedPropertyCategories(
          List<_i6.CustomizedPropertyCategory>? _displayedPropertyCategories) =>
      super.noSuchMethod(
        Invocation.setter(
          #displayedPropertyCategories,
          _displayedPropertyCategories,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Map<_i7.PropertyCategoryIds, _i8.PropertyItem> get defaultSelectedOptions =>
      (super.noSuchMethod(
        Invocation.getter(#defaultSelectedOptions),
        returnValue: <_i7.PropertyCategoryIds, _i8.PropertyItem>{},
        returnValueForMissingStub: <_i7.PropertyCategoryIds,
            _i8.PropertyItem>{},
      ) as Map<_i7.PropertyCategoryIds, _i8.PropertyItem>);

  @override
  set defaultSelectedOptions(
          Map<_i7.PropertyCategoryIds, _i8.PropertyItem>?
              _defaultSelectedOptions) =>
      super.noSuchMethod(
        Invocation.setter(
          #defaultSelectedOptions,
          _defaultSelectedOptions,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.AppLocalizations get l10n => (super.noSuchMethod(
        Invocation.getter(#l10n),
        returnValue: _FakeAppLocalizations_1(
          this,
          Invocation.getter(#l10n),
        ),
        returnValueForMissingStub: _FakeAppLocalizations_1(
          this,
          Invocation.getter(#l10n),
        ),
      ) as _i3.AppLocalizations);

  @override
  set l10n(_i3.AppLocalizations? _l10n) => super.noSuchMethod(
        Invocation.setter(
          #l10n,
          _l10n,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Map<_i7.PropertyCategoryIds, _i8.PropertyItem> get selectedOptions =>
      (super.noSuchMethod(
        Invocation.getter(#selectedOptions),
        returnValue: <_i7.PropertyCategoryIds, _i8.PropertyItem>{},
        returnValueForMissingStub: <_i7.PropertyCategoryIds,
            _i8.PropertyItem>{},
      ) as Map<_i7.PropertyCategoryIds, _i8.PropertyItem>);

  @override
  set selectedOptions(
          Map<_i7.PropertyCategoryIds, _i8.PropertyItem>? _selectedOptions) =>
      super.noSuchMethod(
        Invocation.setter(
          #selectedOptions,
          _selectedOptions,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.InternalFinalCallback<void> get onStart => (super.noSuchMethod(
        Invocation.getter(#onStart),
        returnValue: _FakeInternalFinalCallback_2<void>(
          this,
          Invocation.getter(#onStart),
        ),
        returnValueForMissingStub: _FakeInternalFinalCallback_2<void>(
          this,
          Invocation.getter(#onStart),
        ),
      ) as _i2.InternalFinalCallback<void>);

  @override
  _i2.InternalFinalCallback<void> get onDelete => (super.noSuchMethod(
        Invocation.getter(#onDelete),
        returnValue: _FakeInternalFinalCallback_2<void>(
          this,
          Invocation.getter(#onDelete),
        ),
        returnValueForMissingStub: _FakeInternalFinalCallback_2<void>(
          this,
          Invocation.getter(#onDelete),
        ),
      ) as _i2.InternalFinalCallback<void>);

  @override
  bool get initialized => (super.noSuchMethod(
        Invocation.getter(#initialized),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  int get listeners => (super.noSuchMethod(
        Invocation.getter(#listeners),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  void onInit() => super.noSuchMethod(
        Invocation.method(
          #onInit,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onReady() => super.noSuchMethod(
        Invocation.method(
          #onReady,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updatePreview({String? newAvatarMakerSVG = r''}) => super.noSuchMethod(
        Invocation.method(
          #updatePreview,
          [],
          {#newAvatarMakerSVG: newAvatarMakerSVG},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void restoreState() => super.noSuchMethod(
        Invocation.method(
          #restoreState,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i9.Future<void> saveAvatarSVG({String? jsonAvatarOptions}) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveAvatarSVG,
          [],
          {#jsonAvatarOptions: jsonAvatarOptions},
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  String drawAvatarSVG() => (super.noSuchMethod(
        Invocation.method(
          #drawAvatarSVG,
          [],
        ),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.method(
            #drawAvatarSVG,
            [],
          ),
        ),
        returnValueForMissingStub: _i10.dummyValue<String>(
          this,
          Invocation.method(
            #drawAvatarSVG,
            [],
          ),
        ),
      ) as String);

  @override
  _i9.Future<
      Map<_i7.PropertyCategoryIds,
          _i8.PropertyItem>> getStoredOptions() => (super.noSuchMethod(
        Invocation.method(
          #getStoredOptions,
          [],
        ),
        returnValue:
            _i9.Future<Map<_i7.PropertyCategoryIds, _i8.PropertyItem>>.value(
                <_i7.PropertyCategoryIds, _i8.PropertyItem>{}),
        returnValueForMissingStub:
            _i9.Future<Map<_i7.PropertyCategoryIds, _i8.PropertyItem>>.value(
                <_i7.PropertyCategoryIds, _i8.PropertyItem>{}),
      ) as _i9.Future<Map<_i7.PropertyCategoryIds, _i8.PropertyItem>>);

  @override
  String getComponentSVG(
    _i7.PropertyCategoryIds? categoryId,
    int? index,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getComponentSVG,
          [
            categoryId,
            index,
          ],
        ),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.method(
            #getComponentSVG,
            [
              categoryId,
              index,
            ],
          ),
        ),
        returnValueForMissingStub: _i10.dummyValue<String>(
          this,
          Invocation.method(
            #getComponentSVG,
            [
              categoryId,
              index,
            ],
          ),
        ),
      ) as String);

  @override
  void update([
    List<Object>? ids,
    bool? condition = true,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #update,
          [
            ids,
            condition,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onClose() => super.noSuchMethod(
        Invocation.method(
          #onClose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void $configureLifeCycle() => super.noSuchMethod(
        Invocation.method(
          #$configureLifeCycle,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.Disposer addListener(_i11.GetStateUpdate? listener) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValue: () {},
        returnValueForMissingStub: () {},
      ) as _i11.Disposer);

  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refresh() => super.noSuchMethod(
        Invocation.method(
          #refresh,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void refreshGroup(Object? id) => super.noSuchMethod(
        Invocation.method(
          #refreshGroup,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyChildrens() => super.noSuchMethod(
        Invocation.method(
          #notifyChildrens,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListenerId(
    Object? id,
    _i12.VoidCallback? listener,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #removeListenerId,
          [
            id,
            listener,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.Disposer addListenerId(
    Object? key,
    _i11.GetStateUpdate? listener,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListenerId,
          [
            key,
            listener,
          ],
        ),
        returnValue: () {},
        returnValueForMissingStub: () {},
      ) as _i11.Disposer);

  @override
  void disposeId(Object? id) => super.noSuchMethod(
        Invocation.method(
          #disposeId,
          [id],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [InternalFinalCallback].
///
/// See the documentation for Mockito's code generation for more information.
class MockInternalFinalCallback<T> extends _i1.Mock
    implements _i2.InternalFinalCallback<T> {
  @override
  T call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i10.dummyValue<T>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        ),
        returnValueForMissingStub: _i10.dummyValue<T>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        ),
      ) as T);
}

/// A class which mocks [TabController].
///
/// See the documentation for Mockito's code generation for more information.
class MockTabController extends _i1.Mock implements _i4.TabController {
  @override
  int get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  Duration get animationDuration => (super.noSuchMethod(
        Invocation.getter(#animationDuration),
        returnValue: _FakeDuration_3(
          this,
          Invocation.getter(#animationDuration),
        ),
        returnValueForMissingStub: _FakeDuration_3(
          this,
          Invocation.getter(#animationDuration),
        ),
      ) as Duration);

  @override
  int get index => (super.noSuchMethod(
        Invocation.getter(#index),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  set index(int? value) => super.noSuchMethod(
        Invocation.setter(
          #index,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get previousIndex => (super.noSuchMethod(
        Invocation.getter(#previousIndex),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  bool get indexIsChanging => (super.noSuchMethod(
        Invocation.getter(#indexIsChanging),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  double get offset => (super.noSuchMethod(
        Invocation.getter(#offset),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  set offset(double? value) => super.noSuchMethod(
        Invocation.setter(
          #offset,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void animateTo(
    int? value, {
    Duration? duration,
    _i4.Curve? curve = _i4.Curves.ease,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #animateTo,
          [value],
          {
            #duration: duration,
            #curve: curve,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AnimationController].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnimationController extends _i1.Mock
    implements _i4.AnimationController {
  @override
  double get lowerBound => (super.noSuchMethod(
        Invocation.getter(#lowerBound),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  double get upperBound => (super.noSuchMethod(
        Invocation.getter(#upperBound),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  _i4.AnimationBehavior get animationBehavior => (super.noSuchMethod(
        Invocation.getter(#animationBehavior),
        returnValue: _i4.AnimationBehavior.normal,
        returnValueForMissingStub: _i4.AnimationBehavior.normal,
      ) as _i4.AnimationBehavior);

  @override
  set duration(Duration? _duration) => super.noSuchMethod(
        Invocation.setter(
          #duration,
          _duration,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set reverseDuration(Duration? _reverseDuration) => super.noSuchMethod(
        Invocation.setter(
          #reverseDuration,
          _reverseDuration,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Animation<double> get view => (super.noSuchMethod(
        Invocation.getter(#view),
        returnValue: _FakeAnimation_4<double>(
          this,
          Invocation.getter(#view),
        ),
        returnValueForMissingStub: _FakeAnimation_4<double>(
          this,
          Invocation.getter(#view),
        ),
      ) as _i4.Animation<double>);

  @override
  double get value => (super.noSuchMethod(
        Invocation.getter(#value),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  set value(double? newValue) => super.noSuchMethod(
        Invocation.setter(
          #value,
          newValue,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get velocity => (super.noSuchMethod(
        Invocation.getter(#velocity),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  bool get isAnimating => (super.noSuchMethod(
        Invocation.getter(#isAnimating),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.AnimationStatus get status => (super.noSuchMethod(
        Invocation.getter(#status),
        returnValue: _i4.AnimationStatus.dismissed,
        returnValueForMissingStub: _i4.AnimationStatus.dismissed,
      ) as _i4.AnimationStatus);

  @override
  bool get isDismissed => (super.noSuchMethod(
        Invocation.getter(#isDismissed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool get isCompleted => (super.noSuchMethod(
        Invocation.getter(#isCompleted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void resync(_i4.TickerProvider? vsync) => super.noSuchMethod(
        Invocation.method(
          #resync,
          [vsync],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void reset() => super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.TickerFuture forward({double? from}) => (super.noSuchMethod(
        Invocation.method(
          #forward,
          [],
          {#from: from},
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #forward,
            [],
            {#from: from},
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #forward,
            [],
            {#from: from},
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  _i4.TickerFuture reverse({double? from}) => (super.noSuchMethod(
        Invocation.method(
          #reverse,
          [],
          {#from: from},
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #reverse,
            [],
            {#from: from},
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #reverse,
            [],
            {#from: from},
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  _i4.TickerFuture animateTo(
    double? target, {
    Duration? duration,
    _i4.Curve? curve = _i13.Curves.linear,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #animateTo,
          [target],
          {
            #duration: duration,
            #curve: curve,
          },
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #animateTo,
            [target],
            {
              #duration: duration,
              #curve: curve,
            },
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #animateTo,
            [target],
            {
              #duration: duration,
              #curve: curve,
            },
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  _i4.TickerFuture animateBack(
    double? target, {
    Duration? duration,
    _i4.Curve? curve = _i13.Curves.linear,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #animateBack,
          [target],
          {
            #duration: duration,
            #curve: curve,
          },
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #animateBack,
            [target],
            {
              #duration: duration,
              #curve: curve,
            },
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #animateBack,
            [target],
            {
              #duration: duration,
              #curve: curve,
            },
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  _i4.TickerFuture repeat({
    double? min,
    double? max,
    bool? reverse = false,
    Duration? period,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #repeat,
          [],
          {
            #min: min,
            #max: max,
            #reverse: reverse,
            #period: period,
          },
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #repeat,
            [],
            {
              #min: min,
              #max: max,
              #reverse: reverse,
              #period: period,
            },
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #repeat,
            [],
            {
              #min: min,
              #max: max,
              #reverse: reverse,
              #period: period,
            },
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  _i4.TickerFuture fling({
    double? velocity = 1.0,
    _i4.SpringDescription? springDescription,
    _i4.AnimationBehavior? animationBehavior,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fling,
          [],
          {
            #velocity: velocity,
            #springDescription: springDescription,
            #animationBehavior: animationBehavior,
          },
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #fling,
            [],
            {
              #velocity: velocity,
              #springDescription: springDescription,
              #animationBehavior: animationBehavior,
            },
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #fling,
            [],
            {
              #velocity: velocity,
              #springDescription: springDescription,
              #animationBehavior: animationBehavior,
            },
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  _i4.TickerFuture animateWith(_i4.Simulation? simulation) =>
      (super.noSuchMethod(
        Invocation.method(
          #animateWith,
          [simulation],
        ),
        returnValue: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #animateWith,
            [simulation],
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_5(
          this,
          Invocation.method(
            #animateWith,
            [simulation],
          ),
        ),
      ) as _i4.TickerFuture);

  @override
  void stop({bool? canceled = true}) => super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
          {#canceled: canceled},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  String toStringDetails() => (super.noSuchMethod(
        Invocation.method(
          #toStringDetails,
          [],
        ),
        returnValue: _i10.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDetails,
            [],
          ),
        ),
        returnValueForMissingStub: _i10.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDetails,
            [],
          ),
        ),
      ) as String);

  @override
  void addListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addStatusListener(_i4.AnimationStatusListener? listener) =>
      super.noSuchMethod(
        Invocation.method(
          #addStatusListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeStatusListener(_i4.AnimationStatusListener? listener) =>
      super.noSuchMethod(
        Invocation.method(
          #removeStatusListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Animation<U> drive<U>(_i4.Animatable<U>? child) => (super.noSuchMethod(
        Invocation.method(
          #drive,
          [child],
        ),
        returnValue: _FakeAnimation_4<U>(
          this,
          Invocation.method(
            #drive,
            [child],
          ),
        ),
        returnValueForMissingStub: _FakeAnimation_4<U>(
          this,
          Invocation.method(
            #drive,
            [child],
          ),
        ),
      ) as _i4.Animation<U>);

  @override
  void didRegisterListener() => super.noSuchMethod(
        Invocation.method(
          #didRegisterListener,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void didUnregisterListener() => super.noSuchMethod(
        Invocation.method(
          #didUnregisterListener,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void clearListeners() => super.noSuchMethod(
        Invocation.method(
          #clearListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void clearStatusListeners() => super.noSuchMethod(
        Invocation.method(
          #clearStatusListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyStatusListeners(_i4.AnimationStatus? status) => super.noSuchMethod(
        Invocation.method(
          #notifyStatusListeners,
          [status],
        ),
        returnValueForMissingStub: null,
      );
}
