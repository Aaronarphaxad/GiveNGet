import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String?> uploadToCloudinary(File imageFile) async {
  const cloudName = 'dcmmplalc'; // From your Cloudinary dashboard
  const uploadPreset = 'flutter_preset'; // The unsigned preset you created

  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = uploadPreset
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final resData = json.decode(await response.stream.bytesToString());
    return resData['secure_url'];
  } else {
    print('❌ Upload failed with status ${response.statusCode}');
    return null;
  }
}