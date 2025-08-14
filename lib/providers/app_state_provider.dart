import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donor.dart';
import '../models/recipient.dart';

final donorListProvider = StateProvider<List<Donor>>((ref) => []);
final recipientListProvider = StateProvider<List<Recipient>>((ref) => []);
final userProvider = StateProvider<String?>((ref) => null);