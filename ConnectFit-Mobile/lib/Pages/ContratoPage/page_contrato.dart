import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_contratos.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_profissionais.dart';
import 'package:projeto/Shared/Blocs/funcos_datas.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';

class PageContrato extends StatefulWidget {
  const PageContrato({super.key});

  @override
  State<PageContrato> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageContrato> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  List<Map<String, dynamic>> contratos = [];
  List<Map<String, dynamic>> filteredContratos = [];

  Future<void> loadData() async {
    await FetchContratos.fetchContratos().then((data) async {
      debugPrint("$data");
      for (var contrato in data) {
        var idProfissional = contrato["idPessoaProfissional"];
        await FetchProfissonais.fetchProfissional(idProfissional)
            .then((profissionalData) {
          contrato['DadosProfissional'] = profissionalData;
        });
      }

      setState(() {
        contratos = data;
        filteredContratos = data;
        isLoading = false;
      });
    });
  }

  void filterByName(String query) {
    setState(() {
      filteredContratos = contratos
          .where((contrato) => contrato["DadosProfissional"]["User"]["name"]
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
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
        title: Text('Contratos'),
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
                      child: SizedBox(
                        height: 35,
                        child: CustomTextField(
                          label: 'Buscar',
                          onChanged: (query) {
                            filterByName(query);
                          },
                          controller: _searchController,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: contratos.isEmpty
                          ? const Center(
                              child: CustomText(
                                text: 'Você ainda não possui contratos.',
                                color: Colors.brancoBege,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredContratos.length,
                              itemBuilder: (context, index) {
                                var contrato = filteredContratos[index];
                                var createdAt = contrato["created_at"];
                                var valor = contrato["valor"];
                                var nome = contrato["DadosProfissional"]["User"]
                                    ["name"];
                                var numReg = contrato["DadosProfissional"]
                                    ["PessoaProfissional"]["numReg"];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    color: Colors.grey[800],
                                    child: Row(
                                      children: <Widget>[
                                        const SizedBox(width: 5),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              CustomRowText(
                                                fontSize: 13.5,
                                                indicador: 'Personal',
                                                valor: '$nome',
                                              ),
                                              const SizedBox(height: 10),
                                              CustomRowText(
                                                fontSize: 13.5,
                                                indicador: 'Registro',
                                                valor: '$numReg',
                                              ),
                                              const SizedBox(height: 10),
                                              CustomRowText(
                                                fontSize: 13.5,
                                                indicador: 'Data Inicio',
                                                valor:
                                                    FormatarDatas.formatarData(
                                                        createdAt),
                                              ),
                                              const SizedBox(height: 10),
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
