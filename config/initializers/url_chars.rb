# Characters for url short url generation
ALLOWED_URL_CHARS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

# Characters to be excluded
AMBIGUOUS_URL_CHARS = %w(0 1 l L i I o O)

AMBIGUOUS_URL_CHARS.each { |char| ALLOWED_URL_CHARS.delete(char) }
