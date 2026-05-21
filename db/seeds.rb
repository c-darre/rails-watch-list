require 'open-uri'
require 'json'

puts "Nettoyage de la base de données..."
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

puts "Création des films depuis l'API TMDB (via le proxy Le Wagon)..."

# On utilise l'URL du proxy Le Wagon qui n'a PAS besoin de clé API
url = "https://tmdb.lewagon.com/movie/top_rated"

user_serialized = URI.open(url).read
movies = JSON.parse(user_serialized)

movies["results"].each do |movie_hash|
  puts "Création du film : #{movie_hash['title']}..."

  Movie.create!(
    title: movie_hash['title'],
    overview: movie_hash['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_hash['poster_path']}",
    rating: movie_hash['vote_average']
  )
end

puts "Terminé ! #{Movie.count} films ont été créés avec succès."
