import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voting_app/home/dashboard_tab/view/dashboard_tab_screen.dart';
import 'package:voting_app/home/voting_tab/view/voting_tab_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 50),
            TabBar(
              tabs: [
                Tab(
                  icon: const Icon(Icons.poll, size: 30),
                  child: Text(
                    'Voting',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                Tab(
                  icon: const Icon(Icons.dashboard, size: 30),
                  child: Text(
                    'Dashboard',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const VotingTabScreen(),
                  DashboardTabScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
