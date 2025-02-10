import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voting_app/create_pin/view/enter_pin_screen.dart';
import '../../../create_pin/controller/pin_controller.dart';
import '../../controller/vot_configuration_controller.dart';

class DashboardTabScreen extends StatelessWidget {
   DashboardTabScreen({super.key});

  final PinController pinController = Get.put(PinController());
  final VotConfigurationController votController =
      Get.put(VotConfigurationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.all(2), // Space for the border
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C0FF0), Color(0xFFBB00F1)],
                        begin: Alignment.bottomRight,
                        end: Alignment.topRight,
                      )
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Total Vot : ${votController.totalSelections()}", style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),

                      ],
                    ),
                  ),
                ),
              ),
              _buildMenu('Vot Configuration', Icons.settings_rounded, () {
                Get.to(() => EnterPinScreen(), arguments: {
                  'route': 'vot_configuration_screen',
                });

              }),
              _buildMenu('Voting Results', Icons.view_array_rounded, () {
                Get.to(() => EnterPinScreen(), arguments: {
                  'route': 'result_screen',
                });
              }),
              _buildMenu('Change PIN', Icons.lock_rounded, () {
                pinController.oldPinScreen();
              }),
            ],
          ),
        ));
  }

  Widget _buildMenu(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
