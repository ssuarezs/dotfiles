# Global Agent Instructions

Personal defaults for software development projects. Project-level AGENTS.md / CLAUDE.md files take precedence; in non-software repos (e.g. my notes system), that repo's rules replace these.

## Language

- Write everything in English: responses, code, identifiers, comments, commit messages, PRs and docs.

## Code Style

- Write self-explanatory code: descriptive names instead of comments.
- Add comments only when the code cannot express the intent (non-obvious "why", workarounds, external constraints).
- Use full, descriptive words for names; avoid abbreviations and vague names like `data`, `info`, `tmp`, `handle`, `manager`.
- Keep the vocabulary consistent: once a concept has a name, use that same name everywhere.
- Prefer strict typing: explicit types at boundaries, no `any`, no `type: ignore` or equivalent escape hatches.
- Prefer simple over abstract: no premature abstractions, generic helpers or extra layers until there is a real second use.
- Make minimal changes: touch only what the task requires; no unrequested refactors, renames or new files.
- When the repo's conventions conflict with these preferences, ask which one to follow before writing code.

## CLI

- Prefer modern tools when available: `rg` over `grep`, `fd` over `find`, `bat` over `cat`, `eza` over `ls`.
- Use `gh` for anything GitHub: PRs, issues, checks and API calls.

## Communication

- Keep responses short and pragmatic; go into detail only when I explicitly ask for it.
- Use extremely simple, plain language; skip filler and restating the question.
