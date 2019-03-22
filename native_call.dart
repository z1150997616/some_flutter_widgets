import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef NativeCallback = void Function(String method, List result);

/*
native call example:
NativeCall.getInstance().addListener("XPage",  (String method, List list) {
      if (!this.mounted)
          return;
      if (method == "XFunction") {
        setState(() {
          _list = list;
        });
      }

call native example:
NativeCall.invokeMethod('XFunction', obj);
*/
class NativeCall{
  static NativeCall _instance;
  static NativeCall getInstance(){
    if (_instance == null){
      _instance = new NativeCall();
      _instance.listen();
    }
    return _instance;
  }


  void listen(){
      eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void addListener(String page, NativeCallback listener) {
    _pages.add(page);
    _listeners.add(listener);
  }

  void removeListener(String page) {
    _pages.remove(page);
    // for (var i = 0; i < _pages.length; i++) {
    //   _listeners.remove(_listeners[i]);
    // }
  }

void notifyListeners(String page, String method, List result) {
    if (_listeners != null) {
      final List<NativeCallback> localListeners = List<NativeCallback>.from(_listeners);
      for (NativeCallback listener in localListeners) {
        try {
          if (_listeners.contains(listener) && _pages.contains(page))
            listener(method,result);
        } catch (exception, stack) {
          FlutterError.reportError(FlutterErrorDetails(
            exception: exception,
            stack: stack,
            library: 'foundation library',
            context: 'while dispatching notifications for $runtimeType',
            informationCollector: (StringBuffer information) {
              information.writeln('The $runtimeType sending notification was:');
              information.write('  $this');
            }
          ));
        }
      }
    }
  }

  ObserverList<NativeCallback> _listeners = ObserverList<NativeCallback>();
  List<String> _pages = new List();

  void _onEvent(Object obj) {
    print("native call :"+obj.toString());
    Map event = obj;
    notifyListeners(event["page"], event["method"], event["result"]);
  }
 
  void _onError(Object error) {
    print("native call error:" + error.toString());
  }

  static Future<dynamic> invokeMethod(String method, [dynamic arguments]) async {
    return await methodChannel.invokeMethod(method, arguments);
  }
 
  //TODO: please modify this "myapp" to yourself
  static const methodChannel = const MethodChannel('com.myapp.native_get');
  EventChannel eventChannel = new EventChannel('com.myapp.native_post');
}