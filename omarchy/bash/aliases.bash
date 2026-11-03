# Personal shortcuts, loaded after Omarchy's Bash defaults.
alias vim='nvim'
alias la='eza --color=always --long --git --icons=always --all'
alias gs='git status'
alias reload='source ~/.bashrc'

alias h='cd ~/.'
alias week='date +%V'

# Push or pull the current branch explicitly on origin.
ggp() {
  local branch
  branch=$(git symbolic-ref --quiet --short HEAD) || return
  git push origin "$branch" "$@"
}

ggl() {
  local branch
  branch=$(git symbolic-ref --quiet --short HEAD) || return
  git pull origin "$branch" "$@"
}

# Fuzzy-find a local or remote branch without detaching HEAD.
glb() {
  local branch local_branch
  git rev-parse --git-dir >/dev/null 2>&1 || return
  branch=$(git branch --all --format='%(refname)' |
    grep -v '/HEAD$' |
    fzf --delimiter=/ --with-nth=3.. --prompt='Branch> ') || return
  [[ -n "$branch" ]] || return

  case "$branch" in
  refs/heads/*)
    git checkout "${branch#refs/heads/}"
    ;;
  refs/remotes/*)
    branch=${branch#refs/remotes/}
    local_branch=${branch#*/}
    if git show-ref --verify --quiet "refs/heads/$local_branch"; then
      git checkout "$local_branch"
    else
      git checkout --track "$branch"
    fi
    ;;
  esac
}
