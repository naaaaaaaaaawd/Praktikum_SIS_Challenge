import 'package:challenge_week7/models/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Post converts JSON to a model and back', () {
    final json = {
      'userId': 4,
      'id': 12,
      'title': 'Contoh judul',
      'body': 'Contoh isi',
    };

    final post = Post.fromJson(json);

    expect(post.userId, 4);
    expect(post.id, 12);
    expect(post.title, 'Contoh judul');
    expect(post.body, 'Contoh isi');
    expect(post.toJson(), json);
  });

  test('copyWith keeps values that are not replaced', () {
    const post = Post(userId: 2, id: 8, title: 'Judul awal', body: 'Isi awal');

    final updated = post.copyWith(title: 'Judul baru');

    expect(updated.userId, 2);
    expect(updated.id, 8);
    expect(updated.title, 'Judul baru');
    expect(updated.body, 'Isi awal');
  });
}
