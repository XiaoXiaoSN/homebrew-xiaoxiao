"""Offline checks for the AltTab release updater."""

import io
import hashlib
import sys
import unittest
from unittest.mock import patch
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "scripts"))
import update_alt_tab_cask as updater

VERSION = "11.10.3"
DIGEST = "a" * 64
TAG = f"v{VERSION}-unlocked"
FILENAME = f"AltTab-{VERSION}-unlocked.zip"
URL = f"https://github.com/{updater.REPO}/releases/download/{TAG}/{FILENAME}"
CASK = f'cask "alt-tab-macos-free" do\n  version "11.10.2"\n  sha256 "{"b" * 64}"\nend\n'


def release(**overrides):
    data = {
        "tag_name": TAG,
        "draft": False,
        "prerelease": False,
        "assets": [{"name": FILENAME, "browser_download_url": URL,
                    "digest": f"sha256:{DIGEST}", "size": 4096}],
    }
    data.update(overrides)
    return data


class UpdaterTests(unittest.TestCase):
    def test_valid_release_and_cask_update(self):
        self.assertEqual(updater.release_details(release()), (VERSION, DIGEST, URL, 4096))
        updated = updater.update_cask(CASK, VERSION, DIGEST)
        self.assertIn('version "11.10.3"', updated)
        self.assertIn(f'sha256 "{DIGEST}"', updated)
        self.assertEqual(updater.pinned_values(updated), (VERSION, DIGEST))

    def test_reject_unexpected_release_tag(self):
        with self.assertRaisesRegex(ValueError, "Unexpected release tag"):
            updater.release_details(release(tag_name="v11.10.3"))

    def test_reject_unexpected_download_url(self):
        data = release()
        data["assets"][0]["browser_download_url"] = "https://attacker.invalid/alt-tab.zip"
        with self.assertRaisesRegex(ValueError, "asset URL"):
            updater.release_details(data)

    def test_reject_missing_digest(self):
        data = release()
        data["assets"][0]["digest"] = None
        with self.assertRaisesRegex(ValueError, "SHA-256"):
            updater.release_details(data)

    def test_reject_prerelease(self):
        with self.assertRaisesRegex(ValueError, "prerelease"):
            updater.release_details(release(prerelease=True))

    def test_download_checksum_verification(self):
        data = b"real archive contents"
        digest = hashlib.sha256(data).hexdigest()
        with patch.object(updater, "urlopen", return_value=io.BytesIO(data)):
            updater.verify_download(URL, digest, len(data))
        with patch.object(updater, "urlopen", return_value=io.BytesIO(data)):
            with self.assertRaisesRegex(ValueError, "does not match"):
                updater.verify_download(URL, "0" * 64, len(data))

    def test_reject_bad_cask_structure(self):
        with self.assertRaisesRegex(ValueError, "exactly one"):
            updater.update_cask('version "11.10.2"\n', VERSION, DIGEST)


if __name__ == "__main__":
    unittest.main()
