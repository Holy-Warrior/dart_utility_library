# 📦 Dart Utility Library

A collection of nifty Dart utilities to speed up development 🚀.  
This library contains handy functions like checking for the latest GitHub release of any repository.

## ✨ Features

- 🔍 **[GitHub Release Checker](#github-release-checker)** – Easily detect if a new release is available.
- 🧰 More utilities coming soon!

## GitHub Release Checker

### Dependency
```yaml
name: dart_release_checker
environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  http: ^1.2.1
```

### 🛠️ Example Usage

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final result = await githubReleaseCheck(
    'flutter',
    'flutter',
    'v3.19.0',
    true
  );
  print(result);
}

/// Checks for the latest GitHub release of a repository.
Future<dynamic> githubReleaseCheck(
    String owner,
    String repo,
    String currentRelease,
    bool filterOutPreRelease) async {
  print('🔔 Checking releases for $owner/$repo...'); // 👈 Message that shows up when function is used

  final response = await http.get(Uri.parse('https://api.github.com/repos/$owner/$repo/releases'));

  if (response.statusCode != 200) return false;

  dynamic data = jsonDecode(response.body);
  dynamic item;
  for (var i in data) {
    if (filterOutPreRelease) {
      if (i['prerelease'] == false) item = i;
    } else {
      item = i;
    }
  }

  if (item == null) return false;

  data = {
    'name': item['name'],
    'version': item['tag_name'],
    'published_at': item['published_at'],
    'download_link': item['assets'][0]['browser_download_url'],
    'description': item['body'],
    'pre_release': !filterOutPreRelease
  };

  dynamic r1 = currentRelease.replaceFirst('v', '').split('.');
  dynamic r2 = item['tag_name'].replaceFirst('v', '').split('.');
  bool isSame = true;
  for (int i = 0; i < r1.length; i++) {
    if (r1[i] != r2[i]) {
      isSame = false;
      break;
    }
  }

  data['new'] = !isSame;
  return data;
}
