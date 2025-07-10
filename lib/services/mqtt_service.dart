import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../utils/notificaciones_util.dart';

typedef EventoCallback = void Function(String mensaje);

class MqttService {
  late MqttServerClient _client;
  final EventoCallback onEvento;

  MqttService({required this.onEvento});

  Future<void> conectar() async {
    const broker = 'iot.ceisufro.cl';
    const port = 1883;
    const clientId = 'flutter_app_mqtt';
    const username = 'AtIcrtoHqlqLPpTQGrQ9'; // <- Usar access token del dispositivo

    _client = MqttServerClient(broker, clientId);
    _client.port = port;
    _client.keepAlivePeriod = 20;
    _client.secure = false;
    _client.logging(on: false);
    _client.onDisconnected = () {
      print('MQTT desconectado');
    };

    final connMess = MqttConnectMessage()
        .authenticateAs(username, '') // <- token en usuario, sin contraseña
        .withClientIdentifier(clientId)
        .startClean();

    _client.connectionMessage = connMess;

    try {
      await _client.connect();
      print('✅ Conectado al broker MQTT');

      _client.subscribe('v1/devices/me/telemetry', MqttQos.atMostOnce);

      _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('📩 Telemetría recibida: $payload');
        final jsonData = jsonDecode(payload);
        if (jsonData.containsKey('evento')) {
          final mensaje = jsonData['evento'];
          onEvento(mensaje);

          // Notificación local
          NotificacionesUtil.mostrarNotificacion('Evento de Alarma');
        }
      });

    } catch (e) {
      print('❌ Error conectando MQTT: $e');
      _client.disconnect();
    }
  }

  void desconectar() {
    _client.disconnect();
  }
}
