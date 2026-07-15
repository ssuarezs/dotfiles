---
name: commit
description: Create a git commit in this repo following its commit conventions. Use whenever the user asks to commit changes here.
---

Create a commit for the currently staged (or to-be-staged) changes in this repo.

## Steps

1. Run `git status`, `git diff --staged` (and `git diff` for anything unstaged the user wants included), and `git log --oneline -10` to see recent style.
2. Stage the relevant files explicitly by name — never `git add -A` or `git add .`.
3. Read @docs/commit-conventions.md and draft the message following it.
4. Commit with that message.
5. Run `git status` after to confirm the commit succeeded.

## Rules

- Follow `docs/commit-conventions.md` for message format and authorship.
- Only commit when explicitly asked.
- Never use `--amend` unless explicitly requested; create a new commit instead.
- Never use destructive or history-rewriting flags (`--force`, `--no-verify`, `reset --hard`) unless explicitly requested.
