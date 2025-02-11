import 'package:oru_phones/src/service/auth_service.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [], dependencies: [
  Singleton(classType: AuthService),
])
class App {}
