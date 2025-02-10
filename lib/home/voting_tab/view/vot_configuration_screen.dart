import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widget/widget_button.dart';
import '../../controller/vot_configuration_controller.dart';

class VotConfigurationScreen extends StatelessWidget {
  VotConfigurationScreen({super.key});

  final VotConfigurationController controller =
      Get.put(VotConfigurationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Voting Configuration',
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            Obx(() => Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFFE5E5E5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: controller.updateTitle,
                          controller: controller.titleController,
                          decoration: InputDecoration(
                            label: Text('Title',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFFB1B1B1))),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        if (controller.titleError.isNotEmpty)
                          Text(
                            controller.titleError.value,
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() =>
                Text(controller.title.isNotEmpty ? controller.title.value : '',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center)),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller.newOptionController,
                      decoration: InputDecoration(
                        label: Text('Option',
                            style: GoogleFonts.poppins(
                                color: const Color(0xFFB1B1B1))),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    Obx(() => controller.optionError.isNotEmpty
                        ? Text(
                            controller.optionError.value,
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 12),
                          )
                        : Container()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: controller.addOption,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF8F8CFE),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          const Icon(Icons.add, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add Option",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.options.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            controller.options[index],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WidgetButton(
                  title: 'Reset',
                  onTap: controller.resetConfig,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                WidgetButton(
                  title: 'Save',
                  onTap: controller.saveConfig,
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
