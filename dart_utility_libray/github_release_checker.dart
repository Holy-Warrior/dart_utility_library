import 'package:http/http.dart' as http;
import 'dart:convert';

dynamic githubReleaseCheck(String owner, String repo, String currentRelease, bool filterOutPreRelease) async{
  // fetching
  final response = await http.get(Uri.parse('https://api.github.com/repos/$owner/$repo/releases'));

  if (response.statusCode != 200) // if there is no internet, then nothing can be done
    return false;
  

  // we got a response, cleaning the data
  dynamic data = jsonDecode(response.body);
  dynamic item;
  for (var i in data){
    if (filterOutPreRelease){
      if (i['prerelease']==false)
        item = i;
    } else {
      item = i;
    }
  }

  if (item == null) return false;

  data = {
    'name':item['name'],
    'version':item['tag_name'],
    'published_at':item['published_at'],
    'download_link':item['assets'][0]['browser_download_url'],
    'description':item['body'],
    'pre_release':!filterOutPreRelease
  };

  // converting current release
  dynamic r1= currentRelease.replaceFirst('v', '').split('.');
  dynamic r2= item['tag_name'].replaceFirst('v', '').split('.');
  // check change in release
  bool isSame = true;
  for (int i = 0; i < r1.length; i++) {
    if (r1[i] != r2[i]) {
      isSame = false;
      break;
    }
  }

  data['new']= !isSame;

  return data;
}