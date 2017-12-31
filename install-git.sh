#!/bin/bash

set -euo pipefail

echo | sudo add-apt-repository ppa:git-core/git

sudo apt-get update && sudo apt-get install git -y
