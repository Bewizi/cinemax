import 'package:cinemax/app/app.dart';
import 'package:cinemax/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
