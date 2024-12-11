import 'package:get_it/get_it.dart';

import '../utils/sessionManager.dart';

class AppLocator {
  static final GetIt instance = GetIt.instance;

  static Future<void> setup() async {
    instance.registerSingleton<SessionManager>(await SessionManager.create());
  }
}
