import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssetActionButton extends StatefulWidget {
  const AssetActionButton({super.key});

  @override
  State<AssetActionButton> createState() => _AssetActionButtonState();
}

class _AssetActionButtonState extends State<AssetActionButton> {
  bool pending = false;
  String error = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  late BuildContext currentContext;

  @override
  Widget build(BuildContext context) {
    setState(() {
      currentContext = context;
    });
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext build) {
                return AlertDialog(
                  title: const Text("Add a new asset"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (error.isNotEmpty)
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      TextField(
                          enabled: !pending,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: "My beautiful car",
                            labelText: "Name",
                          )),
                      TextField(
                          enabled: !pending,
                          controller: valueController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "20000",
                            labelText: "Value",
                          ))
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: pending
                          ? null
                          : () {
                              Navigator.of(context).pop();

                              nameController.clear();
                              valueController.clear();
                            },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: pending
                          ? null
                          : () async {
                              setState(() {
                                error = "";
                                pending = true;
                              });
                              try {
                                if (nameController.text.isEmpty ||
                                    valueController.text.isEmpty) {
                                  setState(() {
                                    error = "Please fill all fields";
                                  });
                                } else {
                                  final currentContext = context;

                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .update({
                                    "assets": FieldValue.arrayUnion([
                                      {
                                        "name": nameController.text,
                                        "value": int.parse(valueController.text)
                                      }
                                    ])
                                  });

                                  nameController.clear();
                                  valueController.clear();

                                  Navigator.of(currentContext).pop();
                                }
                              } on Exception {
                                setState(() {
                                  error = "An error has occurred";
                                });
                              } finally {
                                setState(() {
                                  pending = false;
                                });
                              }
                            },
                      child: const Text("Add"),
                    ),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add));
  }
}
