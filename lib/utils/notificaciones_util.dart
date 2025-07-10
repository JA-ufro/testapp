import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart'; //
import '../main.dart';

class NotificacionesUtil {
  static Future<void> mostrarNotificacion(String titulo) async {
    final String hora = DateFormat('HH:mm').format(DateTime.now());
    final String cuerpo = 'Se activó la alarma del dispositivo a las $hora.';

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'canal_alarma', // ID del canal
      'Notificaciones de alarma', // Nombre del canal
      channelDescription: 'Este canal se usa para alarmas del sistema',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,         // ID de la notificación
      titulo,    // Título
      cuerpo,    // Cuerpo generado con hora
      platformChannelSpecifics,
    );
  }
}
