# challenge_week7

A new Flutter project.

## Modul 7: JSON dan REST API

Aplikasi ini menyediakan tab **API Post** yang terhubung ke
[JSONPlaceholder](https://jsonplaceholder.typicode.com). Tab tersebut memuat,
mencari, memfilter, menambah, mengubah, dan menghapus post menggunakan Dio dan
Retrofit. JSONPlaceholder adalah API contoh; perubahan tambah, ubah, dan hapus
tidak disimpan secara permanen oleh server.

Model JSON, client, service, repository, dan halaman API berada di dalam folder
`lib/models`, `lib/services`, `lib/repositories`, dan `lib/screens`.
Untuk membuat ulang file Retrofit dan JSON serializer setelah mengubah model
atau service, jalankan:

```shell
dart run build_runner build
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
