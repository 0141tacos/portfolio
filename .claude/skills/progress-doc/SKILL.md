---
name: progress-doc
description: Maintain and consult this repo's progress-roadmap docs under docs/ (e.g. docs/supabase-migration.md) — living files that track what's done, what's in progress, and what's next for a multi-step initiative like a migration or feature rollout. Use this whenever the user asks about current project status or next steps, in Japanese or English — phrases like "現状は?", "今何やってる?", "これまでの進捗まとめて", "次何すればいい?", "what's left to do", "where are we on X". Also use this proactively whenever a chunk of work in the session reaches a natural stopping point (a roadmap step lands, a feature is implemented, a phase wraps up) — check docs/ for a relevant roadmap doc and propose updating it, even if the user didn't explicitly ask for a docs update.
---

## What these docs are

This repo tracks multi-step initiatives (migrations, feature rollouts) as living markdown files in `docs/`, e.g. `docs/supabase-migration.md`. Each doc is written in Japanese (matching the user's working language) and narrates: what's already done, what's being worked on right now, what's planned next, and a running log of notable decisions and the reasoning behind them. Treat it as a lightweight project journal per initiative, not a rigid spec.

There's no fixed section template — the フェーズ0〜4 structure in `supabase-migration.md` is just how that particular doc happened to get organized, not a format to force onto every doc. But every doc should keep three things easy to find:

1. **What's done** — completed steps, usually as checked-off items
2. **What's now / next** — a clear pointer to the current step and what comes right after
3. **Decisions & reasoning** — a short log of judgment calls made along the way, and *why*, not just what was decided

## When asked about status

When the user asks something like "現状は?", "今何やってる?", "これまでの進捗まとめて", "次何すればいい?":

1. Find the relevant doc in `docs/`. If more than one exists, prefer the one whose title/content matches what's currently being discussed or the current git branch.
2. Read it and answer from its content directly — don't reconstruct status by inferring from code or git history if the doc already states it. If the doc looks stale (e.g. its 最終更新 date is well before recent related commits), say so.
3. Summarize concisely: done / now-or-next / anything from the decision log worth surfacing. Don't just paste the file back — synthesize an answer to what was actually asked.

## Proposing updates after a chunk of work lands

Watch for natural checkpoints during the session — a roadmap step gets finished, a decision gets made that changes the plan, a phase wraps up. When that happens:

1. Check whether a relevant doc exists in `docs/`.
2. If it does, work out what the update should be — which item(s) to check off, where the "current position" marker should move, whether a decision just happened that's worth logging — and propose it to the user in a sentence or two *before* editing the file. Don't silently rewrite it. The decision log especially needs the user's own framing of *why*, which you may not have full visibility into.
3. If no relevant doc exists yet but the work clearly belongs to a multi-step initiative, ask whether the user wants one started rather than creating it unprompted.
4. Whenever you touch the file, update its 最終更新 date.

## Style notes

- Match the language and tone of the existing docs (Japanese, terse, checkbox-driven).
- Keep decision log entries short but keep the *why* — that's the part that isn't recoverable from git history later.
- Extend the structure already present in a doc rather than imposing a new one.
