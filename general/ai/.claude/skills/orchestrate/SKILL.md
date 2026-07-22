---
name: orchestrate
description: >-
  Drive a substantial, multi-step task to a verified done-state by acting as an
  orchestrator: anchor on a testable goal, delegate the actual work to
  subagents (chosen by model tier), run independent work in parallel, and loop
  build-validate-fix until the goal empirically holds. Use when the user wants
  something built and made to actually work rather than just attempted, when
  they say "orchestrate this", "drive this to completion", "make it work / keep
  going until it works", "use subagents to build X", "do this autonomously",
  "run the pipeline until green", or when they set an explicit success
  condition (for example via /goal). Also use for any task large enough that
  reading and building across many files in the main thread would bloat context
  and a delegate-and-synthesize approach is cleaner. Not for quick single-step
  answers, trivial one-file edits, or pure conversation.
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
the user (irreversible, or missing context only they have). If a success
condition can be stated, treat it as a hard gate: keep going until it holds.

## The operating loop

1. **Anchor on a testable goal.** Restate the objective as an observable
   pass or fail, not a feeling. "CI is green on the stable case and red on the
   flaky case" beats "the workflow looks right". If the user has not set one and
   the task warrants it, set it (for example with /goal) so the session refuses
   to quietly stop short. Everything downstream drives toward this.

2. **Orient cheaply, then plan.** Do the minimum read-only orientation you need
   to write good directions (read the ticket, list the files, confirm the
   environment works). Orientation is not the substantive work, so it is fine to
   do a little inline. Before committing to an approach, consult the advisor if
   available. Surface the crux (the one thing the whole task is graded on) and
   design around it.

3. **Decompose and delegate.** Break the work into units and hand each to a
   subagent with rich, unbiased context. Run independent units in parallel.
   Pick the model tier per unit. Keep the hard, consequential, single-source-of-
   truth work for the strongest tier. Never pour raw file dumps or full
   transcripts into your own context: subagents read, you receive conclusions.

4. **Validate empirically.** Prove it against reality, not assumption. Run it,
   read the actual output, check the actual CI result. Reproduce locally before
   spending an expensive or slow cycle (a CI run, a deploy). A passing surface
   signal is not enough: check it passed for the right reason (guard against the
   false green that succeeds because it silently did nothing).

5. **Loop-fix until it converges.** If validation does not meet the goal,
   diagnose from evidence (logs, reproduction), dispatch a fix, re-run. Repeat.
   Each cycle should be bounded so a single long-running subagent does not become
   a fragile monolith that dies mid-flight. Prefer many short, resumable steps.

6. **Confirm and report at altitude.** When the goal holds, say so plainly with
   the evidence. Lead with what needs the user's eyes or judgment, then a short
   summary of what changed. Do not narrate every step.

## Delegation rules

- **Rich context in, conclusions out.** Tell each subagent exactly what you
  already know, what you want back, and the format. Ask it to return only what
  is new or decision-relevant, not a restatement of what you handed it. Give
  exact paths and commands when precision saves cycles.
- **Subagents may spawn subagents.** Encourage it for their own sub-work so
  neither their context nor yours gets polluted.
- **Verify state, do not trust blindly.** A subagent can crash on an API error
  mid-task. After any failure or ambiguous report, run a light read-only check
  of the real state (git, gh, the filesystem) before deciding the next move.
  Resume or re-dispatch from the true state, not the last thing it claimed.
- **You stay the integrator.** Synthesize subagent reports, reconcile conflicts
  between them (and between them and the advisor), and hold the plan. If two
  sources disagree, surface the conflict and resolve it deliberately.
- **Orchestrator situational awareness is allowed.** A one-line read-only check
  to know what happened (list runs, view a comment, git status) is direction,
  not doing the work. The heavy lifting still goes to subagents.

## Scriptable loops: use the Workflow tool

When the task's shape is knowable up front — independent units reviewed or
built in parallel, feeding a synthesis or fix step, repeated until a
convergence condition holds — write it as a Workflow script instead of
re-deciding the loop by hand every turn. The script (`agent()`/`parallel()`/
`pipeline()`/`phase()`) IS the orchestrator: it runs in the background, forces
structured output via `schema` so results compose reliably round to round,
and is resumable (edit the script, resume from the same `runId`, only the
changed step and everything after it reruns).

This skill's own instruction to use Workflow satisfies its opt-in gate — no
separate user confirmation is needed once `/orchestrate` (or an equivalent
goal-driven ask) is already in play.

Pattern that works well: N independent reviewers/builders with schema-
constrained output, feeding one evaluator/fixer agent that verifies each
result against real state and applies only what's real, repeated until a
round comes back clean (zero findings, or the fixer applies zero fixes). Cap
the round count so it cannot run away.

Keep doing turn-by-turn Agent dispatch from the main thread instead when the
next step is genuinely unknown until you read the previous step's freeform
output and must apply judgment a script can't encode — ambiguous diagnosis, a
fix approach that depends on a human-style read of the evidence.

Gotcha: if a run fails instantly with zero agents dispatched (something like
`args.X is undefined` thrown before any `agent()` call runs), that's
args-threading breaking, not a logic bug in your loop. Hardcode the values as
literals directly in the script body instead of passing them through `args`,
then resume from the same `runId` — nothing ran yet, so the retry is free.

## Model selection

Match the model to the difficulty and consequence of the unit, independent of
what you are running as. State the choice in one line when you dispatch.

| Tier | Use for |
| --- | --- |
| Cheapest (for example Haiku) | Trivial, mechanical, high-volume: rote edits, simple lookups, format conversions, boilerplate. |
| Mid (for example Sonnet) | Routine and well-specified: exploration and reading, running commands, git and PR mechanics, applying a clear spec. |
| Strongest (for example Opus) | The main work: architecture and design, the crux, diagnosis of a real failure, anything where a wrong call is expensive. |

When unsure, do not overspend. Send the well-specified parts to a mid tier and
reserve the strongest tier for the genuinely hard decision. Reassess per cycle.

## Parallelization

- Launch independent subagents in a single batch so they run concurrently.
- Kick off slow or external work (installs, CI, long reads) and do other useful
  work while it runs. Do not sit idle waiting.
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
- **Gate on the trustworthy signal.** Prefer the objective one (an exit code, a
  check conclusion, a diffable artifact) over a self-reported field that can lie.
  Know which signals lie in your stack and route around them.
- **Distinguish false green from real green.** "It passed" and "it ran the thing
  and the thing passed" are different claims. Verify the second.
- **Advisor at the seams.** Consult the advisor before committing to an approach
  and before declaring done, when it is available. Give its advice real weight,
  but if empirical evidence contradicts a specific claim, reconcile rather than
  silently switch.

## Anti-patterns to avoid

- Doing the implementation inline in the main thread and letting context bloat.
- Declaring done from "the code looks correct" without running it.
- Accepting a green result without checking it is green for the right reason.
- Waiting on a slow task with nothing else in flight.
- Spending the strongest model on rote work, or the cheapest on the crux.
- Re-dispatching from a crashed subagent's claimed state instead of the verified
  real state.
- Asking the user about reversible, low-stakes choices instead of deciding,
  stating the choice, and moving on.

## Reporting

Report at altitude. When the goal is met, state it with the concrete evidence
(the green and red runs, the passing check, the working output). Keep the
summary to what changed and what needs judgment. Save the blow-by-blow for when
it is asked for.
