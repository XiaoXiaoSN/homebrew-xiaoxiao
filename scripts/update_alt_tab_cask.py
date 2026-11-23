#!/usr/bin/env python3
"""Update the pinned AltTab unlocked cask from a verified GitHub release."""

import hashlib
import json
import re
import sys
from pathlib import Path
from urllib.request import Request, urlopen

REPO = "filipef101/alt-tab-macos-free"
API_URL = f"https://api.github.com/repos/{REPO}/releases/latest"
CASK = Path(__file__).resolve().parent.parent / "Casks/alt-tab-macos-free.rb"
TAG_PATTERN = re.compile(r"^v(\d+\.\d+\.\d+)-unlocked$")
VERSION_PATTERN = re.compile(r'(?m)^  version "(\d+\.\d+\.\d+)"$')
SHA_PATTERN = re.compile(r'(?m)^  sha256 "([0-9a-f]{64})"$')
MAX_ASSET_BYTES = 100 * 1024 * 1024


def github_release():
    request = Request(API_URL, headers={
        "Accept": "application/vnd.github+json",
        "User-Agent": "homebrew-xiaoxiao-cask-updater",
        "X-GitHub-Api-Version": "2022-11-28",
    })
    with urlopen(request, timeout=30) as response:
        return json.load(response)


def release_details(release):
    if release.get("draft") or release.get("prerelease"):
        raise ValueError("Latest release must not be a draft or prerelease")

    tag = release.get("tag_name", "")
    match = TAG_PATTERN.fullmatch(tag)
    if not match:
        raise ValueError(f"Unexpected release tag: {tag!r}")
    version = match.group(1)
    filename = f"AltTab-{version}-unlocked.zip"
    matching = [asset for asset in release.get("assets", []) if asset.get("name") == filename]
    if len(matching) != 1:
        raise ValueError(f"Expected exactly one release asset named {filename}")

    asset = matching[0]
    expected_url = f"https://github.com/{REPO}/releases/download/{tag}/{filename}"
    if asset.get("browser_download_url") != expected_url:
        raise ValueError("Release asset URL does not match the expected repository and tag")

    digest = asset.get("digest", "")
    if not isinstance(digest, str) or not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
        raise ValueError("Release asset must publish a valid SHA-256 digest")

    size = asset.get("size")
    if not isinstance(size, int) or not 0 < size <= MAX_ASSET_BYTES:
        raise ValueError("Release asset size is missing or exceeds the limit")
    return version, digest.removeprefix("sha256:"), expected_url, size


def pinned_values(cask):
    versions = VERSION_PATTERN.findall(cask)
    hashes = SHA_PATTERN.findall(cask)
    if len(versions) != 1 or len(hashes) != 1:
        raise ValueError("Expected exactly one pinned version and SHA-256 in cask")
    return versions[0], hashes[0]


def update_cask(cask, version, digest):
    pinned_values(cask)
    cask = VERSION_PATTERN.sub(lambda _: f'  version "{version}"', cask, count=1)
    return SHA_PATTERN.sub(lambda _: f'  sha256 "{digest}"', cask, count=1)


def verify_download(url, expected_digest, expected_size):
    request = Request(url, headers={"User-Agent": "homebrew-xiaoxiao-cask-updater"})
    hasher = hashlib.sha256()
    count = 0
    with urlopen(request, timeout=60) as response:
        while block := response.read(1024 * 1024):
            count += len(block)
            if count > MAX_ASSET_BYTES or count > expected_size:
                raise ValueError("Release download exceeds expected size")
            hasher.update(block)
    if count != expected_size or hasher.hexdigest() != expected_digest:
        raise ValueError("Downloaded release does not match GitHub asset size and SHA-256")


def main():
    original = CASK.read_text(encoding="utf-8")
    current, current_digest = pinned_values(original)
    latest, latest_digest, url, size = release_details(github_release())
    if tuple(map(int, latest.split("."))) < tuple(map(int, current.split("."))):
        print(f"Skipping downgrade: pinned {current}, upstream latest {latest}")
        return
    if latest == current:
        if latest_digest != current_digest:
            raise ValueError("SHA-256 changed without a version bump; review manually")
        print(f"Already up to date: {current}")
        return

    verify_download(url, latest_digest, size)
    CASK.write_text(update_cask(original, latest, latest_digest), encoding="utf-8")
    print(f"Updated AltTab cask: {current} -> {latest} (verified SHA-256)")


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError, KeyError, TypeError) as exc:
        print(f"Cask update failed: {exc}", file=sys.stderr)
        sys.exit(1)
