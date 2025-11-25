#!/bin/bash
set -euo pipefail

REPO_DIR="/root/repos/centralcom"
LIMIT=${1:-20}

cd "$REPO_DIR"

echo "Analisando os ${LIMIT} commit messages mais repetidos em $(git rev-parse --abbrev-ref HEAD)"
echo "Mensagem (count) – use git log --grep='<mensagem>' para ver detalhes completos"
echo

git log --pretty=format:'%s' | sort | uniq -c | sort -rn | head -n "$LIMIT"

echo
echo "Para ver os commits específicos que ainda usam uma mensagem repetida:"
echo "  git log --grep=\"<mensagem que apareceu com count>\" --oneline"

