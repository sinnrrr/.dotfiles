---
name: pr-review-conventions
description: How to review a GitHub PR - drafting inline comments, self-answering them from the code/ticket/precedent PRs, and formatting suggestions. Use when reviewing a pull request or drafting PR review comments.
---

# PR review conventions

- Use `/ponytail`. Draft inline comments as conventional comments (simple wording, nice tone), then self-answer each from the code, ticket, and precedent PRs (run the branch if needed) and drop any you can answer. Only present the survivors, run through `/humanizer` first. Never surface a comment you haven't tried to answer yourself.
- Pull comments from the GH remote, but check the code diff and explore locally.
- Show a concrete fix as a GitHub `suggestion` block anchored to a changed line, not prose. Keep the conventional label (`suggestion:`/`nit:`/`question:`), no blaming or pointing at the author (no "did you...").
