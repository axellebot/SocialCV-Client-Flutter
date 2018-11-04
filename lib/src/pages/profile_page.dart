import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/skill_group.dart';
import 'package:cv/src/services/local_data_repository.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final double defaultChipSpacing = 4.0;
  final double defaultElevation = 2.0;

  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LocalDataRepository repository;

  _ProfilePageState() {
    repository = LocalDataRepository();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Building ProfilePage');
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).profileTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                _buildSkillsPart(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildSkillGroupChips(List<String> skillTags) {
    if (skillTags == null) {
      return Text("null");
    }

    List<Widget> _skillWidgets = [];
    skillTags.forEach((element) {
      _skillWidgets.add(
        new Chip(
          label: Text((element != null) ? element : "null"),
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
            future: repository.getSkillGroups(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text(Localization.of(context).errorOccurred);
              } else if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              } else {
                List<SkillGroup> skillGroups = snapshot.data;
                List<Widget> skillWidgets = [];

                skillGroups.forEach((skillGroup) {
                  skillWidgets.add(
                    Text(
                      (skillGroup.label != null) ? skillGroup.label : "null",
                    ),
                  );
                  skillWidgets.add(_buildSkillGroupChips(skillGroup.skills));
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: skillWidgets,
                );
              }
            }),
      ),
    );
  }
}
