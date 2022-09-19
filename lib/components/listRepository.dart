import 'package:flutter/material.dart';
import 'package:repository_app/models/repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListRepository extends StatelessWidget {
  ListRepository(
      {Key? key, required this.respositories, required this.statusMessage})
      : super(key: key);
  final List<Repository> respositories;
  final String statusMessage;

  Future<void> _launchUrl(String urlRepository, BuildContext context) async {
    final Uri url = Uri.parse(urlRepository);
    SnackBar snackBar = SnackBar(
      content: !await launchUrl(url)
          ? const Text('Url error.Try again!!')
          : Text('Abrindo... $urlRepository'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                            leading: CachedNetworkImage(
                              imageUrl: respositories[index].avatarUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
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
                              onPressed: () =>
                                  _launchUrl(respositories[index].url, context),
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
