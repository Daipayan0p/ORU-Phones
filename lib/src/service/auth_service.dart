import 'package:stacked/stacked.dart';

class AuthService with ListenableServiceMixin {
  AuthService() {
    listenToReactiveValues([_isAuthenticated]);
  }

  final ReactiveValue<bool> _isAuthenticated = ReactiveValue<bool>(false);

  bool get isAuthenticated => _isAuthenticated.value;

  void authenticate() {
    _isAuthenticated.value = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated.value = false;
    notifyListeners();
  }
}
