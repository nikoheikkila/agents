# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Project Overview

This repository contains TDD (Test-Driven Development) agent skills — reusable prompt files that guide AI tools through the Red-Green-Refactor workflow. It is not a source code project; there are no build steps, dependencies, or test suites to run here.

Skills live in `skills/` and are invoked as slash commands:

- `/tdd-red` — Write failing tests from Gherkin feature files
- `/tdd-green` — Implement minimal code to make failing tests pass
- `/tdd-refactor` — Improve code quality while keeping tests green

## Architecture

Each skill is a standalone `SKILL.md` file with YAML frontmatter (name, description) followed by detailed guidance. Skills are framework-agnostic with examples in TypeScript and Python.

```
skills/
├── tdd-red/SKILL.md       # Red phase: write failing tests first
├── tdd-green/SKILL.md     # Green phase: minimal implementation
└── tdd-refactor/SKILL.md  # Refactor phase: improve design
```

The three skills form a strict sequential cycle: Red → Green → Refactor → Red. Each phase has mandatory rules about what can and cannot be modified (e.g., Green phase must never touch test files; Refactor phase must never touch test files).

## Key Conventions

- Skills must never make Git commits, branches, or any Git operations — the developer is always the navigator.
- Green phase follows the Transformation Priority Premise (constants → variables → conditionals → loops → recursion).
- Refactor phase enforces class length < 100 lines and method length < 10 lines.
- Tests use Given-When-Then structure mapped from Gherkin scenarios without explicit section comments.
- Only external dependencies (databases, APIs, file systems) should be faked in tests; prefer real objects for side-effect-free logic.

## Editing Skills

When modifying skill files, preserve the YAML frontmatter block and maintain the checklist format at the end of each skill. The `description` field in frontmatter is used by AI tools for skill discovery and matching.
