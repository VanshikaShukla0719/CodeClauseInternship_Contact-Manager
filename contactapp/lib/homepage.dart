// ignore_for_file: prefer_const_constructors

// ignore: unused_import
import 'dart:ffi';

import 'package:contactapp/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 165, 201, 225),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: const Text(
              "Contact List",
              style: TextStyle(fontSize: 33),
            ),
          ),
          toolbarHeight: 50,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          // ignore: duplicate_ignore
          // ignore: prefer_const_constructors
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: "Contact Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contactController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    labelText: "Contact Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = " ";
                          contactController.text = " ";
                          contacts.add(Contact(name: name, contact: contact));
                        });
                      }
                    },
                    // ignore: sort_child_properties_last
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 129, 174, 213),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();

                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = " ";
                          contactController.text = " ";
                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;

                          selectedIndex = -1;
                          // contacts.update(Contact(name: name, contact: contact));
                        });
                      }
                    },
                    // ignore: sort_child_properties_last
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 129, 184, 213),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              contacts.isEmpty
                  ? const Text(
                      "No Contact yet ... ",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),
                    )
            ],
          ),
        ));
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (index % 2 == 0)
              ? Color.fromARGB(255, 173, 76, 175)
              : Color.fromARGB(255, 39, 135, 176),
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(Icons.edit)),
              SizedBox(
                width: 11,
              ),
              InkWell(
                  onTap: (() {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
              SizedBox(
                width: 11,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
