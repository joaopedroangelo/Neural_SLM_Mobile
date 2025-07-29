import 'package:flutter/material.dart';
import 'package:flutter_app/screens/menus/menu_item.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({super.key, required this.item});
  final MenuItem item;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _pressed ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() => _pressed = true);
              Future.delayed(const Duration(milliseconds: 120), () {
                setState(() => _pressed = false);
                widget.item.onTap();
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.item.icon,
                    size: 36,
                    color: const Color(0xFF5C6BC0),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
