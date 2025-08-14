import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/donor.dart';
import '../../../providers/app_state_provider.dart';
// import '../models/donor.dart';
// import '../providers/app_state_provider.dart';

class DonorRegistrationScreen extends ConsumerStatefulWidget {
  @override
  _DonorRegistrationScreenState createState() => _DonorRegistrationScreenState();
}

class _DonorRegistrationScreenState extends ConsumerState<DonorRegistrationScreen> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  String? _bloodType;
  String? _availability;

  void _submit() {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final location = _locationController.text.trim();

    if (name.isEmpty ||
        !RegExp(r'^\d{10}$').hasMatch(contact) ||
        location.isEmpty ||
        _bloodType == null ||
        _availability == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly (10-digit contact)')),
      );
      return;
    }

    final donor = Donor(
      name: name,
      bloodType: _bloodType!,
      contact: contact,
      location: location,
      availability: _availability!,
    );

    ref.read(donorListProvider.notifier).update((state) => [...state, donor]);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donor Registered!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Donor')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Blood Type'),
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
                decoration: InputDecoration(labelText: 'Availability'),
                items: ['Available Now', 'Available Later']
                    .map((avail) => DropdownMenuItem(value: avail, child: Text(avail)))
                    .toList(),
                onChanged: (value) => setState(() => _availability = value),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}