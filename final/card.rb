class Card
  attr_accessor :cards_user, :cards_dealer, :cards_dealer_encoded, :array_after_distribution

  CARDS = [
      %w[2+ 2<3 2^ 2<>],
      %w[3+ 3<3 3^ 3<>],
      %w[4+ 4<3 4^ 4<>],
      %w[5+ 5<3 5^ 5<>],
      %w[6+ 6<3 6^ 6<>],
      %w[7+ 7<3 7^ 7<>],
      %w[8+ 8<3 8^ 8<>],
      %w[9+ 9<3 9^ 9<>],
      %w[10+ 10<3 10^ 10<>
       J+ J<3 J^ J<>
       D+ D<3 D^ J<>
       K+ K<3 K^ K<>],
      %w[A+ A<3 A^ A<>]
  ]

  ACE = %w[1 11]

  def distribution_of_cards
    array_cards = CARDS.flatten
    @cards_user = array_cards.sample(2)
    #@cards_user = %w[J+ 2<>]
    array_cards.delete(@cards_user[0])
    array_cards.delete(@cards_user[1])
    @cards_dealer = array_cards.sample(2)
    #@cards_dealer = %w[K<3 2^]
    array_cards.delete(@cards_dealer[0])
    array_cards.delete(@cards_dealer[1])
    @array_after_distribution = array_cards
  end

  def change_array_cards
    array_number = %w[2 3 4 5 6 7 8 9 10] << ACE
    @change_array_cards = CARDS.map.with_index { |array, index| array << array_number[index]}
  end

  def sum_of_points(cards_player)
    sum_number_player = []
    i = 0
    while i <= cards_player.size - 1
      @change_array_cards.each do |value|
        if value.include?(cards_player[i])
          sum_number_player << value.last
        else
          next
        end
      end
      i+=1
    end
    sum_number_include_ace(sum_number_player)
  end

  def sum_number_include_ace(sum_number_player)
    sum_total = []
    element_arr_ace = []
    arr_num_sum = []
    element_arr_aces = []
    sum_number_player.each do |element_arr|
      if element_arr == ACE
        element_arr_ace = element_arr.map{|num| num.to_i}
        element_arr_aces << element_arr_ace
      else
        sum_total << element_arr.to_i
      end
    end

    if element_arr_ace.empty?
      [sum_total.sum]
    else
      @size_arr = element_arr_aces.size if element_arr_aces
      element_arr_ace.each{|num| arr_num_sum << sum_total.sum + @size_arr * num}
      arr_num_sum
    end
  end
end