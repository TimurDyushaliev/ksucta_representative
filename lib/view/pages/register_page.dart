import 'package:accident_registration/models/accident_model.dart';
import 'package:accident_registration/resource/string_resource.dart';
import 'package:accident_registration/services/hive_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final List<TextEditingController> textEditingControllers;
  late final List<GlobalKey<FormState>> formKeys;

  @override
  void initState() {
    textEditingControllers =
        List.generate(6, (index) => TextEditingController());
    formKeys = List.generate(6, (index) => GlobalKey<FormState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            7,
            (index) {
              if (index == 6) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKeys.every(
                          (element) => element.currentState!.validate())) {
                        await HiveProvider.saveAccident(
                          AccidentModel.fromTexts(
                            textEditingControllers.map((e) => e.text).toList(),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(StringResource.register.done),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKeys[index],
                  child: TextFormField(
                    controller: textEditingControllers[index],
                    onTap: () {
                      if (index == 2) {
                        DatePicker.showDateTimePicker(
                          context,
                          locale: LocaleType.ru,
                          onConfirm: (dateTime) {
                            textEditingControllers[2].text = '$dateTime';
                          },
                        );
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringResource.emptyTextField;
                      }
                      return null;
                    },
                    readOnly: index == 2,
                    decoration: InputDecoration(
                      labelText: _getLabelText(index),
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

  String _getLabelText(int index) {
    switch (index) {
      case 0:
        return StringResource.register.fullName;
      case 1:
        return StringResource.register.address;
      case 2:
        return StringResource.register.dateTime;
      case 3:
        return StringResource.register.vehicle;
      case 4:
        return StringResource.register.vehicleNumber;
      case 5:
        return StringResource.register.vehicleBrand;
      default:
        throw Exception('Invalid value: $index');
    }
  }
}
