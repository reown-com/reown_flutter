class GridItem<T> {
  final String image;
  final String id;
  final String title;
  final bool disabled;
  final T data;

  GridItem({
    required this.image,
    required this.id,
    required this.title,
    required this.data,
    this.disabled = false,
  });

  GridItem<T> copyWith({
    String? image,
    String? id,
    String? title,
    bool? disabled,
    T? data,
  }) {
    return GridItem<T>(
      image: image ?? this.image,
      id: id ?? this.id,
      title: title ?? this.title,
      disabled: disabled ?? this.disabled,
      data: data ?? this.data,
    );
  }
}
