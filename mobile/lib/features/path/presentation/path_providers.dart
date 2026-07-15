import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/path_models.dart';
import '../data/path_repository.dart';

final pathRepositoryProvider = Provider<PathRepository>(
  (ref) => PathRepository(ref.watch(databaseProvider)),
);

final pathProvider = StreamProvider<List<PathUnit>>(
  (ref) => ref.watch(pathRepositoryProvider).watchPath(),
);
