import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
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

    const Color aquaGreenConsistent = Color(0xFF4DB6AC);
    const Color backgroundSoftGray = Color(0xFFF5F5F5);
    const Color textDarkGray = Color(0xFF333333);

    return NeumorphicBackground(
      child: NeumorphicTheme(
        theme: NeumorphicThemeData(
          baseColor: backgroundSoftGray,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Iniciar Consulta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textDarkGray,
                    ),
                  ),
                ),
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
                            childAspectRatio: 1.3,
                          ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return NeumorphicButton(
                          onPressed: () {
                            Future.delayed(
                              const Duration(milliseconds: 120),
                              () {
                                item.onTap();
                              },
                            );
                          },
                          style: NeumorphicStyle(
                            depth: 8,
                            intensity: 1,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(14),
                            ),
                            color: backgroundSoftGray,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.icon,
                                size: 34,
                                color: aquaGreenConsistent,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.4,
                                  fontWeight: FontWeight.w600,
                                  color: textDarkGray,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
