// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interior_application/socket/socket.dart';

// Define the provider for SocketService
final socketServiceProvider = Provider<SocketService>((ref) {
  final socketService = SocketService(reference: ref);
  socketService.init();
  return socketService;
});
