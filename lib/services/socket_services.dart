import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import 'api_constants.dart';

class SocketServices {
  factory SocketServices() {
    return _socketApi;
  }

  SocketServices._internal();

  static IO.Socket? socket;

  static final SocketServices _socketApi = SocketServices._internal();

  // static IO.Socket socket = IO.io('${ApiConstants.socketUrl}',
  //     IO.OptionBuilder().setTransports(['websocket']).enableForceNew().build());

  static void init({String token = ""}) {
    if (token != "") {
      socket = IO.io(
          '${ApiConstants.imageBaseUrl}',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setExtraHeaders({'Authorization': 'Bearer $token'})
              .enableReconnection()
              .enableForceNew()
              .build());
    }

    if (!socket!.connected) {
      socket?.onConnect((_) {
        print('==================================> socket connected: ${socket?.connected}');
      });

      socket?.onConnectError((err) {
        print('==================================> socket connect error: $err');
      });

      socket?.onDisconnect((_) {
        print('===================================> socket disconnected');
      });
    } else {
      print("==================================> socket already connected");
    }
  }

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();

    // Debug: Log the event and body being emitted
    print("emitWithAck: Emitting event '$event' with body: $body");

    socket?.emitWithAck(event, body, ack: (data) {
      // Debug: Log the acknowledgment received
      print("emitWithAck: Acknowledgment received for event '$event': $data");

      if (data != null) {
        completer.complete(data);
      } else {
        completer.complete(1); // Default fallback if `data` is null
      }
    });

    // Debug: Awaiting acknowledgment
    print("emitWithAck: Waiting for acknowledgment for event '$event'");

    return completer.future;
  }

  static emit(String event, dynamic body) async {
    if (body != null) {
      socket?.emit(event, body);
      print('===========> Emit $event and \n $body');
    }
  }


}
