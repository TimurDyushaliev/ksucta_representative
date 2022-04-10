import 'package:accident_registration/resource/string_resource.dart';
import 'package:accident_registration/view/pages/home_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController textEditingController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    textEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: StringResource.auth.textFieldHint,
                    errorMaxLines: 3,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringResource.emptyTextField;
                    } else if (value != StringResource.auth.username) {
                      return StringResource.auth.invalidUsername;
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                }
              },
              child: Text(StringResource.auth.login),
            )
          ],
        ),
      ),
    );
  }
}
