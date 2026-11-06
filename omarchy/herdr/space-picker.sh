#!/usr/bin/env bash
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"

for dependency in "$herdr_bin" jq fzf; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    printf 'Space picker requires %s\n' "$dependency" >&2
    exit 1
  fi
done

# Keep IDs separate from display text; never use a label as a CLI argument.
snapshot=$("$herdr_bin" workspace list)
workspaces=$(jq -er '.result.workspaces | if length > 0 then . else error("No spaces available") end' <<<"$snapshot")
active_id="${HERDR_ACTIVE_WORKSPACE_ID:-${HERDR_WORKSPACE_ID:-}}"
initial_position=$(jq -r --arg active "$active_id" '
  (map(if $active != "" then .workspace_id == $active else .focused end)
   | index(true) // 0) + 1
' <<<"$workspaces")
rows=$(jq -r --arg active "$active_id" '
  def clean: gsub("[\u0000-\u001f\u007f-\u009f]"; " ");
  def pad($width): . + (" " * ([$width - length, 0] | max));
  # Reserve at least 40 characters and grow to fit the longest space name.
  (map(.label | clean | length) | max | [., 40] | max) as $name_width |
  (["", " ", ("Name" | pad($name_width)), ("Status" | pad(10)), "Tabs"],
   (.[] | [
      .workspace_id,
      (if (if $active != "" then .workspace_id == $active else .focused end) then "*" else " " end),
      (.label | clean | pad($name_width)),
      ((.agent_status // "unknown") | pad(10)),
      (.tab_count | tostring)
   ])) | join("\t")
' <<<"$workspaces")

# Ignore global fzf customizations: this picker owns its modal keybindings.
# In search mode j/k and / are ordinary query characters. Esc clears the
# query and restores navigation; Esc in navigation mode cancels the popup.
if selection=$(printf '%s\n' "$rows" | FZF_DEFAULT_OPTS= FZF_DEFAULT_OPTS_FILE= fzf \
  --layout=reverse \
  --no-sort \
  --no-multi \
  --no-input \
  --delimiter=$'\t' \
  --tabstop=2 \
  --with-nth=2.. \
  --nth=2 \
  --prompt='Spaces> ' \
  --header-lines=1 \
  --bind="load:pos($initial_position)" \
  --bind='j:down,k:up' \
  --bind='/:show-input+clear-query+change-prompt(/ )+unbind(j,k,/)' \
  --bind='esc:transform:if [ "$FZF_PROMPT" = "/ " ]; then printf "%s\n" "clear-query+search()+hide-input+change-prompt(Spaces> )+rebind(j,k,/)"; else printf "%s\n" abort; fi' \
  --bind='ctrl-c:abort' \
  --color='bg:-1,bg+:-1,hl:4,hl+:4,pointer:4,prompt:4'); then
  workspace_id=${selection%%$'\t'*}
  "$herdr_bin" workspace focus "$workspace_id" >/dev/null
else
  status=$?
  # No match or explicit cancellation is not an error.
  if [[ $status != 1 && $status != 130 ]]; then
    exit "$status"
  fi
fi
