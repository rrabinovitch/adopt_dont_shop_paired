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

shelter1 = Shelter.create!(name: "Test Shelter1", address: "114 Test Blvd", city: "Aurora", state: "CO", zip: "80202")
shelter2 = Shelter.create!(name: "Test Shelter2", address: "222 Sample St", city: "Denver", state: "CO", zip: "80211")

pet1 = shelter1.pets.create!(image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", name: "Bailey", approximate_age: "3", sex: "Female", description: "A good dog", status: "Adoptable")
pet2 = shelter1.pets.create!(image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg", name: "Ruby", approximate_age: "3", sex: "Female", description: "A loving dog", status: "Adoptable")
pet3 = shelter1.pets.create!(image: "https://www.thesprucepets.com/thmb/kV_cfc9P4QWe-klxZ8y--awxvY4=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/adorable-white-pomeranian-puppy-spitz-921029690-5c8be25d46e0fb000172effe.jpg", name: "Bubba", approximate_age: "13", sex: "Male", description: "A getching dog", status: "Adoptable")
pet4 = shelter2.pets.create!(image: "https://www.sciencemag.org/sites/default/files/styles/article_main_image_-_1280w__no_aspect_/public/pearl_16x9.jpg?itok=tbir55jF", name: "Socks", approximate_age: "3", sex: "Female", description: "A nice dog", status: "Adoptable")

shelter_review1 = shelter1.shelter_reviews.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg")
shelter_review2 = shelter2.shelter_reviews.create!(title: "Pretty good shelter", rating: 4, content: "Has good dogs.")

adoption_application1 = AdoptionApplication.create!(name: "Garrett G", address: "24352 Colfax Ave", city: "Boulder", state: "CO", zip: "80004", phone_number: "845-285-4885", description: "I deserve all the pets.")
adoption_application2 = AdoptionApplication.create!(name: "Ruthie R", address: "13278 Pearl St", city: "Denver", state: "CO", zip: "80205", phone_number: "346-123-9465", description: "Gimme a pet.")

garrett_pet1_app = PetAdoptionApplication.create!(adoption_application_id: adoption_application1.id, pet_id: pet1.id, status: "Pending")
garrett_pet2_app = PetAdoptionApplication.create!(adoption_application_id: adoption_application1.id, pet_id: pet2.id, status: "Pending")
ruthie_pet1_app = PetAdoptionApplication.create!(adoption_application_id: adoption_application2.id, pet_id: pet1.id, status: "Pending")
