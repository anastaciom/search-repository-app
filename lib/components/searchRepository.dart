import 'package:flutter/material.dart';

class SearchRepository extends StatefulWidget {
  const SearchRepository(
      {Key? key, required this.handleSearch, required this.loading})
      : super(key: key);
  final Function handleSearch;
  final bool loading;

  @override
  State<SearchRepository> createState() => _SearchRepositoryState();
}

class _SearchRepositoryState extends State<SearchRepository> {
  String _textInput = "";

  final repositoryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    repositoryController.addListener(() {
      setState(() {
        _textInput = repositoryController.text.toString();
      });
    });
  }

  @override
  void dispose() {
    repositoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: repositoryController,
                decoration: const InputDecoration(labelText: 'Repository Name'),
                autofocus: true,
                validator: (value) => value!.isEmpty ? 'Error' : null,
              ),
            ),
            ElevatedButton(
              onPressed: widget.loading || _textInput.isEmpty
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        widget.handleSearch(_textInput);
                      }
                    },
              child: const Text('Search'),
            ),
          ],
        ));
  }
}
