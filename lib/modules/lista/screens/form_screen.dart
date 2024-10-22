import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_bloc_cubit/modules/lista/cubits/list_itens_cubit.dart';

class FormScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar/Consultar itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome.';
                  }
                  return null; // Se o campo é válido
                },
                decoration: const InputDecoration(labelText: 'Digite o item'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final cubit = context.read<ListItensCubit>();
                    bool exists = await cubit.itemExists(controller.text);
                    if (exists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Item já existe na lista!')),
                      );
                      return;
                    } else {
                      cubit.addItem(controller.text); // Adiciona o item
                      controller.clear(); // Limpa o campo de texto
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item adicionado!')),
                      );
                    }
                  }
                },
                child: const Text('Adicionar'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final cubit = context.read<ListItensCubit>();
                    bool exists = await cubit.itemExists(controller.text);
                    String message = exists
                        ? 'Item "${controller.text}" existe na lista.'
                        : 'Item "${controller.text}" não encontrado.';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                },
                child: const Text('Buscar Item'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final cubit = context.read<ListItensCubit>();
                    String message = '';
                    bool exists = await cubit.itemExists(controller.text);
                    if (exists) {
                      await cubit.deleteItem(controller.text);
                      message = 'Item "${controller.text}" deletado';
                      controller.clear(); // Limpa o campo de texto
                    } else {
                      message =
                          'Item "${controller.text}" não existe na lista. Não há como deletar!';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                },
                child: const Text('Deletar Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
