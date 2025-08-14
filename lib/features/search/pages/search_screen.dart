import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/donor.dart';
import '../../../providers/app_state_provider.dart';
// import '../models/donor.dart';
// import '../providers/app_state_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String? _bloodType;
  final _locationController = TextEditingController();
  List<Donor> _results = [];

  void _search() {
    final location = _locationController.text.trim();
    if (_bloodType != null && location.isNotEmpty) {
      final donors = ref.read(donorListProvider);
      setState(() {
        _results = donors
            .where((donor) =>
                donor.bloodType == _bloodType &&
                donor.location.toLowerCase().contains(location.toLowerCase()))
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select blood type and enter location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Donors')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Blood Type'),
              items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) => setState(() => _bloodType = value),
            ),
            SizedBox(height: 10),
            TextField(controller: _locationController, decoration: InputDecoration(labelText: 'Location')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _search, child: Text('Search')),
            Expanded(
              child: _results.isEmpty
                  ? Center(child: Text('No donors found'))
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final donor = _results[index];
                        return ListTile(
                          title: Text(donor.name),
                          subtitle: Text(
                              'Blood Type: ${donor.bloodType}, Contact: ${donor.contact}, Location: ${donor.location}, Availability: ${donor.availability}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}