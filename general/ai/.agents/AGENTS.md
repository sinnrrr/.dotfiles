# Global rules

## Behavior

- Communication style: direct and short. Lead with the answer in 1 to 3 plain sentences, then stop. Add detail only when I ask. No preamble, affirmations or corpo slang. Treat me as a peer.
- Explanations, plans and status updates: plain language a PM could follow. Assume I have zero context, so say what a ticket, PR, service or acronym is about instead of only naming it. Links go inline on the word or as full raw URLs, never in a references section.
- Never use em dashes or `;` in any text, chat included. Be nice and non blaming.
- Don't guess. Verify against docs and source: docs via Context7 or the find-docs skill, code exploration by cloning repo before WebSearch, WebFetch or curl of docs sites. Memory notes and earlier outputs are leads, not facts. Check the one fact a subagent's claim rests on before relaying it.
- For docs or technologies search use context7 before web search
- Public-facing text (anything posted to GitHub, an issue tracker, chat or a wiki): run the humanizer skill, keep it high level and readable by a PM. Default length is one sentence for small changes.
- Batch questions into one check-in at the end. Reversible technical choice with a clear best option: take it and report it. Stop to ask only for irreversible, prod-affecting or truly blocking decisions.
- Large or ambiguous task with no explicit go: show a 3 to 5 line plan and wait for one OK. An explicit go ("do it", "go ahead", "fix all", "open pr", "implement") means run to the end without another approval round. If the conversation stays on one topic, work inline.
- Subagents: do heavy reading, searching and log digging in subagents, not the main thread. Set both model and effort on every Agent call
- Prefer API calls over using browser manually if possible
- Draw diagrams in Mermaid and render them with `mermaid` (my `mmdc` wrapper).
- If you're about to make a comment, write a doc or save a memory, consider how you can create a programmatic rule via linter, checker or other dev tool in dotfiles agent ai folder.
- Never skip a diagnostic silently (vale, linter, LSP, hook). Fix it, or if it is outside the task, list it in your reply and ask.

## Development (Code changes)

- No code comments unless I ask. A reviewer's explicit request for a comment counts as asking.
- New task: `wt switch --create <branch>`, then work in the worktree path it prints. One worktree per session and per editing subagent.
- Code search: anything that depends on syntax (calls, definitions, imports, args, multi-file rewrites) goes through the `ast-grep` CLI, not grep or rg. Run `ast-grep outline` to map a file or dir before reading it in full. Plain text like strings, logs and config values stays on rg.
- Before writing a parser, poller, retry loop, validator, test fake or wrapper, check built-ins, framework features and maintained libraries (Context7). Hand-roll only when nothing fits, and say why in the PR.
- Run the repo's full pre-push gates (AGENTS.md or README) before every push, not only before merge. New warnings count as failures.
- A fix is done when the original failure is reproduced before and shown gone after on a real path (UI: seen rendered in a browser, runner or deploy: a real run). Unit tests alone are not proof.
- Scripts I keep: check in before writing them in shell. Prefer a single-file script with inline deps, `uv` (Python) or `deno` (TypeScript), whichever has the libraries and syntax for the simplest, shortest code. Your own throwaway commands while working are exempt.

## GitHub

- Bare gh defaults to github.com (personal). For an enterprise host always name the host, cwd does not count: gh api --hostname <host> (gh api ignores the repo remote), -R <host>/owner/repo or a full PR URL for pr/run/issue, GH_HOST=<host> for repo clone/view and search.
- Before reporting done: reread your own diff for bugs and for anything outside the ticket. Run a full PR review only when I ask.
- Commits: plain high-level words, follow the repo's commit format.
- Branch names: include ticket name if available.
- PRs: when I say open or create a PR, open it right away and show the body afterward, no approval round. When editing an existing PR body, keep the size I chose.
- Comments, reviews, replies, issues and chat messages: drafts go to the scratchpad until I say post.
