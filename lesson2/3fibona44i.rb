fib = [0, 1]

loop do
  chislo = fib[-1] + fib[-2]
  if chislo < 100
    fib << chislo
  else
    break
  end  
end

puts fib
