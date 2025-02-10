import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyPadButtonWidget extends StatelessWidget {
  final ValueChanged<String> onTap;

  KeyPadButtonWidget({super.key, required this.onTap});

  final List<String> _digits = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "x",
    "0",
    "✓",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: _digits.length,
          itemBuilder: (context, index) {
            return _keyPadButton(digit: _digits[index]);
          },
        )
      ],
    );
  }

  Widget _keyPadButton({required String digit}) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      child: Material(
        color: Colors.grey.shade200,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(), // Ensure ripple is circular
          splashColor: Colors.purple.withOpacity(0.3), // Ripple color
          onTap: () => onTap(digit),
          child: Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            child: Text(
              digit,
              style: GoogleFonts.poppins(
                fontSize: 28,
                color: digit == 'x'
                    ? Colors.red
                    : digit == '✓'
                        ? Colors.green
                        : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
