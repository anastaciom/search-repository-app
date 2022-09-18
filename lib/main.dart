import 'package:flutter/material.dart';
import 'package:repository_app/components/listRepository.dart';
import 'package:repository_app/components/searchRepository.dart';
import 'package:repository_app/components/title.dart';
import 'package:repository_app/models/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  String statusMessage = 'List is empty';
  List<Repository> _repositories = [];

  Future<void> handleSearch(String repoName) async {
    try {
      if (_loading) return;

      setState(() {
        _repositories = [];
        _loading = true;
      });
      var response = await http.get(Uri.parse(
          "https://api.github.com/search/repositories?q=$repoName&page=0&per_page=10"));

      var data = jsonDecode(response.body);
      if ((data["items"] as List).isEmpty) {
        setState(() {
          statusMessage = 'Repository not found';
        });
      } else {
        setState(() {
          _repositories = (data["items"] as List)
              .map((e) => Repository.fromJson(e))
              .toList();
        });
      }
    } on Exception catch (_) {
      setState(() {
        statusMessage = 'Internal error';
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar:
              AppBar(title: const Center(child: Text('Search Repositories'))),
          body: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(children: [
              SearchRepository(handleSearch: handleSearch, loading: _loading),
              const TitleList(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
              ),
              !_loading
                  ? Expanded(
                      child: ListRepository(
                      respositories: _repositories,
                      statusMessage: statusMessage,
                    ))
                  : const CircularProgressIndicator()
            ]),
          )),
    );
  }
}
