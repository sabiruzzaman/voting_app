import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voting_app/widget/key_pad_button_widget.dart';
import '../controller/pin_controller.dart';

class OldPinScreen extends StatelessWidget {
  OldPinScreen({super.key});

  final PinController pinController = Get.put(PinController());

  Widget _buildPinCircle(bool isFilled) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? const Color(0xFF7C0FF0) : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Future.microtask(() => pinController.pin.clear());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      gradient: LinearGradient(
                        colors: [Color(0xFF7C0FF0), Color(0xFFBB00F1)],
                        begin: Alignment.bottomRight,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.lock, color: Colors.white, size: 30),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enter Your Old PIN",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    "Set your personal 4-digit code. It will be used to secure your voting app.",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pinController.maxPinLength, (index) {
                    return _buildPinCircle(index < pinController.pin.length);
                  }),
                )),
            const SizedBox(height: 30),
            KeyPadButtonWidget(
              onTap: (digit) {
                if (digit == 'x') {
                  pinController.removeDigit();
                } else if (digit == '✓') {
                  pinController.oldPinIsMatch();
                } else {
                  pinController.addDigit(int.parse(digit));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
