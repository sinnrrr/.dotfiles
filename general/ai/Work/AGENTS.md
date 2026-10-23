# ~/Work

These rules apply in every session under ~/Work, repos and worktrees included. Inside a repo or worktree, that repo's own AGENTS.md or CLAUDE.md wins.

Layout:
- Daily repos in the root: `~/Work/<name>`
- Every other repo: `~/Work/repos/<name>`. Third-party OSS clones: `~/Work/research/<name>`
- Worktrees: `~/Work/wk/<owner>/<repo>/<branch>`. Notes worth keeping: `~/Work/notes/`. Old stuff: `~/Work/archive/`
- Machine-specific rules can name extra folders for some repo groups.

Repos:
- One clone each. Check `git remote get-url origin` across ~/Work before cloning.
- Folder name = repo name. New clones go to `~/Work/repos/` unless another rule names a folder for them.

Files and worktrees:
- Never write files or folders in the ~/Work root. Throwaway output goes to the session scratchpad. Anything worth keeping goes to `~/Work/notes/` as `YYYY-MM-DD-<slug>.<ext>`.
- Main clones stay on main. Branch work lives in worktrees under `~/Work/wk/<owner>/<repo>/<branch>`, created with `wt switch --create`. Never `git worktree add` or a second clone.

Working in one of these repos:
- Best: start the session inside the repo or a worktree of it. A `cd` from here loads nothing.
- Already here: open `<repo>/AGENTS.md` (or CLAUDE.md when there is no AGENTS.md) with the Read tool (not cat) before acting. Reading a file there also loads the repo's CLAUDE.md, rules and skills. Its settings and hooks still do not apply.
