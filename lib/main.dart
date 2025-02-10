import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_app/create_pin/view/enter_pin_screen.dart';
import 'package:voting_app/create_pin/view/old_pin_screen.dart';
import 'package:voting_app/home/dashboard_tab/view/result_screen.dart';
import 'package:voting_app/home/voting_tab/view/vot_configuration_screen.dart';
import 'create_pin/controller/pin_controller.dart';
import 'create_pin/view/create_pin.dart';
import 'home/home.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  Get.lazyPut<PinController>(() => PinController());

  // Check if PIN exists
  final GetStorage storage = GetStorage();
  final String? storedPin = storage.read('user_pin');

  // Set system UI style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Launch the app with dynamic initial route
  runApp(MyApp(initialRoute: storedPin != null ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => CreatePin()), // Create PIN screen
        GetPage(name: '/home', page: () => const HomeScreen()), // Home screen
        GetPage(name: '/old_pin_screen', page: () => OldPinScreen()), // Old PIN screen
        GetPage(name: '/vot_configuration_screen', page: () => VotConfigurationScreen()),
        GetPage(name: '/result_screen', page: () => ResultsScreen()),
        GetPage(name: '/enter_pin_screen', page: () => EnterPinScreen()),

        // Old PIN screen
      ],
    );
  }
}
