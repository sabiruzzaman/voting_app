import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../create_pin/controller/pin_controller.dart';
import '../../../create_pin/view/enter_pin_screen.dart';
import '../../../widget/widget_button.dart';
import '../../controller/vot_configuration_controller.dart';

class VotingTabScreen extends StatefulWidget {
  const VotingTabScreen({super.key});

  @override
  State<VotingTabScreen> createState() => _VotingTabScreenState();
}

class _VotingTabScreenState extends State<VotingTabScreen> {
  final PinController pinController =
      Get.find(); // Retrieve the existing instance

  final VotConfigurationController controller =
      Get.put(VotConfigurationController());

  String selectedOptions = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        bool hasOptions = controller.options.isNotEmpty;

        return ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Obx(() => Text(
                  controller.title.isNotEmpty
                      ? "Vote Title: ${controller.title.value}"
                      : '',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(height: 20),

            // যদি অপশন থাকে তাহলে GridView দেখানো হবে
            if (hasOptions)
              GridView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 10, // Spacing between rows
                  childAspectRatio:
                      1.2, // Width to height ratio of the grid items
                ),
                itemCount: controller.options.length,
                itemBuilder: (context, index) {
                  return _buildGridItem(controller.options[index]);
                },
              )
            else
              // যদি কোনো অপশন না থাকে তাহলে মেসেজ এবং বাটন স্ক্রিনের মাঝখানে দেখানো হবে
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 20),
                    Text(
                      "No options available",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    WidgetButton(
                      title: 'Go Configure',
                      onTap: () {
                        Get.to(() => EnterPinScreen(), arguments: {
                          'route': 'vot_configuration_screen',
                        });
                      },
                      color: const Color(0xFFBB00F1),
                      width: 200, // বাটনের প্রস্থ নির্ধারণ
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // সাবমিট বাটন তখনই দেখানো হবে যখন অপশন থাকবে
            if (hasOptions)
              WidgetButton(
                title: 'Submit',
                onTap: () {
                  if (selectedOptions.isNotEmpty) {
                    controller.incrementSelection(selectedOptions);
                    controller.saveConfig();
                    Get.snackbar(
                      "Submitted Vote",
                      "You voted for $selectedOptions",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );

                    setState(() {
                      selectedOptions = ''; // সিলেকশন খালি করা
                    });
                  } else {
                    Get.snackbar(
                      "Error",
                      "Please select an option before submitting.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                  }
                },
                color: const Color(0xFFBB00F1),
                width: double.infinity,
              ),
          ],
        );
      }),
    );
  }

  Widget _buildGridItem(String option) {
    bool isSelected = option == selectedOptions;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptions = option;
        });
      },
      child: Card(
        elevation: 0,
        color: isSelected ? Colors.green : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? Colors.green : const Color(0xFFE5E5E5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              option,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
