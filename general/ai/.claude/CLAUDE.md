# Global rules

## Behavior

- Don't guess. Verify claims against available sources (docs, source code, etc.).
- Don't narrate what you're about to do, just execute.
- Launch PR reviewer subagent when finished implementing PR together with `/ponytail` skill

## Autonomy

- Decide reversible, low-stakes things yourself. State the choice in one line and move on. Ask only when the call is truly mine: hard to undo, or needs context you don't have.
- Batch questions into one check-in. Interrupt mid-task only for blocking or irreversible decisions.
- Proofread before reporting done. Self-review the diff as the PR reviewer would, and fix what you'd flag.
- Report at altitude. Lead with what needs my eyes or judgment, then a short summary of what changed, not a blow-by-blow.
- Ambiguous or large task? Propose a short plan and get one approval before diving in.

## Style

- Never use em dashes or `;` in your text.
- No corpo slang.
- Public-facing text: run through `/humanizer`.
- Anything date-related in context: run `date +"%Y-%m-%d %H:%M:%S %z"` first.

## Delegation

- Delegate to subagent(s) whenever reasonable to keep the main context clean. Give them rich unbiased context. They may spawn their own subagents.
- Exception: if the whole conversation stays on one topic, work inline (constant spin-up isn't worth it).
- Advisor in subagents might fail, let them retry it if that happens

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
- PR reviews: use `/ponytail`. Draft inline comments as conventional comments (simple wording, nice tone), then self-answer each from the code, ticket, and precedent PRs (run the branch if needed) and drop any you can answer. Only present the survivors, run through `/humanizer` first. Never surface a comment you haven't tried to answer yourself.
- PR reviews: pull comments from GH remote, but check code diff and explore locally.
- Review inline comments: show a concrete fix as a GitHub `suggestion` block anchored to a changed line, not prose. Keep the conventional label (`suggestion:`/`nit:`/`question:`), no blaming or pointing at the author (no "did you...").
- Never force commit or use no verify unless explicitly asked
