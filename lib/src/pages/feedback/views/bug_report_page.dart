import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:modulife/src/widgets/custom_scaffold/custom_scaffold.dart';

import 'package:modulife_utils/modulife_utils.dart';

@RoutePage()
class BugReportPage extends StatefulWidget {
  const BugReportPage({super.key});

  @override
  State<BugReportPage> createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Report a Bug',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Describe the issue',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReport,
              child: const Text('Submit Bug Report'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReport() {
    String description = _descriptionController.text;
    String logs = LogService.getLogs();

    // TODO implement bug report sending to my email
    LogService.d('Bug Report Description: $description');
    LogService.d('Attached Logs: $logs');

    LogService.clearLogs();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bug report submitted successfully')),
    );

    _descriptionController.clear();
  }
}
