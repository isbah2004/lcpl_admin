import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lcpl_admin/utils/utils.dart';

class UploadProvider extends ChangeNotifier {
  final FirebaseFirestore addDoc = FirebaseFirestore.instance;
  bool _pickerLoading = false, _uploadLoading = false;
  bool get pickerLoading => _pickerLoading;
  bool get uploadLoading => _uploadLoading;
  String? _url, _publicId, _signature;
  String? get url => _url;
  String? get signature => _signature;
  String? get publicId => _publicId;
  File? _file;
  File? get file => _file;

  Future<void> pickFile() async {
    _pickerLoading = true;
    notifyListeners();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _file = File(result.files.single.path!);
    } else {
      _file = null;
    }
    _pickerLoading = false;
    notifyListeners();
  }

  Future<void> uploadFile(
      {required BuildContext context,
      required String collection,
      required String title}) async {
    if (_file == null) return;
    _uploadLoading = true;
    notifyListeners();
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/dxhhsvyh9/auto/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'pztytpl7'
      ..files.add(await http.MultipartFile.fromPath('file', _file!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);

      _url = jsonMap['url'];
      _publicId = jsonMap['public_id'];
      await addDoc.collection(collection).add({
        'title': title,
        'url': _url,
        'public_id': _publicId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _file = null;
      _uploadLoading = false;
      notifyListeners();
      Utils.toastMessage(message: 'File uploaded successfully');
      Navigator.pop(context);
    } else {
      _uploadLoading = false;
      notifyListeners();
      Utils.toastMessage(message: 'Failed to upload file');
      debugPrint('Failed to upload file: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteFile(
      {required String publicId, required String docId, required String collection}) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const apiKey = '139194639628115'; // Replace with your API key
      const apiSecret = 'crq7f6wso_OhEsFYJWBdwFju4Fo'; // Replace with your API secret

      final String toSign = 'public_id=$publicId&timestamp=$timestamp$apiSecret';
      _signature = sha1.convert(utf8.encode(toSign)).toString();

      final url = Uri.parse('https://api.cloudinary.com/v1_1/dxhhsvyh9/image/destroy');
      final response = await http.post(url, body: {
        'public_id': publicId,
        'api_key': apiKey,
        'timestamp': timestamp.toString(),
        'signature': _signature!,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['result'] == 'ok') {
          await addDoc.collection(collection).doc(docId).delete();
          Utils.toastMessage(message: 'File deleted successfully');
        } else {
          debugPrint('Failed to delete file: ${responseData['result']}');
        }
      } else {
        debugPrint('Failed to delete file: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
    }
    notifyListeners();
  }
}
