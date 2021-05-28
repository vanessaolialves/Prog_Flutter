import 'package:flutter/material.dart';
import './widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './timermodel.dart';
import './settings.dart';

/*
 *Alunas: 
 *        Giovanna de Sousa Sampaio
 *        Vanessa Oliveira Alves
 * 
**/

//iniciação do aplicativo
void main() {
  runApp(MyApp());
}

//classe para criação do designer principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //aqui seria My Work Timer, mas vou alterar para portugues
      //só pra alterar um pouco
      title: 'Meu Tempo de Trabalho',
      //a cor era bluegrey, mudei para rosa
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      //faziamos a inclusão dos itens no home direto,
      //agora temos uma classe que faz essa alteração pra gente
      home: TimerHP(),

      /** Primeira modificação
       *Scaffold(
       * //os nomes foram alterados para portugues
       *appBar: AppBar(
       *   title: Text('Meu Tempo de Trabalho'),
       * ),
       * body: Center(
       *   child:Text('Meu Tempo de Trabalho'),
       * ),
       *),
      **/
    );
  }
}

//classe que contem o designer do menu principal
//TimerHomePage -> TimerHP
class TimerHP extends StatelessWidget {
  //constante para preenchimento padrão
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    //ignore: deprecated_member_use
    List<PopupMenuItem<String>> menuItems = [];
    // final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      //Não mudou aqui porque é o nome do botão
      value: 'Settings',
      //Settings -> Configurações
      child: Text('Configurações'),
    ));

    timer.startWork();

    return Scaffold(
        //aqui temos o inicial com o nome e as configurações
        appBar: AppBar(
          title: Text('Meu Tempo de Trabalho'),
          actions: [
            PopupMenuButton<String>(itemBuilder: (BuildContext context) {
              return menuItems.toList();
            }, onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            })
          ],
        ),
        //aqui temos o restante do aplicativo
        //dividido entre os três primeiros botões
        //o tem que será mostrado
        //os dois ultimos botoes

        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(children: [
            //as definições dos tres primeiros botoes
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductButton(
                        //Work -> Trabalho
                        cor: Color(0xff512DA8),
                        nome: "Trabalho",
                        clica: () => timer.startWork())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductButton(
                        //Short Break -> Pausa Curta
                        cor: Color(0xff9C27B0),
                        nome: "Pausa Curta",
                        clica: () => timer.startBreak(true))),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductButton(
                        //Long Break -> Pausa longa
                        cor: Color(0xff966AC7),
                        nome: "Pausa Longa",
                        clica: () => timer.startBreak(false))),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            //pegamos o espaço para os botoes e o restante para o tempo
            Expanded(
              child: StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data;
                    return Expanded(
                        child: CircularPercentIndicator(
                      radius: availableWidth / 2,
                      lineWidth: 10.0,
                      percent: timer.porcentagem,
                      center: Text(timer.tempo,
                          style: Theme.of(context).textTheme.headline4),
                      progressColor: Color(0xffC2185B),
                    ));
                  }),

              /*
            child: CircularPercentIndicator(
                radius: availableWidth / 2,
                lineWidth: 10.0,
                percent: timer.percent,
                center: Text( 
                  timer.time,
                  style: Theme.of(context).textTheme.headline4
                ),
                progressColor: Color(0xff009688),

              /**Como definimos o relogio inicialmente
               *radius: availableWidth / 2,
               *lineWidth: 10.0,
               *percent: 1,
               *center: Text(
               *  "30:00",
               *  style: Theme.of(context).textTheme.headline4
               *),
               *progressColor: Color(0xffC2185B),
              **/
            ),
            */
            ),
            //os dois ultimos botoes
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductButton(
                        //Stop -> Parar
                        cor: Color(0xff512DA8),
                        nome: "Parar",
                        clica: () => timer.stopTimer())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductButton(
                        //Restart -> Começar
                        cor: Color(0xffC2185B),
                        nome: "Começar",
                        clica: () => timer.startTimer())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            )
          ]);
        }));
  }

  //esse metodo será temporario
  void emptyMethod() {}

  //função para chamar as configurações
  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}
