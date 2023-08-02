# Copy from https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-noto-nerd-font.rb
# we don't need to install all fonts, so we just copy the font we need
#
# NOTE:
# `Noto` = Noto is a font family that Commissioned by Google under the Apache License 2.0
# `Noto Sans` = Noto Sans is a sans-serif (無襯線) font family
# `Mono` = Monospaced Fonts (All same width - good for developers)
# `Propo` = Proportional Fonts (GUI elements or edit a presentation etc)
# `Nerd` = Nerd Fonts patches developer targeted fonts with a high number of glyphs (icons)

cask "font-noto-nerd" do
  version "3.0.2"
  sha256 "075927e1725c93efd9ba230499d98291559f45356b0b56b1e545ec3eda946a6f"

  url "https://github.com/ryanoasis/nerd-fonts/releases/download/v#{version}/Noto.zip"
  name "Noto Nerd Font families (Noto)"
  desc "Developer targeted fonts with a high number of glyphs"
  homepage "https://github.com/ryanoasis/nerd-fonts"

  livecheck do
    url :url
    strategy :github_latest
  end

  font "NotoSansMNerdFontMono-Black.ttf"
  font "NotoSansMNerdFontMono-Bold.ttf"
  font "NotoSansMNerdFontMono-ExtraBold.ttf"
  font "NotoSansMNerdFontMono-ExtraLight.ttf"
  font "NotoSansMNerdFontMono-Light.ttf"
  font "NotoSansMNerdFontMono-Medium.ttf"
  font "NotoSansMNerdFontMono-Regular.ttf"
  font "NotoSansMNerdFontMono-SemiBold.ttf"
  font "NotoSansMNerdFontMono-Thin.ttf"
end
