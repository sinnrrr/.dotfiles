---
name: delegate-fix
description: >
  Hand a fix or an investigation to a fresh subagent (Fable, Opus or Sonnet) with an unbiased
  brief, verify what it returns, and route every review finding back to the same agent. Use when
  the engineer says to hand a problem to Fable, Opus or a subagent "without bias", "describe the
  problem and let the subagent solve it", asks for an unbiased second opinion, or says to
  "provide feedback back to" an agent.
---

# Delegate a fix without bias

The fresh agent solves the problem on its own terms. You give it the facts and the gates, then verify its result instead of trusting its report.

## 1. Park your own attempt

- Stop editing.
- Save what you already changed: `git format-patch` for commits, `git diff > <scratchpad>/attempt.patch` for uncommitted edits.
- Undo only your own edits, with Edit, or park them on a WIP commit. Never discard changes you did not make. The git guard hook blocks restore, `checkout --` and bare stash anyway.

## 2. Give it a clean tree

- A new branch from freshly fetched `origin/main`, in its own worktree.
- One worktree per editing agent. Never point two agents at one checkout.

## 3. Write the brief

Save it as a file (scratchpad, or `~/Work/notes/YYYY-MM-DD-<slug>.md` when the engineer wants to keep it) and pass the path with a short summary.

Include:
- The goal and done criteria: ticket text, outcome ACs, the symptom and a repro.
- Scope: what is in and what is out.
- Verified facts, each with its source (file and line, command output, ticket, log link). Label anything unverified as a lead.
- Gotchas you already hit.
- The gates: the repo's pre-push commands from AGENTS.md or README, plus the real-path proof (a rendered page or a real run).
- The considered approach from the discussion: options weighed, the chosen direction, concrete sets such as metric lists or tag designs. Frame it as the default direction the agent may improve on with stated reasons, not as orders.
- As the first instruction: "Open AGENTS.md (or CLAUDE.md) with the Read tool before anything else."

Leave out:
- Code blocks that contain the fix, step lists, and file-by-file instructions.
- Your own theory presented as fact.

## 4. Pick the model

- Fable for fixes.
- Opus or Sonnet for research that must be sourced.
- Tell it that it may spawn its own subagents for bulk reading, so its context stays small.

## 5. Verify what comes back

- Diff against the agent's real parent commit.
- Rerun every gate yourself and read the exit codes.
- Prove each new test fails on the pre-fix source and passes after it. Run the old source in a separate worktree, never by resetting a shared one.
- Check the one fact the agent's conclusion rests on before you relay it.

## 6. Route findings back

- Send every finding (yours, a review bot's, or a review the engineer asked for) to the same agent with SendMessage. Do not fix them yourself.
- Repeat until the gates pass and nothing blocking is left.

## 7. Finish

- Push, then open the PR with the `github-pr` skill (one-sentence body for small changes).
- Auto-merge only when the engineer asks.
