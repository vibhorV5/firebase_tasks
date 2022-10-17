import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_tasks/Routes/routes.dart';
import 'package:firebase_tasks/Screens/AuthGate/View/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', //id,
  'High Importance Notifications', //title
  // 'This channel is used for important notifications', //description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('A bg message just showed up : ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(MaterialApp(
      title: 'Remote Config Example',
      home: FutureBuilder<FirebaseRemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context,
            AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          return snapshot.hasData
              ? Home(remoteConfig: snapshot.requireData)
              : Container();
        },
      )));
}

class Home extends AnimatedWidget {
  Home({
    required this.remoteConfig,
  }) : super(listenable: remoteConfig);

  final FirebaseRemoteConfig remoteConfig;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Remote Config"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(remoteConfig.getString("Image")),
          Text(remoteConfig.getString("Text")),
          FloatingActionButton(
            onPressed: () async {
              try {
                await remoteConfig.setConfigSettings(RemoteConfigSettings(
                    fetchTimeout: Duration(seconds: 10),
                    minimumFetchInterval: Duration.zero));
                await remoteConfig.fetchAndActivate();
              } catch (e) {
                print(e);
              }
            },
            child: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
      title: 'Firebase Sample Project',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const AuthGate(),
    );
  }
}

Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.fetch();
  await remoteConfig.activate();

//testing
  print(remoteConfig.getString("Text"));

  return remoteConfig;
}
