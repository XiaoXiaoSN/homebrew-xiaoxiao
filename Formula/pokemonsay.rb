class Pokemonsay < Formula
  desc '"pokesay" is like "cowsay" but for pokémon.'
  homepage "https://github.com/XiaoXiaoSN/pokesay"
  url "https://github.com/XiaoXiaoSN/pokesay/tarball/v1.0.1"
  sha256 "43511be3dbb52b380bf7501e3b06a0a17ee0349d0246601537481ca811753a4a"
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
