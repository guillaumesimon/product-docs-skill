#!/usr/bin/env bash
#
# Install this checkout everywhere the skills can be installed.
#
#   ./update-skills.sh               rebuild, link, then hand the bundles to the Skills panel
#   SKIP_OPEN=1 ./update-skills.sh   same, without opening Finder or the browser
#   ./update-skills.sh --bundles-only   only check and rebuild dist/ (what the git hook runs)
#
# Claude Code reads ~/.claude/skills, so it gets a symlink to this checkout and stays
# in sync with every future edit. Chat, Cowork and claude.ai read account skills, which
# have no public API - the .skill bundles are rebuilt and handed to you to drop into the
# Skills panel.
set -euo pipefail
cd "$(dirname "$0")"
repo="$PWD"
bundles_only=""
[ "${1:-}" = "--bundles-only" ] && bundles_only=1

echo "==> Checking the SKILL.md descriptions"
# claude.ai account skills reject a description over 1024 characters. Claude Code does
# not, so an over-long description only fails at upload time, after the work is done.
for skill in product-docs-bootstrap product-docs-update; do
  n=$(sed -n 's/^description: //p' "$skill/SKILL.md" | head -1 | tr -d '\n' | wc -c | tr -d ' ')
  if [ "$n" -gt 1024 ]; then
    echo "    $skill: $n characters, over the 1024 limit. Shorten it before uploading." >&2
    exit 1
  fi
  echo "    $skill: $n/1024"
done

echo "==> Rebuilding the bundles"
rm -f dist/product-docs-bootstrap.skill dist/product-docs-update.skill
zip -rqX -D dist/product-docs-bootstrap.skill product-docs-bootstrap -x '.*'
zip -rqX -D dist/product-docs-update.skill    product-docs-update    -x '.*'
ls -lh dist/*.skill | sed 's/^/    /'

if [ -n "$bundles_only" ]; then
  exit 0
fi

echo "==> Claude Code (desktop Code tab, CLI, IDE)"
mkdir -p ~/.claude/skills
ln -sfn "$repo/product-docs-bootstrap" ~/.claude/skills/product-docs-bootstrap
ln -sfn "$repo/product-docs-update"    ~/.claude/skills/product-docs-update
echo "    ~/.claude/skills -> this checkout. Live at the next session start."

echo "==> Chat, Cowork, claude.ai"
if [ -n "${SKIP_OPEN:-}" ]; then
  echo "    SKIP_OPEN set, not opening anything."
else
  open -R dist/product-docs-update.skill
  open "https://claude.ai/settings"
fi
cat <<'TXT'
    Account skills have no API, so this last step is yours: in Settings > Capabilities
    > Skills, replace the two entries with the files now selected in Finder.

        dist/product-docs-bootstrap.skill
        dist/product-docs-update.skill

    Uploading a bundle whose name matches an existing skill replaces it; if it creates a
    duplicate instead, delete the old entry so no session picks up the stale copy.
TXT
