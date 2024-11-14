import 'dart:io';

import 'package:contact_app/screens/contact/provider/contact_provider.dart';
import 'package:contact_app/screens/contact/view/add_contact_page.dart';
import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:contact_app/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class AddContactIosScreen extends StatefulWidget {
  const AddContactIosScreen({super.key});

  @override
  State<AddContactIosScreen> createState() => _AddContactIosScreenState();
}

class _AddContactIosScreenState extends State<AddContactIosScreen> {
  String? imagePath;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool get isDataValid {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add Contact'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      preferredCameraDevice: CameraDevice.front,
                      imageQuality: 100,
                    );
                    setState(() {
                      imagePath = file?.path;
                    });
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath!))
                        : const NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          ) as ImageProvider,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: CupertinoColors.systemGrey,
                        radius: 20,
                        child: Icon(
                          CupertinoIcons.camera,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: nameController,
                  placeholder: 'Name',
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: phoneController,
                  placeholder: 'Phone',
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: () async {
                    DateTime? pickedDate =
                        await showCupertinoModalPopup<DateTime>(
                      context: context,
                      builder: (BuildContext context) {
                        DateTime tempPickedDate = DateTime.now();
                        return Container(
                          height: 250,
                          color: CupertinoColors.black,
                          child: Column(
                            children: [
                              CupertinoButton(
                                child: const Text('Select'),
                                onPressed: () {
                                  setState(() {
                                    selectedDate = tempPickedDate;
                                    dateController.text =
                                        "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              Expanded(
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime dateTime) {
                                    tempPickedDate = dateTime;
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    selectedDate != null
                        ? "Date: ${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
                        : "Select Date",
                    style: const TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoButton(
                  onPressed: () async {
                    TimeOfDay? pickedTime =
                        await showCupertinoModalPopup<TimeOfDay>(
                      context: context,
                      builder: (BuildContext context) {
                        TimeOfDay tempPickedTime = TimeOfDay.now();
                        return Container(
                          height: 250,
                          color: CupertinoColors.black,
                          child: Column(
                            children: [
                              CupertinoButton(
                                child: const Text('Select'),
                                onPressed: () {
                                  setState(() {
                                    selectedTime = tempPickedTime;
                                    // timeController.text =
                                    //     "${selectedTime?.minute}${selectedTime?.minute}";
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              Expanded(
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (DateTime dateTime) {
                                    tempPickedTime = TimeOfDay(
                                        hour: dateTime.hour,
                                        minute: dateTime.minute);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    selectedTime != null
                        ? "Time : ${selectedTime?.hour} : ${selectedTime?.minute}"
                        : "Select Time",
                    style: const TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
                32.h,
                CupertinoButton.filled(
                    child: const Text('Save'),
                    onPressed: () {
                      ContactModel model = ContactModel(
                        name: nameController.text,
                        email: emailController.text,
                        image: imagePath,
                        contact: phoneController.text,
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
