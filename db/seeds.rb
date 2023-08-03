# create a user
user = User.create!(email: 'user@example.com', password: 'password')


# create a laptop
laptop= Laptop.create!(
          user_id: user.id,
          name: 'MacBook Pro',
          price: 1299.99,
          cpu: 'Intel Core i7',
          memory: 16,
          picture: 'https://khareedomobile.pk/wp-content/uploads/2023/04/Macbook-Pro-M2.png',
          storage: 512
)

# create reservation
reservation = Reservation.new
reservation.user = user

if reservation.save
  laptop_reservation = LaptopReservation.create(
    reservation_id: reservation.id,
    laptop_id: laptop.id,
    quantity: 1,
    city: 'New York'
  )
end
