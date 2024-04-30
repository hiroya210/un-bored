# Require other files
require_relative '../db/seeds/users_seeds'
require_relative '../db/seeds/game_contents_seeds'

# Destroy previous seeds
puts "Deleting previous seeds..."

PlayerInput.destroy_all
Round.destroy_all
GameContent.destroy_all
Game.destroy_all
Player.destroy_all
Instance.destroy_all
User.destroy_all

puts "Previous seeds have been deleted!"

puts "Deleting previous 1000 cloudinary avatars..."
Cloudinary::Api.delete_all_resources
puts "Previous 1000 cloudinary avatars deleted!"


# Create Users seeds
puts "Creating users..."

CreateUsersSeeds.generate_users

puts "Users have been created!"


# Create Game Never Have I ever
puts "Creating the game 'Never Have I Ever'..."

game = Game.create!(name: "Have You Ever?", image: "party.jpg")

puts "Creating the other games..."

Game.create!(name: "Picture Me", image: "splash.png")
Game.create!(name: "Oukami", image: "wolf.jpg")
Game.create!(name: "Mad Libs", image: "human.jpg")
Game.create!(name: "Spank the Bank!", image: "bank.jpg")

puts "Game creation Complete!"


# Create Contents for Never Have I ever
puts "Creating contents for 'Never Have I Ever'..."

sentences = CreateGameContentsSeeds.generate_sentences
sentences.each { |sentence| GameContent.create!(content: sentence, game_id: game.id) }

puts "Contents for the game have been created!"
