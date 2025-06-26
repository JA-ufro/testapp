import 'dart:convert';
import 'package:http/http.dart' as http;

class ThingsBoardService {
  static const String deviceToken = 'TU_TOKEN_AQUI'; // <- Pega tu token
  static const String baseUrl = 'https://demo.thingsboard.io'; // o tu IP si es local

  static Future<void> enviarComandoAlarma(bool encender) async {
    final url = Uri.parse('$baseUrl/api/v1/$deviceToken/rpc');
    final cuerpo = jsonEncode({
      "method": "set_state", // <- nombre del método que espera tu dispositivo
      "params": encender ? "ON" : "OFF"
    });

    try {
      final respuesta = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: cuerpo,
      );

      if (respuesta.statusCode == 200) {
        print("Comando enviado correctamente");
      } else {
        print("Error: ${respuesta.statusCode} - ${respuesta.body}");
      }
    } catch (e) {
      print("Excepción al enviar comando: $e");
    }
  }
}
