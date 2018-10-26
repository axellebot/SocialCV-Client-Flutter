import 'package:flutter/material.dart';
import 'package:cv/models/skill_group.dart';
import 'package:cv/services/local_data_repository.dart';

class ProfilePage extends StatefulWidget {
  final String title = "Profile";

  final double defaultChipSpacing = 4.0;
  final double defaultElevation = 2.0;

  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LocalDataRepository repository;

  _ProfilePageState() {
    repository = new LocalDataRepository();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSkillGroupChips(List<String> skillTags) {
    if (skillTags == null) {
      return new Text("null");
    }

    List<Widget> _skillWidgets = [];
    skillTags.forEach((element) {
      _skillWidgets.add(
        new Chip(
          label: new Text((element != null) ? element : "null"),
        ),
      );
    });
    return new Wrap(
      spacing: widget.defaultChipSpacing, // gap between adjacent chips
      runSpacing: widget.defaultChipSpacing, // gap between lines
      children: _skillWidgets,
    );
  }

  Widget _buildSkillsPart() {
    return new Card(
      elevation: widget.defaultElevation,
      child: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new FutureBuilder(
            future: repository.getSkillGroups(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return new Text(
                  "Error",
                );
              } else if (snapshot.hasData == false) {
                return new CircularProgressIndicator();
              } else {
                List<SkillGroup> skillGroups = snapshot.data;
                List<Widget> skillWidgets = [];

                skillGroups.forEach((skillGroup) {
                  skillWidgets.add(
                    new Text(
                      (skillGroup.label != null) ? skillGroup.label : "null",
                    ),
                  );
                  skillWidgets.add(_buildSkillGroupChips(skillGroup.skills));
                });

                return new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: skillWidgets,
                );
              }
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: new Row(children: <Widget>[
          new Expanded(
            child: new Column(
              children: <Widget>[
                _buildSkillsPart(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
