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
  final _formKey = GlobalKey<FormState>();
  String _textInput = "";
  final repositoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                onChanged: (value) => setState(() {
                  _textInput = value;
                }),
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
