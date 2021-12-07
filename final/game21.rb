class Game21
  attr_reader :dealer, :user, :deck, :rate

  CHOICE_OF_ACTION = [
      "Теперь ваш ход",
      "Введите 1, если вы хотите пропустить ход, тогда ход перейдет дилеру",
      "Введите 2, если вы хотите добавить еще одну карту из колоды",
      "Введите 3, если вы хотите открыть карты"
  ]

  CHOICE_OF_CONTINUE_GAME = [
      "Хотите продолжить игру?",
      "Введите 1, если вы хотите продолжить игру",
      "Введите 2, если вы хотите закончить игру",
  ]

  def initialize(dealer, user, rate = 10)
    @deck = Deck.new
    @dealer = dealer
    @user = user
    @rate = rate
    distribute_cards
  end

  def start
    loop do
      print_user_hand

      if user_choice
        puts "Вскрываем карты"

        disclosure_hands
        break unless continues?
      end

      dealer_choice

      if [user, dealer].all? { |gamer| gamer.hand.count == 3 }
        puts "У вас, #{user.name}, и у дилера по три карты, вскрываем карты"

        disclosure_hands
        break unless continues?
      end
    end
  end

  private

  def distribute_cards
    "#{user.name}: ставка - 10$"
    "#{dealer.name}: ставка - 10$"

    [dealer, user].each do |gamer|
      hand = Hand.new
      2.times { hand.add(deck.pick_up) }
      gamer.hand = hand
    end
  end

  def user_choice
    puts CHOICE_OF_ACTION

    input_user = input([1,2,3])

    case input_user
    when 1
      puts "Вы пропустили ход"
    when 2
      card = deck.pick_up
      user.hand.add(card)
      puts "#{user.name}: добавлена карта: #{card}"
    when 3
      true
    end

  rescue StandardError
    puts "У вас уже есть три карты, вы не можете взять больше"

    retry
  end

  def dealer_choice
    if dealer.hand.points >= 17
      puts "#{dealer.name} пропустил ход"
    else
      dealer.hand.add(deck.pick_up)
      puts "#{dealer.name} взял одну карту"
    end

  rescue StandardError
    puts "#{dealer.name} пропустил ход"
  end

  def input(number)
    begin
      input = gets.chomp
      Integer(input)
      input = input.to_i
      unless number.include?(input)
        raise "Необходимо выбрать значение из предложенных"
      end
    rescue ArgumentError => e
      retry
    end

    input
  end

  def disclosure_hands
    print_user_hand

    puts "Карты #{dealer.name}:"
    puts dealer.hand

    dealer_points = dealer.hand.points

    case user.hand.points
    when ->(n) { n == dealer_points }
      draw
    when ->(n) { n > 21 && dealer_points > 21 }
      draw
    when ->(n) { n > dealer_points }
      win
    else
      loss
    end
  end

  def print_user_hand
    puts "Ваши карты:"
    puts user.hand
  end

  def win
    user.up_balance 10
    dealer.dawn_balance 10
    puts "Вы выиграли 10$, ваш остаток #{user.money}$, остаток дилера #{dealer.money}$"
  end

  def loss
    dealer.up_balance 10
    user.dawn_balance 10
    puts "Вы проиграли 10$, ваш остаток #{user.money}$, остаток дилера #{dealer.money}$"
  end

  def draw
    puts "Ничья, деньги возвращаются в банк, ваш остаток #{user.money}$, остаток дилера #{dealer.money}$"
  end

  def continues?
    if user.money == 0
      puts "#{user.name}: проиграл все деньги"
    elsif dealer.money == 0
      puts "#{user.name}: выиграл весь банк дилера"
    else
      puts CHOICE_OF_CONTINUE_GAME

      input_user = input([1,2])

      case input_user
      when 1
        puts "Игра продолжается"
        distribute_cards
      when 2
        puts "Игра закончена"
      end
    end
  end
end