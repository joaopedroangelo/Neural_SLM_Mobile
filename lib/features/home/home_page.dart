import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../testes/avaliable_models.dart';
import '../../testes/chat/chat_screen.dart';
import '../settings/settings_page.dart';
import '../consulta/consulta_menu_page.dart';
import '../menus/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Model _preferredModel = Model.llama3_2_1bInstruct; // fallback padrão

  @override
  void initState() {
    super.initState();
    _loadPreferredModel();
  }

  Future<void> _loadPreferredModel() async {
    final prefs = await SharedPreferences.getInstance();
    final modelName = prefs.getString("preferredModel");

    if (modelName != null) {
      try {
        setState(() {
          _preferredModel = Model.values.firstWhere((m) => m.name == modelName);
        });
      } catch (_) {
        _preferredModel = Model.llama3_2_1bInstruct;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      MenuItem('Suas Informações', Icons.person, () {
        // TODO: Navegar para a página de informações pessoais
      }),
      MenuItem('Consulta', Icons.medical_services, () {
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConsultaMenuPage()),
          );
        });
      }),
      MenuItem('Chat', Icons.chat, () {
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(model: _preferredModel),
            ),
          );
        });
      }),
      MenuItem('Histórico', Icons.history, () {
        // TODO: Navegar para a página de histórico
      }),
      MenuItem('Configurações', Icons.settings, () {
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          );
        });
      }),
      MenuItem('Sobre', Icons.info, () {
        // TODO: Navegar para a página Sobre
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
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: -8,
                      boxShape: NeumorphicBoxShape.circle(),
                      intensity: 0.7,
                      color: backgroundSoftGray,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Lottie.asset(
                        'assets/common/heart_dementia_doctor.json',
                        height: 130,
                        fit: BoxFit.contain,
                      ),
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
                          onPressed: item.onTap,
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
