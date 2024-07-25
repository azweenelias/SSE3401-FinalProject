// websocket_server.dart
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

void startWebSocketServer() async {
  final server = await HttpServer.bind('localhost', 8080);
  print('WebSocket server is running on ws://localhost:8080');
  await for (HttpRequest request in server) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      WebSocketTransformer.upgrade(request).then(handleWebSocket);
    } else {
      request.response
        ..statusCode = HttpStatus.forbidden
        ..write('WebSocket connections only')
        ..close();
    }
  }
}

void handleWebSocket(WebSocket client) {
  print('Client connected');

  Timer.periodic(Duration(seconds: 5), (timer) {
    final random = Random();
    final sensorData = {
      'voltageSensor': (random.nextDouble() * 2000).toStringAsFixed(2),
      'readingSteamPressure': (random.nextDouble() * 100).toStringAsFixed(2),
      'readingSteamFlow': (random.nextDouble() * 100).toStringAsFixed(2),
      'readingWaterLevel': (random.nextDouble() * 100).toStringAsFixed(2),
      'readingPowerFrequency': (50 + random.nextDouble() * 10).toStringAsFixed(2),
      'readingDateTime': DateTime.now().toIso8601String()

    };

    client.add(jsonEncode(sensorData));
  });

  client.listen((message) {
    print('Received message from client: $message');
  }, onDone: () {
    print('Client disconnected');
  });
}
