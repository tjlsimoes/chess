# Code adapted from https://github.com/rlmoser99/ruby_hangman
# Contains methods to save or load a game
module Database
  def save_game
    @save = true
    Dir.mkdir 'output' unless Dir.exist? 'output'
    @filename = "#{random_name}_game.yaml"
    File.open("output/#{@filename}", 'w') { |file| file.write save_to_yaml }
    puts display_saved_name
  end

  def save_to_yaml
    YAML.dump(
      'board' => @board,
      'first_player' => @first_player,
      'second_player' => @second_player,
      'current_player' => @current_player
    )
  end

  def random_name
    adjective = %w[red best dark fun blue cold last tiny new pink]
    nouns = %w[car hat star dog tree foot cake moon key rock]
    "#{adjective[rand(0 - 9)]}_#{nouns[rand(0 - 9)]}_#{rand(11..99)}"
  end

  def find_saved_file
    show_file_list
    file_number = game_selection_input(display_saved_prompt, /\d+|^exit$/)
    @saved_game = file_list[file_number.to_i - 1] unless file_number == 'exit'
  end

  def show_file_list
    puts display_saved_games('#', 'File Name(s)')
    file_list.each_with_index do |name, index|
      puts display_saved_games((index + 1).to_s, name.to_s)
    end
  end

  def file_list
    files = []
    Dir.entries('output').each do |name|
      files << name if name.match(/(game)/)
    end
    files
  end

  def load_game
    find_saved_file
    load_saved_file
    @save = false
    board.show
    player_turns
    File.delete("output/#{@saved_game}") if File.exist?("output/#{@saved_game}")
    conclusion
  rescue StandardError
    puts display_load_error
  end

  def load_saved_file
    file = YAML.safe_load(File.read("output/#{@saved_game}"),
                          permitted_classes: [Board, King, Rook,
                                              Pawn, Player, Knight,
                                              Bishop, Queen],
                          aliases: true)
    @board = file['board']
    @first_player = file['first_player']
    @second_player = file['second_player']
    @current_player = file['current_player']
  end
end
