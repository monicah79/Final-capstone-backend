# create a user
user = User.create(email: 'user@example.com', password: 'password')
user.save

# create a laptop
laptop: {
          name: 'MacBook Pro',
          price: 1299.99,
          cpu: 'Intel Core i7',
          memory: 16,
          picture: 'https',
          storage: 512
        }

# create reservation
reservation: {
            laptop_id: laptop.id,
            quantity: 1,
            city: 'New York'
          }