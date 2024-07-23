# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# default_password = SecureRandom.urlsafe_base64

# # Userをつくる
# User.create!(
#   name: "ゲストユーザー",
#   email: "guest@example.com",
#   password: default_password,
#   password_confirmation: default_password,
#   role: "guest")

# guest_user_id = User.find_by(role: "guest").id
# # profileもつくる
# Profile.create!(
#   user_id: guest_user_id,
#   gender: "man",
#   birthday: "2024-05-27")