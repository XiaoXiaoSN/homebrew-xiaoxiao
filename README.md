homebrew-xiaoxiao
=================

This repository contains Homebrew formulas I have created.

```bash
brew tap xiaoxiaosn/xiaoxiao
```

```bash
# Install something
brew install font-noto-nerd # or xiaoxiaosn/xiaoxiao/font-noto-nerd

brew install xiaoxiaosn/xiaoxiao/pokesay
```

## AltTab (unofficial unlocked fork)

The `alt-tab-macos-free` cask installs [filipef101/alt-tab-macos-free](https://github.com/filipef101/alt-tab-macos-free) from a version-pinned GitHub release with a SHA-256 checksum.

```bash
brew install --cask xiaoxiaosn/xiaoxiao/alt-tab-macos-free
```

Both the official AltTab and this fork install `AltTab.app` with the same bundle ID, so they cannot coexist. If you installed the official cask, run `brew uninstall --cask alt-tab` first. For a manually installed copy, quit AltTab and move it out of `/Applications` before installing this cask.

**Security:** The fork is self-signed and not notarized by Apple. If macOS blocks its first launch, review the app and use **System Settings > Privacy & Security > Open Anyway**. Do not disable Gatekeeper system-wide. Enable **Accessibility** to switch windows and **Screen Recording** to display thumbnails.

If you switched from the official app and permissions appear enabled but AltTab cannot switch windows, reset the old permission entries:

```bash
tccutil reset Accessibility com.lwouis.alt-tab-macos
tccutil reset ScreenCapture com.lwouis.alt-tab-macos
```

Then grant the permissions again in System Settings > Privacy & Security. The Cask does not run these resets automatically.

## Monthly AltTab Cask updates

The [Update AltTab unlocked Cask](.github/workflows/update-alt-tab.yml) workflow runs
on the first day of every month at **09:15 Asia/Taipei** and can also be started
manually using **Actions → Update AltTab unlocked Cask → Run workflow**.

The workflow compares the Cask with the upstream GitHub **latest release**, checks
the expected ZIP filename, validates its published SHA-256, downloads the archive
and confirms its actual size and hash. Only a newer version changes the Cask.

If an update is available, it **opens a PR for manual review**; it does not merge
or install software automatically. Once the update PR is merged, use:

```bash
brew update
brew upgrade --cask xiaoxiaosn/xiaoxiao/alt-tab-macos-free
```

To allow the workflow to open PRs with `GITHUB_TOKEN`, enable
**Settings → Actions → General → Workflow permissions → Allow GitHub Actions
to create and approve pull requests** in this repository.

Run offline updater tests locally with:

```bash
python3 -m unittest discover -s tests -v
```
