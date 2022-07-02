import 'dart:async';
import 'package:flutter/material.dart';

abstract class ListenableState extends Listenable {
  final Set<VoidCallback> _listeners = <VoidCallback>{};
  int _version = 0;
  int _microtaskVersion = 0;
  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Returns the number of listeners listening to this ListenableState.
  int get listenerCount => _listeners.length;

  @protected
  void notifyListeners() {
    // We schedule a microtask to debounce multiple changes that can occur
    // all at once.
    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;

        // Convert the Set to a List before executing each listener. This
        // prevents errors that can arise if a listener removes itself during
        // invocation!
        _listeners.toList().forEach((VoidCallback listener) => listener());
      });
    }
  }
}

class StateProvider<T extends ListenableState> extends StatelessWidget {
  @override
  final Key? key;
  final T value;
  final Widget child;
  const StateProvider({this.key, required this.child, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: value,
      builder: (context, _) => Provider<T>(
        state: value,
        child: child,
      ),
    );
  }

  static T of<T extends ListenableState>(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) {
    final widget = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<Provider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<Provider<T>>()
            ?.widget;

    if (widget == null) {
      throw "Couldn't find widget of type $T";
    } else {
      return (widget as Provider<T>).state;
    }
  }
}

class ChangeNotifierProvider<T extends ListenableState>
    extends StatelessWidget {
  const ChangeNotifierProvider(
      {required this.builder, this.child, this.rebuildOnChange = true});
  final Widget? child;
  final ValueWidgetBuilder<T> builder;

  /// An optional value that determines whether the Widget will rebuild when
  /// the ListenableState changes.
  final bool rebuildOnChange;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      StateProvider.of<T>(context, rebuildOnChange: rebuildOnChange),
      child,
    );
  }
}

class Provider<T extends ListenableState> extends InheritedWidget {
  /// Builds a [Provider].
  Provider({
    Key? key,
    required this.state,
    required Widget child,
  })  : version = state._version,
        super(key: key, child: child);

  final T state;
  final int version;

  @override
  bool updateShouldNotify(Provider<T> oldWidget) =>
      oldWidget.version != version;
  // state != oldWidget.state;

  /// Retrieves the [StateProvider<T>] from the closest ancestor
  /// [Provider] widget.
  static T? of<T extends ListenableState>(BuildContext context) {
    var bloc = context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    bloc ??= context.findAncestorWidgetOfExactType<Provider<T>>();
    assert(
      bloc != null,
      'You must have a $T widget at the top of your widget tree',
    );

    return bloc!.state;
  }
}
