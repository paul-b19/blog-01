require 'catpix'
require "tty-prompt"
require "tty-pie"

@prompt = TTY::Prompt.new
@own_character = false


def render(file_path)
    Catpix::print_image file_path,
        :limit_x => 0.2,
        :resolution => "high"
end
  
def selection
    puts "\e[H\e[2J"
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
        menu.choice "Info", -> {info(character)}
        if @own_character
            menu.choice "Sell", -> {@own_character = false; character_menu(character)}
        else
            menu.choice "Buy", -> {@own_character = true; character_menu(character)}
        end
        menu.choice "Back", -> {selection}
    end
end

def info(character)
    puts "\e[H\e[2J"
    puts "-------< FORCE BALANCE >-------\n\n"
    data = [
        { name: 'Dark Side', value: 50, fill: '⚫️' },
        { name: 'Light Side', value: 50, fill: '⚪️' }
    ]
    if character == "./pics/Chewbacca.png"
        data[0][:value] = 30
        data[1][:value] = 70
    elsif character == "./pics/DarthVader.png"
        data[0][:value] = 90
        data[1][:value] = 10
    elsif character == "./pics/Yoda.png"
        data[0][:value] = 10
        data[1][:value] = 90
    end
    @pie_chart = TTY::Pie.new(data: data, radius: 7)
    print @pie_chart
end

selection
