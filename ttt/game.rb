require './player.rb'
class Game

    def initialize(player1, player2)
        @board = Hash.new(nil)
        initialize_board
        @player1 = Player.new(player1, "X")
        @player2 = Player.new(player2, "0")
        @player_turn = pick_first_player
        play
    end
    
    def play
        while true
            result = game_result
            unless result == "ongoing"
                if result.is_a?(Player)
                    display_board
                    puts "Game over  - #{result.name} Wins !! "
                    puts "Play again? (Y/N)"
                elsif result == "draw"
                    display_board
                    puts "No more places - Game is a Draw - Play again? (Y/N)"
                end
                while answer = gets.chomp.upcase                
                    if answer == "N"
                        exit
                    elsif answer == "Y"
                        initialize_board
                        @player_turn = pick_first_player
                        break
                    else
                        puts "Invalid selection!!"
                    end                
                end
            end
            display_board
            puts "#{@player_turn.name} (#{@player_turn}) - It is your turn!!"
            place = gets.chomp
            unless cell_is_valid?(place.to_sym)
                puts "Invalid placement - Try again!!"
                place = gets.chomp
            end
            unless cell_is_free?(place.to_sym)
                puts "#{place} is all ready taken - Try again!!"
                place = gets.chomp
            end
            place_token(place.to_sym)
            @player_turn = @player_turn == @player1 ? @player2 : @player1
        end

    end
    
    def display_board
        puts "\e[H\e[2J"
        puts "\t tic-tac-toe"
        puts ""
        puts "\t    A | B | C "
        puts "\t  ------------"
        puts "\t1 | #{@board[:a1]} | #{@board[:b1]} | #{@board[:c1]} "
        puts "\t--------------"
        puts "\t2 | #{@board[:a2]} | #{@board[:b2]} | #{@board[:c2]} "
        puts "\t--------------"
        puts "\t3 | #{@board[:a3]} | #{@board[:b3]} | #{@board[:c3]} "
        puts ""        
    end

    def place_token(cell)
        @board[cell] = @player_turn        
    end


    def pick_first_player
        (Random.rand(100_000) % 2) == 0 ? @player1 : @player2
    end

    def cell_is_free?(cell)
        @board[cell].is_a?(Player) ? false : true
    end

    def cell_is_valid?(cell)
        @board[cell] == nil ? false : true
    end

    def game_result
        return @player_turn if victory?
        return "draw" if draw?
        return "ongoing"
    end

    def initialize_board
        @board[:a1] = ' '
        @board[:a2] = ' '
        @board[:a3] = ' '
        @board[:b1] = ' '
        @board[:b2] = ' '
        @board[:b3] = ' '
        @board[:c1] = ' '
        @board[:c2] = ' '
        @board[:c3] = ' '
    end

    def draw?
        return @board.has_value?(' ') ? false : true
    end

    def victory?
        if ((@board[:a1] == @board[:a2]) && (@board[:a1] == @board[:a3]) && (@board[:a1].is_a?(Player))) ||
           ((@board[:b1] == @board[:b2]) && (@board[:b1] == @board[:b3]) && (@board[:b1].is_a?(Player))) ||
           ((@board[:c1] == @board[:c2]) && (@board[:c1] == @board[:c3]) && (@board[:c1].is_a?(Player))) ||
           ((@board[:a1] == @board[:b1]) && (@board[:a1] == @board[:c1]) && (@board[:a1].is_a?(Player))) ||
           ((@board[:a2] == @board[:b2]) && (@board[:a2] == @board[:c2]) && (@board[:a2].is_a?(Player))) ||
           ((@board[:a3] == @board[:b3]) && (@board[:a3] == @board[:c3]) && (@board[:a3].is_a?(Player))) ||
           ((@board[:a1] == @board[:b2]) && (@board[:a1] == @board[:c3]) && (@board[:a1].is_a?(Player))) ||
           ((@board[:a3] == @board[:b2]) && (@board[:a3] == @board[:c1]) && (@board[:a3].is_a?(Player)))           
                return true
        else
                return false
        end        
    end
end
