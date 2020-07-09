# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
ShelterReview.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create!(name: "Test Shelter1", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
shelter2 = Shelter.create!(name: "Test Shelter2", address: "222 Test Address", city: "Test City2", state: "CO", zip: "80211")

pet1 = shelter1.pets.create!(
          image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
          name: "Bailey",
          approximate_age: "3",
          sex: "Female",
          description: "A loving 3 year old pup looking for a partner to play fetch with!",
          status: "Adoptable"
          )
pet2 = shelter1.pets.create!(
          image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
          name: "Ruby",
          approximate_age: "3",
          sex: "Female",
          description: "A loving 3 year old pup looking for a partner to play fetch with!",
          status: "Adoptable"
          )
pet3 = shelter1.pets.create!(
          image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
          name: "Bubba",
          approximate_age: "13",
          sex: "Male",
          description: "A loving 3 year old pup looking for a partner to play fetch with!",
          status: "Adoptable"
          )
pet4 = shelter2.pets.create!(
          image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
          name: "Socks",
          approximate_age: "3",
          sex: "Female",
          description: "A loving 3 year old pup looking for a partner to play fetch with!",
          status: "Adoptable"
          )
          
shelter_review1 = shelter1.shelter_reviews.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg")
shelter_review2 = shelter2.shelter_reviews.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.")
