# Copy from
# https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-noto-nerd-font.rb

cask "font-noto-nerd-font" do
  version "2.1.0"
  sha256 "1f90f44ff557dd0d8f2ac50822c1ee53aa898a907e6d308e96913a479c65beca"

  url "https://github.com/ryanoasis/nerd-fonts/releases/download/v#{version}/Noto.zip"
  appcast "https://github.com/ryanoasis/nerd-fonts/releases.atom"
  name "Noto Nerd Font families (Noto)"
  homepage "https://github.com/ryanoasis/nerd-fonts"

  font "Noto Emoji Nerd Font Complete Mono.ttf"
  font "Noto Emoji Nerd Font Complete.ttf"
  font "Noto Sans Mono ExtraLight Nerd Font Complete Mono.ttf"
  font "Noto Sans Mono ExtraLight Nerd Font Complete.ttf"
  font "Noto Sans Mono Light Nerd Font Complete Mono.ttf"
  font "Noto Sans Mono Light Nerd Font Complete.ttf"
  font "Noto Sans Mono Medium Nerd Font Complete Mono.ttf"
  font "Noto Sans Mono Medium Nerd Font Complete.ttf"
  font "Noto Sans Mono Regular Nerd Font Complete Mono.ttf"
  font "Noto Sans Mono Regular Nerd Font Complete.ttf"
  font "Noto Sans Mono SemiBold Nerd Font Complete Mono.ttf"
  font "Noto Sans Mono SemiBold Nerd Font Complete.ttf"
end
