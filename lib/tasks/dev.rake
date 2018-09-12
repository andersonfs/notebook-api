# frozen_string_literal: true
namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do

    puts "Cadastrando os tipos de contato..."
    
    kinds = %w(Família Amigo Comercial Conhecido)
    kinds.each do |kind|
      Kind.create!(description: kind)
    end
    
    puts "Tipos Contato cadastrados com sucesso!"

    puts "Cadastrando os contatos..."
    100.times do |_i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(35.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts "Contatos cadastrados com sucesso."
  end
end