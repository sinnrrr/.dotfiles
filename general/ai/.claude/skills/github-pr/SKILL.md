---
name: github-pr
description: >
  Conventions for composing a GitHub PR body and title. Use when user mentions:
  open pr, create pr, draft pr, pr body, pr description, write the pr, raise a pr, push and open.
---

## Before writing

Follow the PR template in local `.github` if one exists. It wins over everything below.

## Size gate

Trivial change (config bump, offboard, one-liner, revert): one sentence, no newlines, readable by
a PM. Nothing else.

Substantial change: two-layer body.

## Two-layer body

Ticket link first, above both layers.

`## Description` on top. Very minimal: one short paragraph max. Only what a human needs at the
moment they first open the PR page, not a recap. What it does, nothing about what to do or watch. High-level PM speak, simple words,
deliver the _why_ early, no blame language, no code snippets, don't restate what people can see in
the diff or the ticket.

Everything else goes verbatim inside `<details><summary>For LLMs</summary>`. Nothing is deleted,
only re-layered. Reviewers query it with their own agents.

## Screenshots

UI-visible change gets a screenshot in the body. gh has no CLI path to upload images into a PR
body, so push the PNGs to an orphan branch `assets/<TICKET>` and reference the raw URLs.
