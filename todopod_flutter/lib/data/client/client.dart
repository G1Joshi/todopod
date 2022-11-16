import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:todopod_client/todopod_client.dart';

import '../../config/config.dart';

final Client client = Client(baseUrl)
  ..connectivityMonitor = FlutterConnectivityMonitor();
