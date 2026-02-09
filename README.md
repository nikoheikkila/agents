# Modern Software Engineering with Agents

Custom skills, instructions, and prompt files for AI tools.

This repository contains specialized agent skills that guide you through the Test-Driven Development (TDD) cycle. These skills follow the Red-Green-Refactor workflow and are designed to work with projects using Gherkin/BDD feature files.

## What are Agent Skills?

[Agent skills](https://agentskills.io/home) are reusable prompt files that provide specialized guidance for specific development tasks. They live in the `skills/` directory of your repository (symlinked from `.claude/skills/`) and can be invoked from different AI tools.

## Available Skills

### 1. [TDD-Red](./skills/tdd-red/SKILL.md)

**Purpose**: Write failing tests that describe desired behavior before implementation exists.

**When to use**: Start here when beginning a new feature. This skill helps you translate Gherkin (BDD) feature files into unit tests.

**How to use**:

1. Create or open a Gherkin feature file (e.g., `features/authentication.feature`)
2. Invoke the skill with `/tdd-red`
3. Example prompt: `Write failing tests for the authentication feature`

**What it does**:

- Reads your Gherkin feature files from the `features/` directory
- Translates scenarios into unit tests following Given-When-Then structure
- Ensures tests fail for the right reason (missing implementation, not syntax errors)
- Creates isolated, independent tests with proper fixtures

**Key principles**:

- Write one test at a time
- Focus on specific behavior from feature requirements
- Use descriptive test names
- Prefer real objects; only fake external dependencies (databases, APIs, file systems)

### 2. [TDD-Green](./skills/tdd-green/SKILL.md)

**Purpose**: Implement minimal code to make failing tests pass without over-engineering.

**When to use**: After you have failing tests from the Red phase. This skill helps you write just enough code to make tests pass.

**How to use**:

1. Ensure you have failing tests in your `tests/` directory
2. Invoke the skill with `/tdd-green`
3. Example prompt: `Make unit tests pass in this file`

**What it does**:

- Writes minimal implementation code to satisfy test requirements
- Never modifies existing tests
- Uses simple, straightforward solutions (no premature optimization)
- Follows the Transformation Priority Premise (starts with constants, then conditionals, then loops)
- Ensures tests pass quickly without adding unnecessary complexity

**Key principles**:

- Fake it till you make it (start with hard-coded returns, generalize later)
- Ignore code smells temporarily (duplication is acceptable)
- Use the simplest language features (basic if/else, for/while)
- No logging, comments, type hints, or extra validation
- Run tests after each small change

### 3. [TDD-Refactor](./skills/tdd-refactor/SKILL.md)

**Purpose**: Improve code quality, apply best practices, and enhance design while maintaining green tests.

**When to use**: After all tests are passing from the Green phase. This skill helps you clean up the code without breaking functionality.

**How to use**:

1. Ensure all tests are passing
2. Invoke the skill with `/tdd-refactor`
3. Example prompt: `Improve the authentication code design`

**What it does**:

- Removes code duplication following the "Rule of Three"
- Applies SOLID principles
- Improves readability with intention-revealing names
- Keeps classes under 100 lines and methods under 10 lines
- Maintains test coverage and ensures tests stay green
- Runs linters and static analysis

**Key principles**:

- Make small, incremental changes
- Run tests after every change
- Never modify test code during refactoring
- Use proven refactoring patterns (Extract Method, Extract Class, Rename, etc.)
- Document WHY, not WHAT
- Revert if tests break or complexity increases

### Complete TDD Workflow

Here's how to use all three skills together:

```text
1. RED Phase — /tdd-red
   └─> Write tests for login feature
       ├─> Creates failing unit tests from Gherkin scenarios
       └─> Verify tests fail
       └─> Handoff to /tdd-green

2. GREEN Phase — /tdd-green
   └─> Implement code to pass login tests
       ├─> Writes minimal implementation
       └─> Verify tests pass
       └─> Handoff to /tdd-refactor

3. REFACTOR Phase — /tdd-refactor
   └─> Refactor the login code
       ├─> Improves design and readability
       └─> Verify tests still pass
       └─> Handoff to /tdd-red

4. Repeat RED Phase
   ...
```

### Prerequisites

**Project** with:

- A test runner (e.g., PyTest, Vitest, Jest)
- Gherkin feature files (optional, but highly recommended)

### Tips for Best Results

1. **Be specific in your prompts**: Instead of "write tests", say "write tests for user authentication with valid credentials".
2. **Work one phase at a time**: Don't skip ahead; the skills are designed to work sequentially.
3. **Reference files**: Mention specific feature files or test files in your prompts.
4. **Review skill output**: These skills provide guidance, but you should review and validate all generated code. Do not blindly accept suggestions and accumulate comprehension debt.
5. **Keep tests isolated**: Each test should be independent and not rely on shared state.
6. **Run tests frequently**: Verify your tests after each change.
7. **Do not let skills use Git**: Forbid skills from making commits, branches, or any other Git operations. You are still and always will be the navigator while the skills are simple drivers.
