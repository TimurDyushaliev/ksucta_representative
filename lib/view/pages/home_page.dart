import 'package:accident_registration/resource/string_resource.dart';
import 'package:accident_registration/services/hive_provider.dart';
import 'package:accident_registration/view/pages/add_item_page.dart';
import 'package:accident_registration/view/pages/product_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(StringResource.home.stores),
      ),
      body: StreamBuilder(
        stream: HiveProvider.storesStream(),
        builder: (context, snapshot) {
          final models = HiveProvider.getStores();
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
                  HiveProvider.deleteStore(index);
                },
                child: ListTile(
                  title: Text(models[index].name),
                  subtitle: Text(models[index].address),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListPage(
                          storeModel: models[index],
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
              builder: (context) => const AddItemPage(
                type: AddItemPageType.store,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
