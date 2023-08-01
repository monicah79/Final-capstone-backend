# create a user
user = User.create(email: 'user@example.com', password: 'password')
user.save

# create a laptop
laptop = Laptop.create(
  name: 'Example Laptop',
  price: 999.99,
  cpu: 'Intel Core i7',
  picture: 'https://example.com/laptop.jpg',
  memory: 16,
  storage: 512,
  user: user
)

puts "Created laptop: #{laptop.name}"