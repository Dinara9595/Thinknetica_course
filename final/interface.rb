require_relative 'player'
require_relative 'dealer'
require_relative 'user'
require_relative 'card'
require_relative 'hand'
require_relative 'deck'
require_relative 'game21'

REPEAT_GAMES = [
    "Хотите сыграть еще раз?",
    "Введите 1, если да",
    "Введите 2, если нет"
]

puts "Здравствуйте, давайте сыграем с вами в игру «21»! Как вас зовут?"
input = gets.chomp
puts "Привет, #{input}!"
user = User.new(input)
dealer = Dealer.new

loop do
  game = Game21.new(dealer, user)
  game.start

  puts REPEAT_GAMES

  break if gets.to_i == 2
end

puts "Ваш выигрыш: #{user.money}$, дилера выигрыш: #{dealer.money}$"