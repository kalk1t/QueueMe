# Development Guide (Repository Foundation)

## Prerequisites

- Git
- A code editor

Framework-specific prerequisites (Android Studio, Node.js, Terraform, etc.) are intentionally deferred until their milestones.

## How to inspect the plan

- Review `project-plan/ROADMAP.md`
- Review `project-plan/00_locked_product_baseline.md`
- Review the active milestone file in `project-plan/`

## Milestone workflow

- Create a dedicated branch for each active milestone before implementation.
- Keep changes scoped to the active milestone boundary.
- Store completion evidence in `docs/project-status/milestone-reports/`.

## Working tree checks

- Confirm a clean working tree before starting milestone work:
  - `git status --short`
  - `git status --porcelain`
- Confirm branch context:
  - `git branch --show-current`

## Build/run commands

There is no runnable application code yet. Do not run app build or test commands in this foundation phase.
