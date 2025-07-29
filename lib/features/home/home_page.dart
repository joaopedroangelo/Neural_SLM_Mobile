import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; // Efeitos visuais 3D.
import 'package:flutter_app/features/settings/settings_page.dart'; // Página de configurações.
import 'package:lottie/lottie.dart'; // Animações JSON.
import 'package:flutter_app/features/chat/chat_page.dart'; // Página de chat.
import 'package:flutter_app/features/consulta/consulta_menu_page.dart'; // Página de menu de consulta.
import 'package:flutter_app/features/menus/menu_item.dart'; // Definição de item do menu.

class HomePage extends StatefulWidget {
  // Widget da página inicial com estado mutável.
  const HomePage({super.key, required this.title}); // Construtor da HomePage.
  final String title; // Título da página.

  @override
  State<HomePage> createState() => _HomePageState(); // Cria o estado da HomePage.
}

class _HomePageState extends State<HomePage> {
  // Gerencia o estado e a UI da HomePage.
  @override
  Widget build(BuildContext context) {
    // Constrói a interface do usuário.

    final items = [
      // Lista de itens do menu.
      MenuItem('Suas Informações', Icons.person, () {
        // Item para informações pessoais.
        // TODO: navegar para Suas Informações // Ação a ser implementada.
      }),
      MenuItem('Consulta', Icons.medical_services, () {
        // Item para consulta.
        // Adiciona um atraso de 150 milissegundos antes de navegar.
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConsultaMenuPage()),
          );
        });
      }),
      MenuItem('Chat', Icons.chat, () {
        // Item para chat.
        // Adiciona um atraso de 150 milissegundos antes de navegar.
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatPage()),
          );
        });
      }),
      MenuItem('Histórico', Icons.history, () {
        // Item para histórico.
        // TODO: Histórico // Ação a ser implementada.
      }),
      MenuItem('Configurações', Icons.settings, () {
        // Item para configurações.
        // Adiciona um atraso de 150 milissegundos antes de navegar.
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          );
        });
      }),
      MenuItem('Sobre', Icons.info, () {
        // Item para informações "Sobre".
        // TODO: Sobre // Ação a ser implementada.
      }),
    ];

    const Color aquaGreenConsistent = Color(
      0xFF4DB6AC,
    ); // Define uma cor verde água.

    // Nova cor de fundo: cinza muito claro/off-white para suavidade e conforto visual.
    const Color backgroundSoftGray = Color(0xFFF5F5F5);

    // Nova cor para textos principais: cinza escuro, mais suave que o preto puro.
    const Color textDarkGray = Color(0xFF333333);

    return NeumorphicBackground(
      // Fundo com efeito Neumorphic.
      // A cor do NeumorphicBackground agora será o cinza suave.
      // Ajustamos a cor do NeumorphicTheme para que o efeito seja aplicado sobre a cor de fundo escolhida.
      child: NeumorphicTheme(
        // Adiciona NeumorphicTheme para configurar a cor de base.
        theme: NeumorphicThemeData(
          baseColor:
              backgroundSoftGray, // Define a cor de base para os efeitos Neumorphic.
          lightSource:
              LightSource.topLeft, // Define a direção da luz para o efeito 3D.
          depth: 10, // Profundidade padrão para elementos Neumorphic.
        ),
        child: Scaffold(
          // Estrutura básica da tela.
          backgroundColor: Colors.transparent, // Fundo transparente.
          body: SafeArea(
            // Garante que o conteúdo não seja cortado por elementos do sistema.
            child: Column(
              // Organiza os widgets verticalmente.
              children: [
                Padding(
                  // Espaçamento para a animação.
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Neumorphic(
                    // Container com efeito Neumorphic para a animação.
                    style: NeumorphicStyle(
                      depth: -8, // Efeito de afundamento.
                      boxShape: NeumorphicBoxShape.circle(), // Forma circular.
                      intensity: 0.7, // Intensidade do efeito.
                      color:
                          backgroundSoftGray, // Cor de fundo do círculo Neumorphic da animação.
                    ),
                    child: Padding(
                      // Espaçamento interno da animação.
                      padding: const EdgeInsets.all(20.0),
                      child: Lottie.asset(
                        // Exibe a animação Lottie.
                        'assets/common/heart_dementia_doctor.json', // Caminho do arquivo da animação.
                        height: 130, // Altura da animação.
                        fit: BoxFit.contain, // Ajuste da animação.
                      ),
                    ),
                  ),
                ),

                Expanded(
                  // Ocupa o espaço restante para o grid de botões.
                  child: Padding(
                    // Espaçamento horizontal para o grid.
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      // Constrói a grade de botões.
                      itemCount: items.length, // Número de itens no grid.
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 colunas.
                            mainAxisSpacing:
                                24, // Espaçamento vertical entre os itens.
                            crossAxisSpacing:
                                24, // Espaçamento horizontal entre os itens.
                            childAspectRatio:
                                1.3, // Proporção largura/altura dos itens.
                          ),
                      itemBuilder: (context, index) {
                        // Constrói cada item do grid.
                        final item = items[index]; // Item do menu atual.
                        return NeumorphicButton(
                          // Botão com efeito Neumorphic.
                          onPressed: item.onTap, // Ação ao pressionar o botão.
                          style: NeumorphicStyle(
                            // Estilo do botão Neumorphic.
                            depth: 8, // Efeito de relevo.
                            intensity: 1, // Intensidade do efeito.
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(14), // Cantos arredondados.
                            ),
                            color:
                                backgroundSoftGray, // Cor de fundo do botão Neumorphic.
                          ),
                          child: Column(
                            // Conteúdo do botão (ícone e texto).
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centraliza o conteúdo.
                            children: [
                              Icon(
                                item.icon,
                                size: 34,
                                color:
                                    aquaGreenConsistent, // Ícone do botão (cor verde água).
                              ),
                              const SizedBox(
                                height: 8,
                              ), // Espaço entre ícone e texto.
                              Text(
                                item.label, // Texto do botão.
                                textAlign:
                                    TextAlign.center, // Alinhamento do texto.
                                style: TextStyle(
                                  // Usamos TextStyle diretamente pois a cor será dinâmica.
                                  fontSize: 16.4, // Tamanho da fonte.
                                  fontWeight: FontWeight
                                      .w600, // Peso da fonte (negrito).
                                  color:
                                      textDarkGray, // Cor do texto (cinza escuro).
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
