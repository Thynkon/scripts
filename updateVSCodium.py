#!/usr/bin/env python3

import subprocess
import shutil
import re
import requests
from requests.exceptions import HTTPError


def download_file(url, path, name):
    with requests.get(url, stream=True) as r:
        with open(f"{path}/{name}", 'wb') as f:
            shutil.copyfileobj(r.raw, f)
    r.close()


def main():
    repo = "VSCodium/vscodium"
    url = f"https://api.github.com/repos/{repo}/releases/latest"
    pattern = "^.*\.rpm$"

    # get latest release info
    try:
        response = requests.get(url)

        # If the response was successful, no Exception will be raised
        response.raise_for_status()
    except HTTPError as http_err:
        print(f'HTTP error occurred: {http_err}')  # Python 3.6
    except Exception as err:
        print(f'Other error occurred: {err}')  # Python 3.6

    assets = response.json()["assets"]
    response.close()

    p = re.compile(pattern)

    # retrieve rpm files
    rpm_files = []
    for asset in assets:
        if p.match(asset["browser_download_url"]):
            rpm_files.append(asset["browser_download_url"])
    rpm_files.sort(reverse=True)

    path = "/tmp"
    filename = "vscodium-latest.rpm"
    download_file(rpm_files[0], path, filename)

    subprocess.run(["sudo", "dnf", "install", f"{path}/{filename}", "-y"])


if __name__ == "__main__":
    main()
