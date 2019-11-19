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
        Dir['./pics/*'].each do |character|
            menu.choice character.delete_prefix("./pics/").delete_suffix(".png"), -> {render(character)}
        end
    end
end

puts "\e[H\e[2J"
selection