# Global rules

## Behavior

- Don't guess. Verify claims against available sources (docs, source code, etc.).
- Don't narrate what you're about to do, just execute.
- Launch PR reviewer subagent when finished implementing PR together with `/ponytail` skill

## Style

- Never use em dashes or `;` in your text.
- No corpo slang.
- Public-facing text: run through `/humanizer`.
- Anything date-related in context: run `date +"%Y-%m-%d %H:%M:%S %z"` first.

## Delegation

- Delegate to subagent(s) whenever reasonable to keep the main context clean. Give them rich unbiased context. They may spawn their own subagents.
- Exception: if the whole conversation stays on one topic, work inline (constant spin-up isn't worth it).

## Development

- No code comments unless asked.
- Checkout `main` and pull before starting work.
- Prefer editing existing files. Create new files (incl. docs/README) only when necessary.
- Always run tests after coding (check local README or authoritative files for how).

## GitHub

- Use `gh` CLI.
- Commits: title ≤50 chars (shorter is better), plain high-level words, follow the repo's commit format. Body only if necessary.
- Branch names: include ticket name if available, must not exceed 27 chars.
- PRs: follow the PR template in local `.github` if one exists.
- Send the PR body to the user to validate before creating the PR.
- PR body: high-level and concise, deliver the _why_ early, no newlines, don't restate what people can see in diff or Jira ticket
- PR reviews: use `/ponytail`, then draft inline comments as conventional comments (simple wording, nice tone), try to self-answer to eliminate any, run the remainder through `/humanizer` and present for review.
- Never force commit or use no verify unless explicitly asked
