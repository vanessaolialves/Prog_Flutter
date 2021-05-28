import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

//botoes para a tela inicial, [para trabalho, pausa longa, pausa curta, parar e começar]
//ProductivityButton -> ProductButton
class ProductButton extends StatelessWidget {
  //aqui eu tenho os atributos da minha classe
  //color -> cor
  final Color cor;
  //text -> nome
  final String nome;
  //size -> tamanho
  final double tamanho;
  //onPressed -> clica
  final VoidCallback clica;

  //@required é para quando um atributo é obrigatorio
  ProductButton(
      {@required this.cor,
      @required this.nome,
      @required this.clica,
      this.tamanho});
  //aqui eu tenho as definiçoes de como será criado esses botoes
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.nome, style: TextStyle(color: Colors.white)),
      onPressed: this.clica,
      color: this.cor,
      minWidth: this.tamanho,
    );
  }
}

//botoes para as configurações, para adicionar e subtrair um valor
class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;

  SettingsButton(this.color, this.text, this.size, this.value, this.setting,
      this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text, style: TextStyle(color: Colors.white)),
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
      minWidth: this.size,
    );
    /*return Container(
    );*/
  }
}
