#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
#  Prasanthi weds Kiran — one-command deploy
#
#  First time:
#     bash deploy.sh https://github.com/YOUR-USERNAME/prasanthi-weds-kiran.git
#
#  Every time after that:
#     bash deploy.sh
# ─────────────────────────────────────────────────────────────────────
set -e

REMOTE="$1"

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

# ── tell them exactly what to do next ────────────────────────────────
URL=$(git remote get-url origin)
USER=$(echo "$URL" | sed -E 's#.*github\.com[:/]([^/]+)/.*#\1#')
REPO=$(echo "$URL" | sed -E 's#.*/([^/]+)$#\1#; s#\.git$##')

cat <<EOF

════════════════════════════════════════════════════════════════════
 ✓ Pushed to GitHub.

 ONE STEP LEFT — turn on Pages (takes about 20 seconds):

   1. Open  https://github.com/$USER/$REPO/settings/pages
   2. Source:  Deploy from a branch
   3. Branch:  main   /  (root)     → Save
   4. Wait ~1 minute, then refresh the page.

 Your invitation will be live at:

   https://$USER.github.io/$REPO/

 Open it on your PHONE before sending it to anyone, and test the
 RSVP button all the way through to WhatsApp.
════════════════════════════════════════════════════════════════════
EOF
