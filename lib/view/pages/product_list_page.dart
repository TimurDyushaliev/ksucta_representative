import 'package:accident_registration/models/store_model.dart';
import 'package:accident_registration/services/hive_provider.dart';
import 'package:accident_registration/view/pages/add_item_page.dart';
import 'package:accident_registration/view/pages/product_info_page.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key, required this.storeModel}) : super(key: key);

  final StoreModel storeModel;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeModel.name),
      ),
      body: StreamBuilder(
        stream: HiveProvider.productsStream(),
        builder: (context, snapshot) {
          final models = HiveProvider.getProducts();
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
                  HiveProvider.deleteProduct(index);
                },
                child: ListTile(
                  title: Text(models[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductInfoPage(
                          index: index,
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
              builder: (context) => const AddItemPage(
                type: AddItemPageType.product,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
