glasn = ['a', 'e', 'i', 'o', 'u']
hash = {}

n = 1

('a'..'z').each do |letter|
  if glasn.include?(letter)
    hash[letter] = n
  end
  n += 1
end

puts hash
