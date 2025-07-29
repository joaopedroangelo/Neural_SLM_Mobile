import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/features/home/home_page.dart';
import 'package:flutter_app/features/skin_cancer/skin_cancer_main.dart';

class ConsultaMenuPage extends StatelessWidget {
  const ConsultaMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _ConsultaMenuItem('Analisar Raio X', Icons.medical_information, () {
        // TODO: ação para análise de raio x
      }),
      _ConsultaMenuItem('Analisar Exame Clínico', Icons.document_scanner, () {
        // TODO: ação para exame clínico
      }),
      _ConsultaMenuItem('Informar Sintomas', Icons.sick, () {
        // TODO: ação para informar sintomas
      }),
      _ConsultaMenuItem('Mancha de Pele', Icons.visibility, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SkinCancer()),
        );
      }),
      _ConsultaMenuItem('Doação de Sangue', Icons.bloodtype, () {
        // TODO: ação para doação de sangue
      }),
      _ConsultaMenuItem('Menu Principal', Icons.home, () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(title: 'Assistente Médico'),
          ),
          (route) => false,
        );
      }),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('Iniciar Consulta'),
                backgroundColor: const Color(0xFF50A3C4),
                elevation: 0,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 1.1,
                        ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _ConsultaMenuCard(item: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConsultaMenuItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  _ConsultaMenuItem(this.label, this.icon, this.onTap);
}

class _ConsultaMenuCard extends StatefulWidget {
  const _ConsultaMenuCard({required this.item});
  final _ConsultaMenuItem item;

  @override
  State<_ConsultaMenuCard> createState() => _ConsultaMenuCardState();
}

class _ConsultaMenuCardState extends State<_ConsultaMenuCard> {
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
                    color: const Color(0xFF4DB6AC),
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
