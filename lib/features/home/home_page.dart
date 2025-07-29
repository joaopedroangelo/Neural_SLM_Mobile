import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_app/features/settings/settings_page.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_app/features/chat/chat_page.dart';
import 'package:flutter_app/features/consulta/consulta_menu_page.dart';
import 'package:flutter_app/features/menus/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Mova a lista para dentro do build para ter acesso ao context
    final items = [
      MenuItem('Suas Informações', Icons.person, () {
        // TODO: navegar para Suas Informações
      }),
      MenuItem('Consulta', Icons.medical_services, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ConsultaMenuPage()),
        );
      }),
      MenuItem('Chat', Icons.chat, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChatPage()),
        );
      }),
      MenuItem('Histórico', Icons.history, () {
        // TODO: Histórico
      }),
      MenuItem('Configurações', Icons.settings, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsPage()),
        );
      }),
      MenuItem('Sobre', Icons.info, () {
        // TODO: Sobre
      }),
    ];

    return NeumorphicBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              // animação Lottie
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: -8,
                    boxShape: NeumorphicBoxShape.circle(),
                    intensity: 0.7,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Lottie.asset(
                      'assets/common/heart_dementia_doctor.json',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // grid de botões
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
                      return NeumorphicButton(
                        onPressed: item.onTap,
                        style: NeumorphicStyle(
                          depth: 6,
                          intensity: 0.8,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 32, color: Colors.blueGrey),
                            const SizedBox(height: 8),
                            Text(
                              item.label, // ajuste se o campo do MenuItem for 'name'
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
    );
  }
}
