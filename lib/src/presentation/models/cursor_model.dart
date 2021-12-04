class Cursor {
  /// [offset] indicate the offset of the search
  final int offset;

  /// [limit] indicate the elements limits of a result
  final int limit;

  const Cursor({
    this.offset = 0,
    this.limit = 5,
  });

  Cursor get def => const Cursor(
        offset: 0,
        limit: 5,
      );

  @override
  String toString() => '$runtimeType{ '
      'offset: $offset, '
      'limit: $limit'
      ' }';

  Cursor copyWith({int? offset, int? limit}) {
    return Cursor(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
