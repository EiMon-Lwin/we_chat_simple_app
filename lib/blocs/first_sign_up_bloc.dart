import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';
import 'package:we_chat_simple_app/network/data_agent/firebase_storage/firebase_storage_Impl.dart';
import 'package:we_chat_simple_app/network/data_agent/firebase_storage/firebase_storage_abst.dart';
import 'dart:io';

import '../data/apply/wechat_simple_apply.dart';
import '../data/apply/wechat_simple_apply_Impl.dart';

class FirstSignUpBloc extends ChangeNotifier {
  bool _dispose = false;
  String _name = '';
  String _email = '';
  String? _selectedCountry = '';
  String? _phoneCode = '';
  String _password = '';
  File? _file;
  String? _filePath;

  final GlobalKey<FormState> _globalKey = GlobalKey();

  bool _isVisibility = true;
  bool _isAccept = false;

  ///Create Instance
  final TextEditingController _nameTextFieldController =
      TextEditingController();
  TextEditingController _regionTextFieldController = TextEditingController();
  TextEditingController _phoneTextFieldController = TextEditingController();
  final TextEditingController _passwordTextFieldController =
      TextEditingController();
  final TextEditingController _emailTextFieldController =
      TextEditingController();

  /// Getter
  bool get getDispose => _dispose;

  GlobalKey<FormState> get getGlobalKey => _globalKey;

  TextEditingController get getNameTextFieldController =>
      _nameTextFieldController;

  TextEditingController get getRegionTextFieldController =>
      _regionTextFieldController;

  TextEditingController get getPhoneTextFieldController =>
      _phoneTextFieldController;

  TextEditingController get getPasswordTextFieldController =>
      _passwordTextFieldController;

  TextEditingController get getEmailTextFieldController =>
      _emailTextFieldController;

  String get getName => _name;

  String? get getSelectedCountry => _selectedCountry;

  String? get getPhoneCode => _phoneCode;

  String get getPassword => _password;

  String get getEmail => _email;

  bool get getIsVisibility => _isVisibility;

  bool get getIsAccept => _isAccept;

  File? get getSelectedFile => _file;

  String? get getSelectedFilePath => _filePath;

  /// Setter
  set setName(String name) => _name = name;

  set setSelectedCountry(String countryName) => _selectedCountry = countryName;

  set setPhoneCode(String phoneCode) => _phoneCode = phoneCode;

  set setPassword(String password) => _password = password;

  set setEmail(String email) => _email = email;

  final WeChatSimpleApply _weChatSimpleApply = WeChatSimpleApplyImpl();

  final FirebaseStorageAbst _firebaseStorageAbst = FirebaseStorageImpl();

  Future register(String userName, String phone, String region, String password,
      File? file) async {
    UserVO newUser =
        UserVO('id', userName, _email, phone, region, password, '');
    if (file != null) {
      String imageLink =
          await _firebaseStorageAbst.uploadToFirebaseStorage(file);
      newUser.file = imageLink;
      return _weChatSimpleApply.registerNewUser(newUser);
    }

    return _weChatSimpleApply.registerNewUser(newUser);
  }

  void selectFile(File? file) {
    if (file != null) {
      _file = file;
      _filePath = file.toString();
      notifyListeners();
    }
  }

  void openCountryPicker(BuildContext context) {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          _selectedCountry = country.displayName;
          _phoneCode = country.phoneCode;

          _regionTextFieldController =
              TextEditingController(text: _selectedCountry);
          _phoneTextFieldController = TextEditingController(text: _phoneCode);
          notifyListeners();
        });
  }

  void setVisibility() {
    if (_isVisibility == true) {
      _isVisibility = false;
    } else {
      _isVisibility = true;
    }
    notifyListeners();
  }

  void isReadAndAccept() {
    _isAccept = true;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
    _nameTextFieldController.dispose();
    _regionTextFieldController.dispose();
    _phoneTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    _emailTextFieldController.dispose();
  }
}
