
enum LayoutSize {
  mobile(maxWidth: 600),
  tablet(maxWidth: 800),
  desktop(maxWidth: double.infinity);

  final double maxWidth;
  const LayoutSize({required this.maxWidth});
}
