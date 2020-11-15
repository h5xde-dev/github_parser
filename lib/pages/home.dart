import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it_gro/services/github.dart';
import 'package:it_gro/widgets/animated_background.dart';
import 'package:it_gro/widgets/custom_dialog.dart';
import 'package:it_gro/widgets/github_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller;
  List data = [];
  int page = 1;
  bool loaded = false;

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        loaded) {
      page = page + 1;
      List newPageData = await Github.getRepos(page: page);

      data.addAll(newPageData);
      setState(() {
        data = data;
        page = page;
      });
      _controller.jumpTo(_controller.position.maxScrollExtent -
          _controller.position.extentAfter);
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? AnimatedBackground(
            child: Scaffold(backgroundColor: Colors.transparent, body: _body()))
        : FutureBuilder(
            future: Github.getRepos(page: page),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return AnimatedBackground(
                      child: Scaffold(
                          body: Center(child: CircularProgressIndicator())));
                case ConnectionState.waiting:
                  return AnimatedBackground(
                      child: Scaffold(
                          body: Center(child: CircularProgressIndicator())));
                default:
                  if (snapshot.hasError || snapshot.data.length == 0)
                    return AnimatedBackground(
                        child: Scaffold(
                            body: Center(
                                child:
                                    Text('Too much request on github api'))));
                  else {
                    data.addAll(snapshot.data);

                    loaded = true;

                    return AnimatedBackground(
                        child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: _body()));
                  }
              }
            });
  }

  Widget _body() {
    return ListView.builder(
        controller: _controller,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int itemId) {
          return InkWell(
            onTap: () => _getInfo(data[itemId]['full_name']),
            child: GithubCard(
              name: data[itemId]['name'] ?? data[itemId]['full_name'],
              fullName: data[itemId]['full_name'] ?? data[itemId]['name'],
              ownerAvatar: data[itemId]['owner']['avatar_url'],
              isPrivate: data[itemId]['private'],
              widthOfCard: MediaQuery.of(context).size.width - 130,
              description: data[itemId]['description'] ?? '',
            ),
          );
        });
  }

  Future _getInfo(String fullName) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomDialog(
              title: 'Loading...',
              description: 'Waiting...',
            ));

    Map repoData = await Github.getInfo(fullName);
    Navigator.of(context).pop(true);

    if (repoData.length != 0) {
      showDialog(
          context: context,
          builder: (context) => CustomDialog(
                title: '$fullName',
                description: '${repoData['description']}',
                forks: repoData['forks'],
                stars: repoData['stargazers_count'],
                watchers: repoData['watchers_count'],
                image:
                    CachedNetworkImageProvider(repoData['owner']['avatar_url']),
              ));
    }
  }
}
