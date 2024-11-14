import 'package:contact_app/screens/home/model/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class HomeProvider with ChangeNotifier {
  List<ContactModel> contactList = [];

  int selectedIndex = 0;

  bool isAndroid = true;

  int segmentValue = 0;

  void changeSegment(value) {
    segmentValue = value;
    notifyListeners();
  }

  void changePlatform() {
    isAndroid = !isAndroid;
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List<ContactModel> hideList = [];

  List<ContactModel> favoriteList = [];

  void favoriteContact(ContactModel model) {
    if (!favoriteList.contains(model)) {
      favoriteList.add(model);
      notifyListeners();
    }
  }

  void unfavoriteContact(ContactModel model) {
    favoriteList.remove(model);
    notifyListeners();
  }

  void hideContact(ContactModel model) {
    hideList.add(model);
    contactList.removeAt(selectedIndex);
    notifyListeners();
  }

  void unhideContact(ContactModel model) {
    contactList.add(model);
    hideList.removeAt(selectedIndex);
    notifyListeners();
  }

  void addContact(ContactModel contact) {
    contactList.add(contact);
    notifyListeners();
  }

  void deleteContact(int index) {
    contactList.removeAt(index);
    notifyListeners();
  }

  void updateContact(ContactModel model) {
    contactList[selectedIndex] = model;
    notifyListeners();
  }

  void hideUpdateContact(ContactModel model) {
    hideList[selectedIndex] = model;
    notifyListeners();
  }

  Future<bool> openLock() async {
    LocalAuthentication auth = LocalAuthentication();
    bool isBiometricAvailable = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();

    if (isBiometricAvailable && isDeviceSupported) {
      List<BiometricType> availableBio = await auth.getAvailableBiometrics();

      if (availableBio.isEmpty) {
        return false;
      } else {
        return await auth.authenticate(
          localizedReason: 'Please authenticate',
        );
      }
    } else {
      return false;
    }
  }
}
