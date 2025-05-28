import 'package:flutter/material.dart';
import 'package:actito/actito.dart';

import '../../../logger/logger.dart';

class LaunchFlowCardView extends StatelessWidget {
  final bool isReady;

  const LaunchFlowCardView({
    super.key,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Text(
                "Launch Flow".toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _showActitoStatusInfo(context),
                icon: const Icon(Icons.info),
              ),
            ],
          ),
        ),
        Card(
          elevation: 1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed:
                        isReady ? null : () => _launchActito(context),
                    child: const Text("Launch"),
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: TextButton(
                    onPressed:
                        !isReady ? null : () => _unLaunchActito(context),
                    child: const Text("Unlaunch"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Launch Flow

  void _launchActito(BuildContext context) async {
    try {
      logger.i('Launching Actito.');
      await Actito.launch();

      logger.i('Launching Actito finished.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Actito launched successfully.'),
        ),
      );
    } catch (error) {
      logger.e('Actito launch failed.', error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red.shade900,
        ),
      );
    }
  }

  void _unLaunchActito(BuildContext context) async {
    try {
      logger.i('Unlaunching Actito.');
      await Actito.unlaunch();

      logger.i('Unlaunching Actito finished.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Actito unlaunched successfully.'),
        ),
      );
    } catch (error) {
      logger.e('Actito unlaunch failed.', error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red.shade900,
        ),
      );
    }
  }

  Future<void> _showActitoStatusInfo(BuildContext context) async {
    try {
      final isConfigured = await Actito.isConfigured;
      final isReady = await Actito.isReady;

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Actito"),
            content: Wrap(
              children: [
                Row(
                  children: [
                    const Text("Configured: "),
                    const Spacer(),
                    Text(
                      isConfigured.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Ready: "),
                    const Spacer(),
                    Text(
                      isReady.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      logger.e('Launch flow info error.', error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red.shade900,
        ),
      );
    }
  }
}
