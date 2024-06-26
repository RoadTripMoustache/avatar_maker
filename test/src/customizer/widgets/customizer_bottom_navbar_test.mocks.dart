// Mocks generated by Mockito 5.4.4 from annotations
// in avatar_maker/test/src/customizer/widgets/customizer_bottom_navbar_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i4;

import 'package:flutter/src/animation/curves.dart' as _i5;
import 'package:flutter/src/material/tab_controller.dart' as _i3;
import 'package:flutter/widgets.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;

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

class _FakeDuration_0 extends _i1.SmartFake implements Duration {
  _FakeDuration_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAnimation_1<T> extends _i1.SmartFake implements _i2.Animation<T> {
  _FakeAnimation_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTickerFuture_2 extends _i1.SmartFake implements _i2.TickerFuture {
  _FakeTickerFuture_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TabController].
///
/// See the documentation for Mockito's code generation for more information.
class MockTabController extends _i1.Mock implements _i3.TabController {
  @override
  int get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  Duration get animationDuration => (super.noSuchMethod(
        Invocation.getter(#animationDuration),
        returnValue: _FakeDuration_0(
          this,
          Invocation.getter(#animationDuration),
        ),
        returnValueForMissingStub: _FakeDuration_0(
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
    _i2.Curve? curve = _i2.Curves.ease,
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
  void addListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i4.VoidCallback? listener) => super.noSuchMethod(
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
    implements _i2.AnimationController {
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
  _i2.AnimationBehavior get animationBehavior => (super.noSuchMethod(
        Invocation.getter(#animationBehavior),
        returnValue: _i2.AnimationBehavior.normal,
        returnValueForMissingStub: _i2.AnimationBehavior.normal,
      ) as _i2.AnimationBehavior);

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
  _i2.Animation<double> get view => (super.noSuchMethod(
        Invocation.getter(#view),
        returnValue: _FakeAnimation_1<double>(
          this,
          Invocation.getter(#view),
        ),
        returnValueForMissingStub: _FakeAnimation_1<double>(
          this,
          Invocation.getter(#view),
        ),
      ) as _i2.Animation<double>);

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
  _i2.AnimationStatus get status => (super.noSuchMethod(
        Invocation.getter(#status),
        returnValue: _i2.AnimationStatus.dismissed,
        returnValueForMissingStub: _i2.AnimationStatus.dismissed,
      ) as _i2.AnimationStatus);

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
  void resync(_i2.TickerProvider? vsync) => super.noSuchMethod(
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
  _i2.TickerFuture forward({double? from}) => (super.noSuchMethod(
        Invocation.method(
          #forward,
          [],
          {#from: from},
        ),
        returnValue: _FakeTickerFuture_2(
          this,
          Invocation.method(
            #forward,
            [],
            {#from: from},
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_2(
          this,
          Invocation.method(
            #forward,
            [],
            {#from: from},
          ),
        ),
      ) as _i2.TickerFuture);

  @override
  _i2.TickerFuture reverse({double? from}) => (super.noSuchMethod(
        Invocation.method(
          #reverse,
          [],
          {#from: from},
        ),
        returnValue: _FakeTickerFuture_2(
          this,
          Invocation.method(
            #reverse,
            [],
            {#from: from},
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_2(
          this,
          Invocation.method(
            #reverse,
            [],
            {#from: from},
          ),
        ),
      ) as _i2.TickerFuture);

  @override
  _i2.TickerFuture animateTo(
    double? target, {
    Duration? duration,
    _i2.Curve? curve = _i5.Curves.linear,
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
        returnValue: _FakeTickerFuture_2(
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
        returnValueForMissingStub: _FakeTickerFuture_2(
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
      ) as _i2.TickerFuture);

  @override
  _i2.TickerFuture animateBack(
    double? target, {
    Duration? duration,
    _i2.Curve? curve = _i5.Curves.linear,
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
        returnValue: _FakeTickerFuture_2(
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
        returnValueForMissingStub: _FakeTickerFuture_2(
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
      ) as _i2.TickerFuture);

  @override
  _i2.TickerFuture repeat({
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
        returnValue: _FakeTickerFuture_2(
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
        returnValueForMissingStub: _FakeTickerFuture_2(
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
      ) as _i2.TickerFuture);

  @override
  _i2.TickerFuture fling({
    double? velocity = 1.0,
    _i2.SpringDescription? springDescription,
    _i2.AnimationBehavior? animationBehavior,
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
        returnValue: _FakeTickerFuture_2(
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
        returnValueForMissingStub: _FakeTickerFuture_2(
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
      ) as _i2.TickerFuture);

  @override
  _i2.TickerFuture animateWith(_i2.Simulation? simulation) =>
      (super.noSuchMethod(
        Invocation.method(
          #animateWith,
          [simulation],
        ),
        returnValue: _FakeTickerFuture_2(
          this,
          Invocation.method(
            #animateWith,
            [simulation],
          ),
        ),
        returnValueForMissingStub: _FakeTickerFuture_2(
          this,
          Invocation.method(
            #animateWith,
            [simulation],
          ),
        ),
      ) as _i2.TickerFuture);

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
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDetails,
            [],
          ),
        ),
        returnValueForMissingStub: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #toStringDetails,
            [],
          ),
        ),
      ) as String);

  @override
  void addListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i4.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addStatusListener(_i2.AnimationStatusListener? listener) =>
      super.noSuchMethod(
        Invocation.method(
          #addStatusListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeStatusListener(_i2.AnimationStatusListener? listener) =>
      super.noSuchMethod(
        Invocation.method(
          #removeStatusListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Animation<U> drive<U>(_i2.Animatable<U>? child) => (super.noSuchMethod(
        Invocation.method(
          #drive,
          [child],
        ),
        returnValue: _FakeAnimation_1<U>(
          this,
          Invocation.method(
            #drive,
            [child],
          ),
        ),
        returnValueForMissingStub: _FakeAnimation_1<U>(
          this,
          Invocation.method(
            #drive,
            [child],
          ),
        ),
      ) as _i2.Animation<U>);

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
  void notifyStatusListeners(_i2.AnimationStatus? status) => super.noSuchMethod(
        Invocation.method(
          #notifyStatusListeners,
          [status],
        ),
        returnValueForMissingStub: null,
      );
}
