// import 'dart:convert';
// import 'dart:io';

// import 'package:googleapis_auth/auth_io.dart';
// import 'package:travelappui/helpers/constants.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PhotoService{
//   final List<String> _scopes = [
//     'https://www.googleapis.com/auth/photoslibrary'
//   ];

//   Future<AuthClient> getHttpClient() async{
//     AuthClient authClient = await clientViaUserConsent(ClientId(clientId), _scopes, _userPrompt);
//     return authClient;
//   }

//   upload(File file) async{
//     AuthClient client = await getHttpClient();

//     var tokenResult = await client.post(
//       Uri.parse('https://photoslibrary.googleapis.com/v1/uploads'),
//       headers: {
//         'Content-type': 'application/octet-stream',
//         'X-Goog-Upload-Content-Type': 'image/png',
//         'X-Goog-Upload-Protocol': 'raw'
//       },
//       body: file.readAsBytesSync(),
//     );

//     var res = await client.post(
//       Uri.parse(
//           'https://photoslibrary.googleapis.com/v1/mediaItems:batchCreate'),
//       headers: {'Content-type':'application/json' },
//       body: jsonEncode({
//         "newMediaItems": [
//           {
//             "description": "item-description",
//             "simpleMediaItem": {
//               "fileName": "flutter-photos-upload",
//               "uploadToken": tokenResult.body,
//             }
//           }
//         ]
//       }),
//     );

//     print(res.body);
//   }

//   _userPrompt(String url){
//     launch(url);
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


String clave = "81a91816c209f6d64dfd56aa803647e5";

Future<String> uploadImage(File file) async {
  try {
    var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.imgbb.com/1/upload?key=$clave'),
  );
  
  var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
  var fileSize = await file.length();
  
  var multipartFile = http.MultipartFile(
    'image',
    fileStream,
    fileSize,
    filename: file.path.split('/').last,
  );
  
  request.files.add(multipartFile);

  var response = await request.send(); 
  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    final jsonResponse = json.decode(responseString);
    String imageUrl = jsonResponse['data']['url'];
    print('Image uploaded successfully!'+ imageUrl.toString());
    return imageUrl.toString();
  } else {
    print('Image upload failed!');
    return null;
  }
  } catch (e) {
    print("Trono: $e");
    return null;
  }
  
}
