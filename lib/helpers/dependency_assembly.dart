import 'package:get_it/get_it.dart';
import '../core/services/api.dart';

GetIt dependencyAssembler = GetIt.instance;

void setupDependencyAssembler() {
  dependencyAssembler.registerLazySingleton(() => API());
}
