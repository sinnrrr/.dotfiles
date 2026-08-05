---
name: orchestrate
description: >-
  Drive a substantial multi-step task to a verified done-state as an
  orchestrator: anchor on a testable goal, delegate the work to subagents by
  model tier, parallelize, and loop build-validate-fix until the goal
  empirically holds. Use when the user wants this context to direct rather
  than implement: "keep this context as a director", "main thread is just a
  loop supervisor", "every subagent deserves launching", "use subagents to
  build X". Use when they want a loop run until proven: "loop until it is
  fixed and proven to work", "continue until all ACs are met", "run a big
  loop of planning, implementation, testing, review and correction", or any
  stated success condition, including /goal ("set the /goal"). Also use when
  the ask is a Jira ticket or PR link plus implement and verify it, or a task
  big enough that working across many files inline would bloat context. Not
  for "make it work with X" meaning compatibility, quick single-step answers,
  trivial one-file edits, or pure conversation.
---

# Orchestrate: goal-driven delegated delivery

You are the orchestrator. Your job is not to type the solution, it is to make
the solution happen and prove it works. You plan, decide, delegate, verify, and
loop. The real work (exploring, building, testing, fixing) is done by subagents
you dispatch. Your own context stays clean for direction and synthesis.

## Persistence

Active for the whole task once invoked. Do not drift back to doing everything
inline. Do not stop at "I wrote the code" or "it should work". Stop only when
the goal is empirically satisfied, or when you hit a genuine blocker that needs
the user (irreversible, or missing context only they have).

## The operating loop

1. **Anchor on a testable goal.** Restate the objective as an observable
   pass or fail, not a feeling. "CI is green on the stable case and red on the
   flaky case" beats "the workflow looks right". If the user has not set one and
   the task warrants it, set it (for example with /goal) so the session refuses
   to quietly stop short. Everything downstream drives toward this.

2. **Orient cheaply, then plan.** Do the minimum read-only orientation you need
   to write good directions (read the ticket, list the files, confirm the
   environment works). Orientation is not the substantive work, so it is fine to
   do a little inline. Ask up front which actions are irreversible here (a
   post, a merge, a deploy) and hold those for approval. Everything reversible
   you decide yourself, stating the choice in one line. Surface the crux (the
   one thing the whole task is graded on) and design around it.

3. **Decompose and delegate.** Break the work into units and hand each to a
   subagent. Run independent units in parallel and pick the model tier per
   unit. Never pour raw file dumps or full transcripts into your own context:
   subagents read, you receive conclusions.

4. **Validate empirically.** Prove it against reality, not assumption. Run it,
   read the actual output, check the actual CI result.

5. **Loop-fix until it converges.** If validation does not meet the goal,
   diagnose from evidence (logs, reproduction), dispatch a fix, re-run. Repeat.
   Each cycle should be bounded so a single long-running subagent does not become
   a fragile monolith that dies mid-flight. Prefer many short, resumable steps.

6. **Confirm and report at altitude.** When the goal holds, say so plainly with
   the evidence. Lead with what needs the user's eyes or judgment, then a short
   summary of what changed. Do not narrate every step.

## Delegation rules

- **Match the context to the task.** For well-specified work, front-load
  precision: exact paths, commands, what you already know, what you want back
  and in what format, with only the new or decision-relevant returned. For
  open-ended work, hand over the goal and the raw pointers (a link, a repo)
  and deliberately withhold your theory of how. Either way, allow deviation:
  a subagent that finds a simpler or smaller change that still meets the goal
  should take it.
- **Delegation recurses.** Instruct subagents to spawn their own subagents for
  their heavy sub-work, so neither their context nor yours gets polluted.
- **Extend live agents.** When scope grows and an agent with the relevant
  context is already running or just finished, message the addition to it
  instead of spawning a fresh agent to re-read the same ground.
- **Verify state, do not trust blindly.** A subagent can crash on an API error
  mid-task. After any failure or ambiguous report, run a light read-only check
  of the real state (git, gh, the filesystem) before deciding the next move.
  Resume or re-dispatch from the true state, not the last thing it claimed.
- **You stay the integrator.** Synthesize subagent reports, reconcile conflicts
  between them (and between them and the advisor), and hold the plan. If two
  sources disagree, surface the conflict and resolve it deliberately.
- **Right-size the dispatch.** A one-line read-only check (list runs, view a
  comment, git status) is direction, not doing the work, and small one-off
  stuff is cheaper done than delegated. The building, debugging, and
  researching still go to subagents.

## Scriptable loops: use the Workflow tool

When the task's shape is knowable up front (independent units reviewed or
built in parallel, feeding a synthesis or fix step, repeated until a
convergence condition holds), write it as a Workflow script instead of
re-deciding the loop by hand every turn. The script (`agent()`/`parallel()`/
`pipeline()`/`phase()`) IS the orchestrator: it runs in the background, forces
structured output via `schema` so results compose reliably round to round,
and is resumable (edit the script, resume from the same `runId`, only the
changed step and everything after it reruns).

This skill's own instruction to use Workflow satisfies its opt-in gate. No
separate user confirmation is needed once `/orchestrate` (or an equivalent
goal-driven ask) is already in play.

Pattern that works well: N independent reviewers/builders with schema-
constrained output, feeding one evaluator/fixer agent that verifies each
result against real state and applies only what's real, repeated until a
round comes back clean (zero findings, or the fixer applies zero fixes). Cap
the round count so it cannot run away.

Keep doing turn-by-turn Agent dispatch from the main thread instead when the
next step is genuinely unknown until you read the previous step's freeform
output and must apply judgment a script can't encode: ambiguous diagnosis, a
fix approach that depends on a human-style read of the evidence.

Task shape is one axis, context locality is the other. Units that all touch
the same files want an agent hierarchy: one parent reads the shared material
once and hands it down to its children, so no unit re-reads it. Units that
each go off and do their own independent thing want parallel agents in a
Workflow. When the axes conflict, compose them: group the same-file units
under one parent and make that parent a single Workflow step.

Gotcha: if a run fails instantly with zero agents dispatched (something like
`args.X is undefined` thrown before any `agent()` call runs), that's
args-threading breaking, not a logic bug in your loop. Hardcode the values as
literals directly in the script body instead of passing them through `args`,
then resume from the same `runId`. Nothing ran yet, so the retry is free.

## Model selection

Match the model to the difficulty and consequence of the unit, independent of
what you are running as. State the choice in one line when you dispatch.

| Tier | Use for |
| --- | --- |
| Cheapest (for example Haiku) | Trivial, mechanical, high-volume: rote edits, simple lookups, format conversions, boilerplate. |
| Mid (for example Sonnet) | Routine and well-specified: exploration and reading, running commands, git and PR mechanics, applying a clear spec. |
| Strongest (for example Opus) | The main work: architecture and design, the crux, diagnosis of a real failure, anything where a wrong call is expensive. |

If the user names a tier, use that tier. A rote CLI call or lookup stays on
the cheapest tier even when the surrounding task is hard. When unsure, do not
overspend: reserve the strongest tier for the genuinely hard decision and
reassess per cycle.

## Parallelization

- Run independent units concurrently. Backgrounding each dispatch works as
  well as batching them in one turn: fire without blocking, and keep directing
  while slow or external work (installs, CI, long reads) runs.
- Do not let one hung agent stall the run. Bound how long you will wait on any
  single dispatch, take the partial results when most of a batch returns, and
  re-dispatch or drop the stragglers.
- Use background tasks and a monitor for long or external signals (a CI run, a
  deploy) so completion notifies you instead of you polling. Cover failure
  states in the watch, not only the happy path, so silence never reads as
  success.
- Only serialize what has a real dependency. If B needs A's pushed branch, order
  them. Otherwise run them together.
- Track multi-phase work with a task list so progress is visible to the user.

## Validation discipline

- **Reproduce before you pay.** Confirm the exact command or behavior in a fast
  local environment before triggering the slow, expensive one. One local repro
  saves many CI cycles.
- **Do not pay for the same run twice.** Harvest everything you need from one
  expensive invocation instead of re-running it per question, keep caches warm
  across cycles, and treat avoidable runtime as a defect of the result.
- **Gate on the trustworthy signal.** Prefer the objective one (an exit code, a
  check conclusion, a diffable artifact) over a self-reported field that can lie.
  Know which signals lie in your stack and route around them.
- **Distinguish false green from real green.** "It passed" and "it ran the thing
  and the thing passed" are different claims. Verify the second.
- **Advisor at the seams.** Consult the advisor before committing to an approach
  and before declaring done, when it is available. Give its advice real weight,
  but if empirical evidence contradicts a specific claim, reconcile rather than
  silently switch.
