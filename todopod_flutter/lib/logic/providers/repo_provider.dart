import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';

final todoRepoProvider = Provider<TodoRepo>(((ref) => TodoRepo()));
