#!/usr/bin/env bash
# exit on error
set -o errexit

# Install production dependencies
mix deps.get --only prod

# Compile the app
MIX_ENV=prod mix compile

# Compile assets
MIX_ENV=prod mix assets.build

# Deploy assets
MIX_ENV=prod mix assets.deploy

# Build the release
MIX_ENV=prod mix release --overwrite