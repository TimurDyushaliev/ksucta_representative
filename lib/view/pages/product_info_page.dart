import 'package:accident_registration/models/product_model.dart';
import 'package:accident_registration/resource/string_resource.dart';
import 'package:accident_registration/services/hive_provider.dart';
import 'package:flutter/material.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  final int index;
  final ProductModel model;

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController textEditingController;

  late int productsAmount;
  bool canPopDialog = true;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    textEditingController = TextEditingController();

    productsAmount = widget.model.amount;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTextRow(index)[0],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(_getTextRow(index)[1]),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: canPopDialog,
            builder: (context) {
              return WillPopScope(
                onWillPop: () => Future.value(canPopDialog),
                child: AlertDialog(
                  title: Text(
                      StringResource.productInfo.productsReturnAmount + ':'),
                  content: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        } else if (int.parse(value) > productsAmount) {
                          return StringResource.productInfo.highAmount;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          canPopDialog = formKey.currentState!.validate();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: '0',
                        errorMaxLines: 3,
                      ),
                    ),
                  ),
                ),
              );
            },
          ).then(
            (value) async {
              if (textEditingController.text.isNotEmpty) {
                final amountToReturn = int.parse(textEditingController.text);
                final newValue = productsAmount - amountToReturn;

                await HiveProvider.updateProduct(
                  widget.index,
                  widget.model.copyWith(
                    amount: newValue,
                  ),
                );
                setState(() {
                  productsAmount = newValue;
                  textEditingController.clear();
                });
              }
            },
          );
        },
        child: const Icon(Icons.remove),
      ),
    );
  }

  List<String> _getTextRow(int index) {
    switch (index) {
      case 0:
        return [StringResource.productInfo.name + ':', widget.model.name];
      case 1:
        return [
          StringResource.productInfo.startDate + ':',
          widget.model.startDate
        ];
      case 2:
        return [
          StringResource.productInfo.amount + ':',
          productsAmount.toString(),
        ];
      default:
        throw Exception('Invalid index: $index');
    }
  }
}
