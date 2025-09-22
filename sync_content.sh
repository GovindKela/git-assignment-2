#!/bin/bash

PROJECT_A_URL="https://github.com/GovindKela/git-assignment-1.git"

REMOTE_NAME="project-a"

SOURCE_BRANCH="main"

FILE_TO_SYNC="README.md"

echo "INFO: Starting sync from Project-A to Project-B..."

if ! git remote | grep -q "^${REMOTE_NAME}$"; then
  echo "INFO: Adding remote '${REMOTE_NAME}' for Project-A."
  git remote add "${REMOTE_NAME}" "${PROJECT_A_URL}"
else
  echo "INFO: Remote '${REMOTE_NAME}' already exists."
fi

echo "INFO: Fetching latest data from ${REMOTE_NAME}..."
git fetch "${REMOTE_NAME}"

echo "INFO: Checking out ${FILE_TO_SYNC} from ${REMOTE_NAME}/${SOURCE_BRANCH}..."
git checkout "${REMOTE_NAME}/${SOURCE_BRANCH}" -- "${FILE_TO_SYNC}"

if [[ -z $(git status --porcelain) ]]; then
  echo "INFO: No new changes to commit. Project-B is already up-to-date."
  exit 0
fi

echo "INFO: Changes detected. Committing and pushing to Project-B..."
git add "${FILE_TO_SYNC}"

COMMIT_MESSAGE="docs: Sync ${FILE_TO_SYNC} from Project-A on $(date)"
git commit -m "${COMMIT_MESSAGE}"

git push origin main

echo "SUCCESS: Sync complete. Pushed latest README to Project-B."