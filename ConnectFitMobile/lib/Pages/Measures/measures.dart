import 'package:flutter/material.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class MeasuresPage extends StatefulWidget {
  const MeasuresPage({super.key});

  @override
  State<MeasuresPage> createState() => _MeasuresPageState();
}

class _MeasuresPageState extends State<MeasuresPage> {
  final abdominalEC = TextEditingController();
  final axilarMediaEC = TextEditingController();
  final femuralMediaEC = TextEditingController();
  final peitoralEC = TextEditingController();
  final percentualEC = TextEditingController();
  final pesoEC = TextEditingController();
  final subescapularEC = TextEditingController();
  final supraIliacaEC = TextEditingController();
  final tricepsEC = TextEditingController();
  MedidasModel? model;

  testeDados(String nome) {
    debugPrint("opa");
    setState(() {
      if (nome == "abdominaEC") {
        model = MedidasModel(abdominal: abdominalEC.text);
      } else if (nome == "axilarMediaEC") {
        model = MedidasModel(axilarMedia: axilarMediaEC.text);
      } else if (nome == "femuralMediaEC") {
        model = MedidasModel(femuralMedia: femuralMediaEC.text);
      } else if (nome == "peitoralEC") {
        model = MedidasModel(peitoral: peitoralEC.text);
      } else if (nome == "percentualEC") {
        model = MedidasModel(percentual: percentualEC.text);
      } else if (nome == "pesoEC") {
        model = MedidasModel(peso: pesoEC.text);
      } else if (nome == "subescapularEC") {
        model = MedidasModel(subescapular: subescapularEC.text);
      } else if (nome == "supraIliacaEC") {
        model = MedidasModel(supraIliaca: supraIliacaEC.text);
      } else if (nome == "tricepsEC") {
        model = MedidasModel(triceps: tricepsEC.text);
      }
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: CustomText(
            text: "Medidas",
            isBold: true,
          ),
          actions: [],
        ),
        body: Column(
          children: [
            MedidasButton(
              nomeMedida: "Peso",
              valorMedida: model?.peso ?? 'Não definido',
              controller: pesoEC,
              funcao: () => testeDados("pesoEC"),
            ),
            MedidasButton(
              nomeMedida: "Percentual de Gordura",
              valorMedida: model?.percentual ?? 'Não definido',
              controller: percentualEC,
              funcao: () => testeDados("percentualEC"),
            ),
            MedidasButton(
              nomeMedida: "Subescapular",
              valorMedida: model?.subescapular ?? 'Não definido',
              controller: subescapularEC,
              funcao: () => testeDados("subescapularEC"),
            ),
            MedidasButton(
              nomeMedida: "Triceps",
              valorMedida: model?.triceps ?? 'Não definido',
              controller: tricepsEC,
              funcao: () => testeDados("tricepsEC"),
            ),
            MedidasButton(
              nomeMedida: "Peitoral",
              valorMedida: model?.peitoral ?? 'Não definido',
              controller: peitoralEC,
              funcao: () => testeDados("peitoralEC"),
            ),
            MedidasButton(
              nomeMedida: "Axilar Media",
              valorMedida: model?.axilarMedia ?? 'Não definido',
              controller: axilarMediaEC,
              funcao: () => testeDados("axilarMediaEC"),
            ),
            MedidasButton(
              nomeMedida: "SupraIliaca",
              valorMedida: model?.supraIliaca ?? 'Não definido',
              controller: supraIliacaEC,
              funcao: () => testeDados("supraIliacaEC"),
            ),
            MedidasButton(
              nomeMedida: "Abdominal",
              valorMedida: model?.abdominal ?? 'Não definido',
              controller: abdominalEC,
              funcao: () => testeDados("abdominalEC"),
            ),
            MedidasButton(
              nomeMedida: "FemuralMedia",
              valorMedida: model?.femuralMedia ?? 'Não definido',
              controller: femuralMediaEC,
              funcao: () => testeDados("femuralMediaEC"),
            ),
          ],
        ));
  }
}

class MedidasButton extends StatelessWidget {
  final String nomeMedida;
  final String valorMedida;
  final TextEditingController controller;
  final void Function() funcao;
  const MedidasButton({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.controller,
    required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: OutlinedButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CustomText(
                    text: 'Insira a nova medida:',
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  TextField(
                    controller: controller,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      funcao();
                      Navigator.pop(context);
                    },
                    child: const Text('Inserir'),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                CustomText(text: "$nomeMedida: ", isBold: true, fontSize: 15),
                CustomText(text: valorMedida, isBold: false, fontSize: 15),
              ],
            ),
            const Icon(
              Icons.create_outlined,
              color: Colors.brancoBege,
            )
          ],
        ),
      ),
    );
  }
}
