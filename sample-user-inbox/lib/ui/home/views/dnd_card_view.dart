import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actito/actito.dart';

import '../../../logger/logger.dart';
import '../../../theme/theme.dart';

class DoNotDisturbCardView extends StatefulWidget {
  const DoNotDisturbCardView({
    super.key,
  });

  @override
  DoNotDisturbCardViewState createState() => DoNotDisturbCardViewState();
}

class DoNotDisturbCardViewState extends State<DoNotDisturbCardView> {
  final ActitoDoNotDisturb _defaultDnd = ActitoDoNotDisturb(
    start: ActitoTime(hours: 23, minutes: 00),
    end: ActitoTime(hours: 08, minutes: 00),
  );

  bool _hasDndEnabled = false;

  @override
  void initState() {
    super.initState();

    _checkDndStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled),
                    const SizedBox(width: 12),
                    Text(
                      "Do Not Disturb",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      activeColor: AppTheme.primaryBlue,
                      value: _hasDndEnabled,
                      onChanged: _updateDndStatus,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _checkDndStatus() async {
    try {
      final dnd = await Actito.device().fetchDoNotDisturb();

      setState(() {
        _hasDndEnabled = dnd != null;
      });
    } catch (error) {
      logger.e('Fetch DND error.', error: error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red.shade900,
        ),
      );
    }
  }

  void _updateDndStatus(bool checked) async {
    logger.i((checked ? "Update" : "Clear") + " do not disturb clicked.");

    if (checked) {
      _updateDndTime(_defaultDnd);
      return;
    }

    try {
      await Actito.device().clearDoNotDisturb();

      logger.i('Cleared do not disturb successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cleared do not disturb successfully.'),
        ),
      );
    } catch (error) {
      logger.e('Clear do not disturb error.', error: error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red.shade900,
        ),
      );
    }

    setState(() {
      _hasDndEnabled = false;
    });
  }

  void _updateDndTime(ActitoDoNotDisturb dnd) async {
    try {
      await Actito.device().updateDoNotDisturb(dnd);

      logger.i('Updated do not disturb successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Updated do not disturb successfully.'),
        ),
      );
    } catch (error) {
      logger.e('Update Do Not Disturb error.', error: error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red.shade900,
        ),
      );
      return;
    }

    setState(() {
      _hasDndEnabled = true;
    });
  }
}
