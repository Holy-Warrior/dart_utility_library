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
final result = await githubReleaseCheck(
  'flutter',     // user name
  'flutter',     // repo name
  'v3.19.0',     // current version
  true           // filter out pre-release versions
);
```
