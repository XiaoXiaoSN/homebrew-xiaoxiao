cask "alt-tab-macos-free" do
  version "11.10.2"
  sha256 "5c9c2eda83551fcc49f33c3dc4332c0b203e3b7c0830855b2bd222bcf48c02eb"

  url "https://github.com/filipef101/alt-tab-macos-free/releases/download/v#{version}-unlocked/AltTab-#{version}-unlocked.zip"
  name "AltTab (Unlocked)"
  desc "Unofficial AltTab build with Pro feature restrictions removed"
  homepage "https://github.com/filipef101/alt-tab-macos-free"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)-unlocked$/i)
    strategy :github_latest
  end

  depends_on macos: :monterey

  conflicts_with cask: "alt-tab"

  app "AltTab.app"

  caveats <<~EOS
    This is an unofficial, self-signed build that is not notarized by Apple.
    If macOS blocks it on first launch, review the app in
    System Settings > Privacy & Security and choose Open Anyway.

    Grant Accessibility permission for window switching and Screen Recording
    permission for window thumbnails in System Settings > Privacy & Security.
    Switching from the official AltTab may require re-granting permissions
    because the signing identity is different.
  EOS
end
