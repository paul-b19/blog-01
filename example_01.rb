require 'catpix'
require "tty-prompt"

@prompt = TTY::Prompt.new

def render(file_path)
    Catpix::print_image file_path,
        :limit_x => 0.2,
        :resolution => "high"
end

def selection
    @prompt.select("Please select character: \n\n") do |menu|
        menu.choice "Chewbacca", -> {render("./pics/Chewbacca.png")}
        menu.choice "Darth Vader", -> {render("./pics/DarthVader.png")}
        menu.choice "Yoda", -> {render("./pics/Yoda.png")}
    end
end

puts "\e[H\e[2J"
selection
