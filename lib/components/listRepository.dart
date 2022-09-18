import 'package:flutter/material.dart';
import 'package:repository_app/models/repository.dart';

class ListRepository extends StatelessWidget {
  const ListRepository(
      {Key? key, required this.respositories, required this.statusMessage})
      : super(key: key);

  final List<Repository> respositories;
  final String statusMessage;

  @override
  Widget build(BuildContext context) {
    return respositories.isEmpty
        ? Text(
            statusMessage,
            style: const TextStyle(
                color: Colors.grey, fontStyle: FontStyle.italic),
          )
        : ListView.builder(
            itemBuilder: (context, index) => Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(respositories[index].name),
                            subtitle: Text(
                              respositories[index].description ??
                                  'No description :(',
                              style: TextStyle(
                                  fontStyle:
                                      respositories[index].description == null
                                          ? FontStyle.italic
                                          : FontStyle.normal),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.tealAccent[200]),
                              onPressed: () => {},
                              child: const Text(
                                'Open Repository',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
            itemCount: respositories.length);
  }
}
