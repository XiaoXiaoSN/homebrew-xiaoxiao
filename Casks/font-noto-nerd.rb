# This Cask is a partial copy from the official Homebrew repository:
# https://github.com/Homebrew/homebrew-cask/blob/main/Casks/font/font-n/font-noto-nerd-font.rb
# It includes only the Monospaced variant of the Noto Nerd Font to reduce download size.
#
# Terminology:
# - Noto: A font family commissioned by Google under the Apache License 2.0.
# - Noto Sans: The sans-serif (無襯線) typeface of the Noto family.
# - Mono: Refers to monospaced fonts, where every character has the same width. Ideal for coding.
# - Propo: Refers to proportional fonts, where character widths vary. Better for UI and documents.
# - Nerd Font: A font patched with a large number of developer-oriented icons and glyphs.

cask "font-noto-nerd" do
  version "3.4.0"
  sha256 "eb9038a1b788a3a3ee34324f5b2277954a1c301d241b0cc7b62e5ff890b544b9"

  url "https://github.com/ryanoasis/nerd-fonts/releases/download/v#{version}/Noto.zip"
  name "Noto Nerd Font (Monospaced)"
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
