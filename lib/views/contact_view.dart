import 'package:flutter/material.dart';
import 'package:notesme/provider/list_map_provider.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Page')),
      body: Consumer<ListMapProvider>(
        builder: (ctx, provider, _) {
          var data = provider.getValues();
          return data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, idx) {
                    return ListTile(
                      title: Text('${data[idx]["name"]}'),
                      subtitle: Text('${data[idx]["age"]}'),
                    );
                  },
                )
              : const Center(child: Text("No Data"));
        },
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<ListMapProvider>().addData({
                "name": "name",
                "age": 18,
              });
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              // context.read<ListMapProvider>().deleteData(2);
              context.read<ListMapProvider>().clearAll();
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
