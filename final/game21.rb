require_relative './player.rb'
require_relative './dealer.rb'
require_relative './user.rb'
require_relative './card.rb'

class Game

  attr_accessor :user, :dealer

CHOICE_OF_ACTION = [
    "Введите 1, если вы хотите пропустить ход, тогда ход перейдет дилеру",
    "Введите 2, если вы хотите добавить еще одну карту из колоды",
    "Введите 3, если вы хотите открыть карты"
]

REPEAT_GAMES = [
    "Хотите сыграть еще раз?",
    "Введите 1, если да",
    "Введите 2, если хотите закончить игру"
]

GAME_OVER = ["Конец игры!"]

  def menu
    start
    play
  end

  def play
    distribution
    display_bet
    display_cards(@user.name, @user_cards)
    display_cards(@dealer.name, @cards_dealer_encoded)
    @dealer_sum_of_points = @class_card.sum_of_points(@dealer_cards)
    @user_sum_of_points = @class_card.sum_of_points(@user_cards)
    display_sum(@user_sum_of_points, @user.name)
    choice
  end

  def display_sum(arr_num_sum, name_player)
    if arr_num_sum.size == 1
      puts "#{name_player}: сумма очков #{arr_num_sum[0]}"
    elsif arr_num_sum.size == 2
      puts "#{name_player}: так как имеется туз, сумма очков #{arr_num_sum[0]} или #{arr_num_sum[1]}"
    end
  end

  def display_cards(name_player, cards_player)
    puts "#{name_player}: карты #{cards_player}"
  end

  def start
    puts "Здравствуйте, давайте сыграем с вами в игру «21»! Как вас зовут?"
    @dealer = Dealer.new(@dealer_cards)
    input = gets.chomp
    puts "Привет, #{input}!"
    @user = User.new(@user_cards, input)
  end

  def distribution
    @class_card = Card.new
    @class_card.change_array_cards
    @class_card.distribution_of_cards
    @dealer_cards = @class_card.cards_dealer
    @cards_dealer_encoded = @dealer_cards.map { |card| card="*"}
    @user_cards = @class_card.cards_user
  end

  def display_bet
    if @user.money != 0 && @dealer.money != 0
      bet(@user.money, @user.name)
      bet(@dealer.money, @dealer.name)
    else
      puts "Нечем делать ставку одному из игроков"
      game_over
    end
  end

  def bet(player_money, name_player)
    if player_money != 0
      player_money = player_money - 10
      puts "#{name_player}: ставка - 10$, остаток суммы #{player_money}$"
    end
  end

  def game_over
    puts GAME_OVER
    quit(@user.name, @user.money)
    quit(@dealer.name, @dealer.money)
    exit!
  end

  def quit(name_player, money_player)
    puts "#{name_player}: выигрыш #{money_player}$"
  end

  def choice
    puts CHOICE_OF_ACTION
    input_user = input([1,2,3])
    case input_user
    when 1
      dealer_play     #user пропускает ход, тогда играет дилер
    when 2
      add_card(@user_cards)
    when 3
      open_cards
    end
  end

  def input(number)
    begin
      input = gets.chomp
      Integer(input)
      input = input.to_i
      unless number.include?(input)
        raise "Необходимо выбрать значение из предложенных"
      end
    rescue Exception => e
      puts "Error: #{e.message}"
      retry
    end
    input
  end

  def dealer_play
    dealer_arr_of_points = @class_card.sum_of_points(@dealer_cards)
    dealer_decisions(dealer_arr_of_points)
  end

  def dealer_decisions(dealer_arr_of_points)
    transmit("Дилер пропустил ход") if dealer_arr_of_points.last >= 17 || @dealer_cards.size == 3
    dealer_add_card if dealer_arr_of_points.last < 17 && @dealer_cards.size < 3
    three_cards if @dealer_cards.size == 3 && @user_cards.size == 3
  end

  def add_card(card_player)
    if card_player.size < 3
      card_player << @class_card.array_after_distribution.sample(1)
      if card_player == @user_cards
        @user_cards = card_player.flatten
        puts "Вы взяли одну карту."
        @user_sum_of_points = @class_card.sum_of_points(@user_cards)
        display_sum(@user_sum_of_points, @user.name)
        if @dealer_cards.size == 3 && @user_cards.size == 3
          three_cards
        else
          dealer_play
        end
      elsif card_player == @dealer_cards
        @dealer_cards = card_player.flatten
        @dealer_sum_of_points = @class_card.sum_of_points(@dealer_cards)
      end
    else card_player.size == 3
      puts "У вас уже есть три карты, вы не можете взять больше"
      choice
    end
  end

  def dealer_add_card
    add_card(@dealer_cards)
    puts "Дилер взял одну карту"
    if @user_cards.size < 3
      puts "Теперь ваш ход"
      choice
    elsif @user_cards.size == 3
      three_cards
    end
  end

  def three_cards
    puts "У вас и у дилера по три карты, вскрываем карты"
    open_cards
  end

  def transmit(line)
    puts "#{line}. Теперь ваш ход"
    choice
  end

  def result(arr_user, arr_dealer)
    #если двойной массив то первое число всегда меньше второго
    compare_total(arr_user[0], arr_dealer[0]) if arr_user.size == 1 && arr_dealer.size == 1
    compare_total(arr_user[0], compare(arr_dealer)) if arr_user.size == 1 && arr_dealer.size == 2
    compare_total(compare(arr_user), arr_dealer[0]) if arr_user.size == 2 && arr_dealer.size == 1
    compare_total(compare(arr_user), compare(arr_dealer)) if arr_user.size == 2 && arr_dealer.size == 2
  end

  def compare(arr)
    return arr.max if arr[0] <= 21 && arr[1] <= 21
    return arr.min if arr[0] > 21 && arr[1] > 21
    return arr[0] if arr[0] < 21 && arr[1] > 21
    return arr[1] if arr[0] > 21 && arr[1] < 21
  end

  def compare_total(user, dealer)
    draw if user == dealer || user > 21 && dealer > 21
    win  if dealer > 21 && user <= 21
    loss if user > 21 && dealer <= 21
    win  if user > dealer && dealer < 21 && user <= 21
    loss if user < dealer && dealer <= 21 && user < 21
  end

  def win
    @user.money += 10
    @dealer.money -= 10
    puts "Вы выиграли 10$, ваш остаток #{@user.money}$, остаток дилера #{@dealer.money}$"
  end

  def loss
    @dealer.money += 10
    @user.money -= 10
    puts "Вы проиграли 10$, ваш остаток #{@user.money}$, остаток дилера #{@dealer.money}$"
  end

  def draw
    @user.money += 10
    @dealer.money += 10
    puts "Ничья, деньги возвращаются в банк, ваш остаток #{@user.money}$, остаток дилера #{@dealer.money}$"
  end

  def open_cards
    display_cards(@user.name, @user_cards)
    display_cards(@dealer.name, @dealer_cards)
    display_sum(@user_sum_of_points, @user.name)
    display_sum(@dealer_sum_of_points, @dealer.name)
    result(@user_sum_of_points, @dealer_sum_of_points)
    end_of_game
  end

  def end_of_game
    puts REPEAT_GAMES
    input_user = input([1,2])
    case input_user
    when 1
      play
    when 2
      game_over
    end
  end
end
