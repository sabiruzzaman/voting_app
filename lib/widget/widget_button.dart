import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final double width;

  const WidgetButton({super.key, required this.title, required this.onTap, required this.color, required this.width});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 65,
          width: width,
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
