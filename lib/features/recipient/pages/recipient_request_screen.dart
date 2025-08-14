import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/recipient.dart';
import '../../../providers/app_state_provider.dart';
// import '../models/recipient.dart';
// import '../providers/app_state_provider.dart';

class RecipientRequestScreen extends ConsumerStatefulWidget {
  @override
  _RecipientRequestScreenState createState() => _RecipientRequestScreenState();
}

class _RecipientRequestScreenState extends ConsumerState<RecipientRequestScreen> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  String? _bloodType;
  String? _urgency;

  void _submit() {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final location = _locationController.text.trim();

    if (name.isEmpty ||
        !RegExp(r'^\d{10}$').hasMatch(contact) ||
        location.isEmpty ||
        _bloodType == null ||
        _urgency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly (10-digit contact)')),
      );
      return;
    }

    final recipient = Recipient(
      name: name,
      bloodType: _bloodType!,
      contact: contact,
      location: location,
      urgency: _urgency!,
    );

    ref.read(recipientListProvider.notifier).update((state) => [...state, recipient]);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request Submitted!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Blood')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Required Blood Type'),
                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => _bloodType = value),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              TextField(controller: _locationController, decoration: InputDecoration(labelText: 'Location')),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Urgency'),
                items: ['Immediate', 'Within a Week']
                    .map((urgency) => DropdownMenuItem(value: urgency, child: Text(urgency)))
                    .toList(),
                onChanged: (value) => setState(() => _urgency = value),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Submit Request')),
            ],
          ),
        ),
      ),
    );
  }
}