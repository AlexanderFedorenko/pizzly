# Characters for url short url generation
URL_CHARS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a

# Characters to be excluded
AMBIGUOUS_CHARS = %w(0 1 l L i I o O)

AMBIGUOUS_CHARS.each { |char| URL_CHARS.delete(char) }
