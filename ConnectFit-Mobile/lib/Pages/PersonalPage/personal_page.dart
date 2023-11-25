import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:projeto/Pages/PersonalPage/detalhes_personal.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_profissionais.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  bool isLoading = true;
  List<Map<String, dynamic>> profissionais = [];

  Future<void> loadData() async {
    await FetchProfissonais.fetchAllProfissionais().then((data) {
      setState(() {
        profissionais = data;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        automaticallyImplyLeading: false,
        title: Text('Buscar Personal'),
        actions: [],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: SizedBox(
                              height: 25,
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  filled: true,
                                  fillColor: Colors.brancoBege,
                                  labelText: 'Buscar',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.brancoBege,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.filter_alt),
                            color: Colors.brancoBege,
                            iconSize: 30,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profissionais.length,
                        itemBuilder: (context, index) {
                          var profissional = profissionais[index];
                          var userName = profissional["User"]["name"];
                          var id = profissional["User"]["id"];
                          var valor =
                              profissional["PessoaProfissional"]["valor"];
                          List<String> especialidades = [];
                          for (var lista in profissional["Especialidades"]) {
                            for (var especialidade in lista) {
                              especialidades.add(especialidade['descricao']);
                            }
                          }
                          return InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            splashColor: Colors.brancoBege,
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      DetalhesPersonal(id: id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Colors.grey[800],
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ProfilePicture(
                                        name: userName,
                                        radius: 30,
                                        fontsize: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Nome',
                                            valor: userName,
                                          ),
                                          const SizedBox(height: 5),
                                          const SizedBox(height: 5),
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Valor cobrado',
                                            valor: 'R\$ $valor',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
