import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vot_configuration_controller.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key});
  final VotConfigurationController controller = Get.find<VotConfigurationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Voting Results',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        var sortedResults = controller.getSortedResults();
        var highestVotedOptions = controller.getHighestVotedOptions();

        if (sortedResults.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        } else {

          // highVotes fiend
          int highestVotes = sortedResults.first.value;
          //if the highest votes are 0, then no winner will be shown
          bool noWinner = highestVotes == 0;
          //  if multiple options get the same highest votes (and not 0), then it's a tie
          bool isTie = highestVotedOptions.length > 1 && !noWinner;

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: sortedResults.length,
                  itemBuilder: (context, index) {
                    String option = sortedResults[index].key;
                    int count = sortedResults[index].value;

                    bool isHighestVoted = highestVotedOptions.contains(option) && count > 0;

                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isHighestVoted ? Colors.green : const Color(0xFFE5E5E5),
                        ),
                      ),
                      color: isHighestVoted ? Colors.green[100] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              option,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isHighestVoted ? Colors.green[900] : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$count votes',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: isHighestVoted ? Colors.green[900] : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // উইনার বা টাই মেসেজ দেখানো হবে (যদি সর্বাধিক ভোট ০ না হয়)
              if (!noWinner)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    isTie
                        ? "It's a tie!"
                        : 'Winner: ${highestVotedOptions.join(", ")}',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ],
          );
        }
      }),
    );
  }
}
