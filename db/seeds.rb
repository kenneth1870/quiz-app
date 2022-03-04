# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FactoryBot.create(:user, email: 'admin@gmail.com', password: 'admins', password_confirmation: 'admins')

FactoryBot.create_list(:checklist_with_questions, 5)

FactoryBot.create(:audit, form: Form.find(rand(10)+1))
