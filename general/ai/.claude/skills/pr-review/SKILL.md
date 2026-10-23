---
name: pr-review
description: >
  Review a GitHub PR and draft self-answered conventional comments (suggestion, nit, question)
  with suggestion blocks and a verdict, or draft replies to review threads on the engineer's own
  PR. Drafts only, nothing is posted until the engineer says to post. Wraps /code-review with the
  engineer's review conventions. Use for "/code-review this pr", "review this pr", "create sem pr
  review comments", "what do i reply", or a pasted PR or review URL.
---

# PR review

"sem pr review" means the conventional-comment drafts this skill produces.

## 1. Gather

- Name the host on every call: a full PR URL or `-R <host>/<owner>/<repo>` for `gh pr`, and `gh api --hostname <host>` for the API.
- Fetch the PR, its ticket, the existing threads (`repos/<owner>/<repo>/pulls/<n>/comments` and `/reviews`) and any PRs stacked on or under it.
- Put the head in its own worktree (`git fetch origin pull/<n>/head:pr-<n>`, then `git worktree add`). Never `gh pr checkout` in a checkout another session may use.
- Read the code there, not only the diff.

## 2. Find candidates

- Run `/code-review` on the PR, without `--comment`.
- Add your own pass: correctness, scope against the ticket ACs, and a library pass (a hand-rolled parser, poller, retry loop, validator or test fake that a built-in, framework feature or maintained library already covers).

## 3. Self-answer every candidate

This order is a gate.

- Answer each candidate from the code on the branch and on `origin/main`, the ticket and precedent PRs. Run the branch or the tests when that settles it.
- Drop every candidate you can answer.
- Never show a comment you have not tried to answer yourself.

## 4. Draft the survivors

- At most 7 comments, most important first.
- Label each one `suggestion:`, `nit:` or `question:`.
- 1 to 2 sentences each. Simple words, nice tone, no blame, no pointing at the author, no "did you...".
- Show a fix as a GitHub `suggestion` block anchored to a changed line, not as prose.
- Run the humanizer skill, then check the drafts for em dashes and semicolons.

## 5. Verdict

One line: approve, approve with nits, or request changes, plus the main reason.

## 6. Hand over

- Write the drafts to the scratchpad and show them as file, line and comment.
- Post only when the engineer says to post. "Do everything" is not a post instruction.
- When told to post, send one review through the reviews API with `commit_id` set to the reviewed head SHA, so each comment anchors to the right line.

## Replies on the engineer's own PR

- Pull every thread, review bots included.
- Approved or nit-level comment: confirm the fix in one line and stop.
- Blocking or substantive comment: give the reasoning and the commit that addresses it.
- Same drafts-only rule as above.
