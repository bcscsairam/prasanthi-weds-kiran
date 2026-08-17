#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
#  Prasanthi weds Kiran — one-command deploy
#
#     bash deploy.sh
#
#  Pushes to GitHub. Netlify is linked to that repository and publishes
#  the change on its own, usually within a minute. There is no second
#  step to do by hand.
#
#  Setting up again on a new machine:
#     bash deploy.sh https://github.com/bcscsairam/prasanthi-weds-kiran.git
# ─────────────────────────────────────────────────────────────────────
set -e

REMOTE="$1"

# the live site Netlify serves from this repository
SITE="https://prasanthi-weds-kiran.netlify.app/"
DASH="https://app.netlify.com/projects/prasanthi-weds-kiran/deploys"

# ── sanity checks ────────────────────────────────────────────────────
if [ ! -f "index.html" ]; then
  echo "✗ No index.html in this folder."
  echo "  cd into the folder that holds index.html, then run this again."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "✗ git isn't installed. Get it from https://git-scm.com/downloads"
  exit 1
fi

echo "Found:"
for f in index.html README.md DEPLOY.md; do
  [ -f "$f" ] && echo "   • $f  ($(du -h "$f" | cut -f1))"
done
echo

# ── first run: set the repo up ───────────────────────────────────────
if [ ! -d ".git" ]; then
  if [ -z "$REMOTE" ]; then
    echo "✗ First run needs your repository URL."
    echo
    echo "  1. Go to https://github.com/new"
    echo "  2. Name it:  prasanthi-weds-kiran"
    echo "  3. Choose PUBLIC. Do NOT tick 'Add a README'."
    echo "  4. Create it, then run:"
    echo
    echo "     bash deploy.sh https://github.com/YOUR-USERNAME/prasanthi-weds-kiran.git"
    exit 1
  fi
  git init -q
  git branch -M main
  git remote add origin "$REMOTE"
  echo "✓ Repository initialised"
fi

# allow changing the remote on later runs
if [ -n "$REMOTE" ]; then
  git remote set-url origin "$REMOTE" 2>/dev/null || git remote add origin "$REMOTE"
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "✗ No remote set. Re-run with your repository URL as the argument."
  exit 1
fi

# ── commit and push ──────────────────────────────────────────────────
git add -A
if git diff --staged --quiet; then
  echo "· Nothing changed since the last push."
else
  git commit -q -m "Wedding invitation site — $(date '+%d %b %Y, %H:%M')"
  echo "✓ Committed"
fi

echo "→ Pushing…  (if it asks for a password, paste a GitHub Personal Access"
echo "             Token, not your account password — see DEPLOY.md)"
git push -u origin main

# ── tell them exactly what happens next ──────────────────────────────
cat <<EOF

════════════════════════════════════════════════════════════════════
 ✓ Pushed to GitHub.

 Nothing left to do. Netlify watches this repository and publishes
 the change by itself — give it about a minute.

 Your invitation:

   $SITE

 Watch the update land (your dashboard, not for guests):

   $DASH

 If the page still looks old, hold Shift and click refresh — that is
 your browser showing you the copy it saved earlier.
════════════════════════════════════════════════════════════════════
EOF
