import 'package:accident_registration/models/product_model.dart';
import 'package:accident_registration/models/store_model.dart';
import 'package:accident_registration/resource/string_resource.dart';
import 'package:accident_registration/services/hive_provider.dart';
import 'package:flutter/material.dart';

enum AddItemPageType { store, product }

class AddItemPage extends StatefulWidget {
  const AddItemPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final AddItemPageType type;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late final List<TextEditingController> textEditingControllers;
  late final List<GlobalKey<FormState>> formKeys;

  int get formsLength => widget.type == AddItemPageType.store ? 2 : 3;

  @override
  void initState() {
    textEditingControllers =
        List.generate(formsLength, (index) => TextEditingController());
    formKeys = List.generate(formsLength, (index) => GlobalKey<FormState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            formsLength + 1,
            (index) {
              final buttonIndex = widget.type == AddItemPageType.store ? 2 : 3;
              if (index == buttonIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKeys.every(
                          (element) => element.currentState!.validate())) {
                        if (widget.type == AddItemPageType.store) {
                          await HiveProvider.saveStore(
                            StoreModel.fromTexts(
                              textEditingControllers
                                  .map((e) => e.text)
                                  .toList(),
                            ),
                          );
                        } else {
                          await HiveProvider.saveProduct(
                            ProductModel.fromTexts(
                              textEditingControllers
                                  .map((e) => e.text)
                                  .toList(),
                            ),
                          );
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(StringResource.addItem.done),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKeys[index],
                  child: TextFormField(
                    controller: textEditingControllers[index],
                    keyboardType:
                        widget.type == AddItemPageType.product && index == 2
                            ? TextInputType.number
                            : null,
                    readOnly:
                        widget.type == AddItemPageType.product && index == 1,
                    onTap: () async {
                      if (widget.type == AddItemPageType.product &&
                          index == 1) {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2030),
                        );
                        textEditingControllers[index].text = selectedDate !=
                                null
                            ? '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'
                            : 'null';
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringResource.emptyTextField;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: widget.type == AddItemPageType.store
                          ? _getLabelTextForStore(index)
                          : _getLabelTextForProduct(index),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getLabelTextForStore(int index) {
    switch (index) {
      case 0:
        return StringResource.addItem.storeName;
      case 1:
        return StringResource.addItem.storeAddress;
      default:
        throw Exception('Invalid value: $index');
    }
  }

  String _getLabelTextForProduct(int index) {
    switch (index) {
      case 0:
        return StringResource.addItem.productName;
      case 1:
        return StringResource.addItem.productStartDate;
      case 2:
        return StringResource.addItem.productAmount;
      default:
        throw Exception('Invalid value: $index');
    }
  }
}
