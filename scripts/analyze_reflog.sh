#!/bin/bash
set -euo pipefail

REPO_DIR="/root/repos/centralcom"
LIMIT=${1:-30}

cd "$REPO_DIR"

echo "Últimos ${LIMIT} eventos relevantes do reflog (reset/rebase/checkout/merge)"
git reflog --date=short | grep -E '(reset:|rebase:|checkout:|merge:|moving to)' | head -n "$LIMIT" || true

echo
echo "Resumo completo do reflog (últimos ${LIMIT} registros)"
git reflog --date=short | head -n "$LIMIT"

echo
echo "Se operou rebase/reset e precisa voltar ao estado anterior, copie o hash abaixo:"
git reflog --date=short | head -n 5 | awk '{print $1}'

