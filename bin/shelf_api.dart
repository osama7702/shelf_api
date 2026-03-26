import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  router.get('/hello', (Request req) {
    return Response.ok('Hello from Dart API!');
  });

  // http://localhost:8080/num?num=42
  router.get('/num', (Request req) {
    final num = req.url.queryParameters['num'] ?? 'No number provided';
    return Response.ok('Number: $num');
  });

  // http://localhost:8080/int/42
  router.get('/int/<num>', (Request req, String num) {
    return Response.ok('Number: $num');
  });

  router.get('/ask', (Request req) {
    final prompt = req.url.queryParameters['prompt'] ?? '';
    final answer = prompt.isNotEmpty ? 'رد سريع على: $prompt' : 'لا يوجد Prompt';
    return Response.ok(answer);
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Server listening on port ${server.port}');
}