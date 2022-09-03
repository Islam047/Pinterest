import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinterest/services/hive_service.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  final int crossAxisCount;

  const ProfilePage({Key? key, this.crossAxisCount = 2}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool isEdit = false;
  File? file;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    readImage();
    readAllData();

    super.initState();
  }

  void _gallery() async {
    Navigator.of(context).pop();
    if (!kIsWeb) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        file = selected;
        HiveService.setData(StorageKey.photo, image.path.toString());
      }
    } else if (kIsWeb) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        Uint8List imageBytes = await image.readAsBytes();

        HiveService.setData(StorageKey.photo, imageBytes);

        file = File("a");
      }
    }
    setState(() {});
  }

  void _camera() async {
    Navigator.of(context).pop();
    if (!kIsWeb) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        var selected = File(image.path);
        file = selected;
        HiveService.setData(StorageKey.photo, image.path.toString());
      }
    } else if (kIsWeb) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        Uint8List imageBytes = await image.readAsBytes();
        HiveService.setData(StorageKey.photo, imageBytes);

        file = File("a");
      }
    }
    setState(() {});
  }

  void _getImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: _gallery,
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text("Camera"),
              onTap: _camera,
            ),
          ],
        ),
      ),
    );
  }

  Widget? readImage() {
    if (HiveService.readData(StorageKey.photo) != null) {
      if (kIsWeb) {
        Uint8List? result = HiveService.readData(StorageKey.photo);
        if (result != null) {
          return Image.memory(
            result,
            fit: BoxFit.cover,
          );
        } else {
          return null;
        }
      } else {
        String? result = HiveService.readData(StorageKey.photo);

        return Image.file(
          File(result!),
          fit: BoxFit.cover,
        );
      }
    }
    return ColoredBox(color: Colors.grey.shade300);
  }

  void readAllData() {
    if (HiveService.readData(StorageKey.userInfo) != null) {
      Map? userInfo = HiveService.readData(StorageKey.userInfo);
      nameController = TextEditingController(text: userInfo?['name'] ?? '');
      emailController = TextEditingController(text: userInfo?['email'] ?? '');
      mobileController = TextEditingController(text: userInfo?['mobile'] ?? '');
    }
  }

  void saveAllUser() {
    Map<String, dynamic> sendInfo = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "mobile": mobileController.text.trim(),
    };
    HiveService.setData(StorageKey.userInfo, sendInfo);
    isEdit = !isEdit;
    setState(() {});
  }

  void editMethod() {
    isEdit = !isEdit;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width < 720
                ? MediaQuery.of(context).size.width
                : 720,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: saveAllUser,
                            icon: Icon(
                              isEdit ? Icons.done : null,
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                            height: 150,
                            width: 150,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: readImage()),
                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red,
                            child: IconButton(
                              padding: const EdgeInsets.all(10),
                              icon: const Icon(Icons.camera_alt_rounded),
                              onPressed: _getImage,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                                onPressed: editMethod,
                                icon: isEdit
                                    ? const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      )))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    eachButton(
                      nameController,
                      "Name",
                      "Enter your name",
                    ),
                    eachButton(
                      emailController,
                      "Email",
                      "Enter your email",
                    ),
                    eachButton(
                        mobileController, "Mobile Number", "Enter your number",
                        isPhoneNumber: true),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eachButton(
      TextEditingController controller, String name, String hintText,
      {bool isPhoneNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        TextField(
          enabled: isEdit,
          keyboardType:
              isPhoneNumber ? TextInputType.phone : TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400)),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
