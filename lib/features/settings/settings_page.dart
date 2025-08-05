import 'package:flutter/material.dart';
import 'package:flutter_app/testes/default_model_screen.dart';
import 'package:flutter_app/testes/model_selection_screen.dart';
import 'package:flutter_app/testes/avaliable_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Model? _defaultModel;

  @override
  void initState() {
    super.initState();
    _loadDefaultModel();
  }

  Future<void> _loadDefaultModel() async {
    final prefs = await SharedPreferences.getInstance();
    final modelName = prefs.getString('default_model');
    setState(() {
      _defaultModel = Model.values.firstWhere(
        (m) => m.name == modelName,
        orElse: () => Model.llama3_2_1bInstruct, // fallback padrão
      );
    });
  }

  Future<void> _selectNewDefaultModel() async {
    final selected = await Navigator.push<Model>(
      context,
      MaterialPageRoute(builder: (_) => const DefaultModelSelectorScreen()),
    );
    if (selected != null) {
      setState(() => _defaultModel = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2EBF2), Color(0xFFE0F7FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar customizada
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Configurações',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: [
                    _buildCard(
                      icon: Icons.memory,
                      iconColor: const Color(0xFF4DB6AC),
                      label: 'Gerenciar Modelos LLM',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ModelSelectionScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildCard(
                      icon: Icons.star_rate,
                      iconColor: const Color(0xFF7E57C2),
                      label:
                          'Modelo Padrão: ${_defaultModel?.displayName ?? "Llama 1B"}',
                      onTap: _selectNewDefaultModel,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            children: [
              Icon(icon, size: 28, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(label, style: GoogleFonts.poppins(fontSize: 16)),
              ),
              const Icon(Icons.chevron_right, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}
