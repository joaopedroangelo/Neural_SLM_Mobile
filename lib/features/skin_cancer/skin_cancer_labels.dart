class SkinCancerLabels {
  /// Recebe o código retornado pelo modelo e retorna a descrição em Markdown.
  static String mapLabel(String code) {
    switch (code) {
      case 'nv':
        return '''
**Nevus Melanocítico (Nevus)**  
- Manchas benignas de pele, geralmente marrons.  
- **O que fazer:** monitore mudanças de tamanho, borda ou cor.  
- **Dicas:** tire fotos periódicas e compare; consulte o dermatologista se notar alterações.
''';
      case 'mel':
        return '''
**Melanoma**  
- Tumor maligno que surge dos melanócitos.  
- **O que fazer:** procure atendimento médico imediato.  
- **Dicas:** observe o padrão _ABCDE_ (Assimetria, Bordas irregulares, Cores variadas, Diâmetro >6 mm, Evolução).
''';
      case 'bkl':
        return '''
**Queratoses Seborreicas (BKL)**  
- Lesões benignas, de aspecto escamoso e "coladas" à pele.  
- **O que fazer:** em geral, não requer tratamento.  
- **Dicas:** se causarem coceira ou incômodo estético, fale com o dermatologista.
''';
      case 'bcc':
        return '''
**Carcinoma Basocelular (BCC)**  
- Tipo mais comum de câncer de pele, cresce lentamente.  
- **O que fazer:** remoção cirúrgica ou crioterapia.  
- **Dicas:** evite exposição solar sem proteção e use filtro diariamente.
''';
      case 'akiec':
        return '''
**Queratoses Actínicas (AKIEC)**  
- Lesões pré‑cancerosas causadas pelo sol.  
- **O que fazer:** crioterapia ou cremes prescritos.  
- **Dicas:** proteja-se do sol, use chapéu e filtro fator alto.
''';
      case 'vasc':
        return '''
**Lesões Vasculares (VASC)**  
- Manchas por vasos sanguíneos dilatados (ex.: angiomas).  
- **O que fazer:** benignas, mas podem ser removidas a laser.  
- **Dicas:** monitore e consulte especialista se crescerem.
''';
      case 'df':
        return '''
**Dermatofibroma (DF)**  
- Nódulos benignos de tecido conjuntivo.  
- **O que fazer:** sem tratamento, exceto por estética.  
- **Dicas:** se mudarem rápido ou de cor, faça avaliação médica.
''';
      default:
        return '**Resultado desconhecido:** $code';
    }
  }
}
