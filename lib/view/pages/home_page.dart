import 'package:accident_registration/services/hive_provider.dart';
import 'package:accident_registration/view/pages/accident_info_page.dart';
import 'package:accident_registration/view/pages/register_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: HiveProvider.accidentsStream(),
        builder: (context, snapshot) {
          final models = HiveProvider.getAccidents();
          return ListView.builder(
            itemCount: models.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(index),
                direction: DismissDirection.startToEnd,
                background: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.grey,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.delete),
                  ),
                ),
                onDismissed: (direction) {
                  HiveProvider.deleteAccident(index);
                },
                child: ListTile(
                  title: Text(models[index].fullName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccidentInfoPage(
                          model: models[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
