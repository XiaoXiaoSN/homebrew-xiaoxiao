class Pokemonsay < Formula
  desc '"pokemonsay" is like "cowsay" but for pokémon.'
  homepage "https://github.com/XiaoXiaoSN/pokemonsay"
  url "https://github.com/XiaoXiaoSN/pokemonsay/tarball/v1.0.1"
  sha256 ""
  version "v1.0.1"

  depends_on "cowsay" => :recommended
  depends_on "coreutils" => [:recommended, "with-default-names"] if not OS.linux?

  # `with-default-names` installs `gshuf` as `shuf`.

  # `coreutils` can't be installed on linux AFAIK. But linux already
  # has `shuf`, so no need for that.

  def install
    system "cp", "-r", "./cows", "#{prefix}/cows"
    system "cp", "pokemonsay.sh", "pokesay"
    system "cp", "pokemonthink.sh", "pokethink"

    inreplace "pokesay", /^pokemon_path=.*$/, "pokemon_path=#{prefix}/cows"
    # inreplace "pokemonsay", /\bshuf\b/, "gshuf" if not OS.linux?

    bin.install "pokesay"
    bin.install "pokethink"
  end

  test do
    system "false"
  end
end
