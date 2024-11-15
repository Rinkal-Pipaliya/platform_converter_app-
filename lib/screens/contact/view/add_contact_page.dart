import 'dart:io';

import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:contact_app/screens/home/provider/home_provider.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  String imagePath = '';
  int currentStep = 0;

  // Validation
  bool get isDataValid {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty;
  }

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          if (currentStep < 4) {
            setState(() {
              currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
        },
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
          return Row(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade50,
                ),
                onPressed: controls.onStepContinue,
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              8.w,
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                onPressed: controls.onStepCancel,
                child: const Text("Cancel"),
              ),
            ],
          );
        },
        steps: [
          // Image Step
          Step(
            title: const Text("Personal Info"),
            content: Column(
              children: [
                imagePath.isEmpty
                    ? const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 70,
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(
                          File(imagePath),
                        ),
                      ),
                10.h,
                ElevatedButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      preferredCameraDevice: CameraDevice.front,
                      imageQuality: 100,
                    );
                    if (file != null) {
                      setState(() {
                        imagePath = file.path;
                      });
                    }
                  },
                  child: const Text(
                    "Get Image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Contact Details Step
          Step(
            title: const Text("Contact Details"),
            content: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                10.h,
                TextFormField(
                  controller: phoneController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          // Email, Date, and Time Step
          Step(
            title: const Text("Email, Date & Time"),
            content: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                10.h,
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Select Date",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      dateController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    }
                  },
                ),
                10.h,
                TextFormField(
                  controller: timeController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Select Time",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      timeController.text = pickedTime.format(context);
                    }
                  },
                ),
              ],
            ),
          ),
          // Save Step
          Step(
            title: const Text("Save"),
            content: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: isDataValid
                  ? () {
                      ContactModel model = ContactModel(
                        name: nameController.text,
                        email: emailController.text,
                        image: imagePath,
                        contact: phoneController.text,
                        date: dateController.text,
                        time: timeController.text,
                      );

                      context.read<HomeProvider>().addContact(model);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Save Successful"),
                          shape: BeveledRectangleBorder(),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
