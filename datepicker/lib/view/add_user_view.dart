import 'package:flutter/material.dart';

import '../di/di.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({Key? key}) : super(key: key);

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final gap = const SizedBox(height: 20);
  var name = '';
  var password = '';
  var id = ' ';

  TimeOfDay? time = TimeOfDay.now();
  DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              TextField(
                onChanged: (text) {
                  id = text;
                },
                decoration: const InputDecoration(
                  labelText: 'ID',
                ),
              ),
              gap,
              TextField(
                onChanged: (text) {
                  name = text;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              gap,
              TextField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              gap,
              Row(
                children: [
                  const Text('Choose Date:'),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: date!,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          date = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      '${date!.day}/${date!.month}/${date!.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              gap,
              Row(
                children: [
                  const Text('Choose Time:'),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: time!,
                      );
                      if (newTime != null) {
                        setState(() {
                          time = newTime;
                        });
                      }
                    },
                    child: Text(
                      '${time!.format(context)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              gap,
              gap,
              ElevatedButton(
                onPressed: () {
                  User user = User(id: id, name: name, date: date, time: time);
                  getIt<UserRepository>().addUser(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User added successfully!'),
                    ),
                  );
                },
                child: const Text('Register User'),
              ),
              gap,
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/viewUser');
                },
                child: const Text('View Users'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
