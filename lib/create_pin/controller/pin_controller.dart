import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PinController extends GetxController {
  final RxList<int> pin = <int>[].obs; // Observable PIN list
  final int maxPinLength = 4;
  final GetStorage storage = GetStorage(); // Local storage instance
  final String pinKey = 'user_pin'; // Key for storing PIN in GetStorage

  @override
  void onInit() {
    super.onInit();
    loadStoredPin(); // Load PIN from storage on app start
  }

  void addDigit(int digit) {
    if (pin.length < maxPinLength) {
      pin.add(digit);
    }
  }

  void removeDigit() {
    if (pin.isNotEmpty) {
      pin.removeLast();
    }
  }

  void clearPin() {
    pin.clear();
    storage.remove(pinKey); // Clear stored PIN
  }

  void storePin() {
    if (pin.length == maxPinLength) {
      storage.write(pinKey, pin.join()); // Store the PIN as a string
    }
  }

  void loadStoredPin() {
    String? storedPin = storage.read(pinKey);
    if (storedPin != null) {
      pin.assignAll(storedPin.split('').map((e) => int.parse(e)).toList());
    }
  }

  void nextScreen() {
    if (pin.length == maxPinLength) {
      storePin();

      Get.snackbar(
        "PIN Set",
        "Your PIN has been successfully set.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Save the PIN before navigating
      Get.offNamed('/home');
    } else {
      Get.snackbar(
        "Incomplete PIN",
        "Please enter a 4-digit PIN before proceeding.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void oldPinScreen() {
    Get.toNamed('/old_pin_screen');
  }

  void createNewPinScreen() {
    Get.offNamed('/create_pin');
  }

  void oldPinIsMatch() {
    final String? storedPin = storage.read('user_pin');

    if (storedPin == pin.join()) {
      pin.clear();
      createNewPinScreen();
    } else {
      Get.snackbar(
        "Incorrect PIN",
        "Please enter the correct PIN to proceed.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void configurationScreen() {
    Get.toNamed('/vot_configuration_screen');
  }

  void resultScreen() {
    Get.toNamed('/result_screen');
  }

  void isPinMatchNextScreen(String route) {
    final String? storedPin = storage.read('user_pin');

    if (storedPin == pin.join()) {
      pin.clear();

      if (route == 'vot_configuration_screen') {
        Get.offNamed('/vot_configuration_screen');  // Replaces current screen
      } else if (route == 'result_screen') {
        Get.offNamed('/result_screen');  // Replaces current screen
      }

    } else {
      Get.snackbar(
        "Incorrect PIN",
        "Please enter the correct PIN to proceed.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

}
