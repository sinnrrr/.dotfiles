`claude-model-router-hook` (SessionStart + UserPromptSubmit) injects a
recommended model tier for the task at hand. Here's what I want you to do in different cases:

- Trivial or single-shot task: just do it inline, spinning up a subagent for a quick lookup or one-line edit isn't worth it.
- If the task looks like it will take multiple turns or a lot of context (research,
  multi-file build, iterative debugging, deep multi-step analysis):
  delegate the actual work to subagent with `model` explicitly set to the recommended tier.
