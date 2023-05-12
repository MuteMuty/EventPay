import 'dart:async';

import 'package:meta/meta.dart';

import '../../models/user.dart';
import '../../util/logger.dart';

part 'global_state.dart';

class GlobalBloc {
  static GlobalBloc? _instance;
  static GlobalBloc get instance => _instance!;

  Stream<void> get globalUserStream => _globalUser.stream;

  final Logger _logger;

  GlobalState _state;
  GlobalState get state => _state;

  GlobalBloc._({required Logger logger})
      : _logger = logger,
        _state = const GlobalState.initial(),
        _globalUser = StreamController<void>.broadcast();

  factory GlobalBloc({required Logger logger}) {
    if (_instance != null) {
      throw StateError('GlobalBloc already created!');
    }

    _instance = GlobalBloc._(logger: logger);
    return _instance!;
  }

  final StreamController<void> _globalUser;

  void updateUser(EventPayUser user) {
    _state = _state.copyWith(user: user);
    _globalUser.add(null);
    _logger.info('GlobalBloc.updateUser', 'user updated');
  }

  void reset() {
    _state = const GlobalState.initial();
    _logger.info('GlobalBloc.reset', 'state reset');
  }
}
