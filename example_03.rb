require 'catpix'
require "tty-prompt"

@prompt = TTY::Prompt.new
@own_character = false

def render(file_path)
    Catpix::print_image file_path,
        :limit_x => 0.2,
        :resolution => "high"
end
  
def selection
    puts " "
    @prompt.select("Please select character: \n\n") do |menu|
        Dir['./pics/*'].each do |character|
            menu.choice character.delete_prefix("./pics/").delete_suffix(".png"), -> {character_menu(character)}
        end
    end
end

def character_menu(character)
    puts "\e[H\e[2J"
    render(character)
    puts " "
    @prompt.select("Character menu: \n\n") do |menu|
        menu.choice "Info", -> {puts "WIP"}
        if @own_character
            menu.choice "Sell", -> {@own_character = false; character_menu(character)}
        else
            menu.choice "Buy", -> {@own_character = true; character_menu(character)}
        end
        menu.choice "Back", -> {selection}
    end
end

puts "\e[H\e[2J"
selection