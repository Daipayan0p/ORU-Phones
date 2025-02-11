import 'package:oru_phones/src/service/auth_service.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends ReactiveViewModel {
  final AuthService _authService;

  AuthViewModel(this._authService);

  bool get isAuthenticated => _authService.isAuthenticated;

  void authenticate() => _authService.authenticate();

  void logout() => _authService.logout();

}
