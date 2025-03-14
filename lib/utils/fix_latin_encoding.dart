String fixEncoding(String input) {
  return input
    .replaceAll('Å+', 'Ñ')
    .replaceAll('Ã±', 'ñ')
    .replaceAll('Ã©', 'é')
    .replaceAll('Ã³', 'ó')
    .replaceAll('Ã¡', 'á')
    .replaceAll('Ã­', 'í')
    .replaceAll('Ãº', 'ú');
}