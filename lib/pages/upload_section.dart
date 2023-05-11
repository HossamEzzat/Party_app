import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class upload_section extends StatefulWidget {
  const upload_section({Key? key}) : super(key: key);

  @override
  State<upload_section> createState() => _upload_sectionState();
}

// ignore: camel_case_types
class _upload_sectionState extends State<upload_section> {
  String? _selectedValue;
  final Map<String, String> categoryMap = {
    'اعياد الميلاد': 'birthday',
    'قاعة': 'hall',
    'زواج': 'wedding',
  };

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<XFile> _imageFiles = [];

  Future<void> _pickImages() async {
    final imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _imageFiles = pickedImages;
      });
    }
  }

  Future<String> _uploadImage(File file) async {
    // تحديد مسار التخزين على Firebase Storage
    final filePath = 'images/${DateTime.now()}.png';
    final storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(filePath);

    // تحميل الصورة إلى Firebase Storage
    final uploadTask = storageReference.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == firebase_storage.TaskState.success) {
      // إرجاع رابط الصورة المخزنة
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      // إرجاع قيمة فارغة في حالة فشل تحميل الصورة
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        elevation: 0.1,
        title: const Text("إضافة منتج"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "يرجى ملء الحقول إجباريًا",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "اسم المنتج",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال اسم المنتج';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(20),
                    value: _selectedValue,
                    decoration: InputDecoration(
                      labelText: 'تصنيف المنتج',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    items: categoryMap.keys
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: categoryMap[value]!,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى تحديد تصنيف المنتج';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _priceController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "السعر",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال السعر';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _descriptionController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelText: "الوصف",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الوصف';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Text('اختر الصور',
                      style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 100,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: _imageFiles
                        .map((imageFile) =>
                            Image.file(File(imageFile.path), fit: BoxFit.cover))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final category = _selectedValue!;
                      final price = int.parse(_priceController.text);
                      final description = _descriptionController.text;

                      // تحميل الصور والحصول على روابطها
                      final imageUrls = await Future.wait(
                          _imageFiles.map((file) => _uploadImage(File(file.path))));

                      // إضافة المنتج إلى Firestore
                      await FirebaseFirestore.instance.collection("indexcollection").add({
                        'name': name,
                        'type': category,
                        'price': price,
                        'description': description,
                        'image_url': imageUrls,
                      });

                      // إفراغ الحقول بعد إضافة المنتج بنجاح
                      setState(() {
                        _nameController.clear();
                        _selectedValue = null;
                        _priceController.clear();
                        _descriptionController.clear();
                        _imageFiles.clear();
                      });

                      // إظهار رسالة تأكيد
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تمت إضافة المنتج بنجاح.')),
                      );
                    }
                  },
                  child: const Text('إضافة المنتج',
                      style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}