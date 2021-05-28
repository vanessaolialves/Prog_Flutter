import 'package:flutter/material.dart';
import './widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Inicial da pagina de configurações
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Settings()

        /*Primeir definiu isso aqui apenas para criamos o inicial das configurações
          depois alteramos para Settings que tem o design
        Container(
        child: Text('Hello World!!!'),
      )*/
        );
  }
}

//Para criar o designer da tela, por ela ser StatefulWidget -> ela tem um status que se altera
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

//classe que definiu o design da tela e armazena informações
class _SettingsState extends State<Settings> {
  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  double buttonSize = 5.0;

  int workTime;
  int shortBreak;
  int longBreak;

  //onde estão armazenados as preferencias dos usuarios
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        //Work -> Trabalho e vou passar pro meio
        Text("Trabalho", style: textStyle),
        Text(""),
        Text(""),
        //Criamos o Seetings sem os dois ultimos itens e alteramos isso depois
        SettingsButton(
            Color(0xff966AC7), "-", buttonSize, -1, WORKTIME, updateSetting),
        TextField(
            style: textStyle,
            //adicionamos isso depois
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(
            Color(0xffC2185B), "+", buttonSize, 1, WORKTIME, updateSetting),

        //Short -> Curta
        Text("Pausa ", style: textStyle),
        Text("Curta", style: textStyle),
        Text(""),
        SettingsButton(
            Color(0xff966AC7), "-", buttonSize, -1, SHORTBREAK, updateSetting),

        TextField(
            style: textStyle,
            controller: txtShort,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(
            Color(0xffC2185B), "+", buttonSize, 1, SHORTBREAK, updateSetting),

        //Long -> longa
        Text("Pausa ", style: textStyle),
        Text("Longa", style: textStyle),
        Text(""),
        SettingsButton(
            Color(0xff966AC7), "-", buttonSize, -1, LONGBREAK, updateSetting),
        TextField(
            style: textStyle,
            controller: txtLong,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(
            Color(0xffC2185B), "+", buttonSize, 1, LONGBREAK, updateSetting),
      ],
      padding: const EdgeInsets.all(20.0),
    ));
  }

  //Quando eu inicializo minha pagina de configurações
  @override
  void initState() {
    /*TextEditingController txtWork = TextEditingController();
    TextEditingController txtShort = TextEditingController();
    TextEditingController txtLong = TextEditingController();
    */
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  //ler as preferencias do usuario já salvas
  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      workTime = 30;
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      shortBreak = 5;
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      longBreak = 20;
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  //atualização dos dados -> quando clico nos botoes
  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK);
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
