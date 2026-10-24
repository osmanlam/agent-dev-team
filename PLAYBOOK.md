# Agent Dev Team — Playbook

A 16-agent software team for agent-driven coding CLIs: one team-lead that runs the project, a dev team that builds and gates quality, and a marketing team that ships the story. This playbook is how you get the most out of it — especially the two-tier model setup that keeps token bills low.

---

## 1. What you get

| | Agent | Job in one line |
|---|---|---|
| **Lead** | `team-lead` | Turns vague requests into tickets with acceptance criteria, dispatches everyone else, owns the status report |
| **Dev** | `architect` | Designs before anyone builds — structure, interfaces, ordered plan (read-only) |
| | `frontend-dev` | UI implementation, components, styling, wiring to APIs |
| | `backend-dev` | API endpoints, business logic, schemas, jobs, integrations |
| | `ios-dev` | Swift/SwiftUI app work when the target is Apple platforms |
| | `test-engineer` | Writes and runs tests, reproduces bugs as failing tests |
| | `code-reviewer` | Blocking/non-blocking review verdicts on every substantial diff |
| | `debugger` | Root-cause diagnosis for failures whose cause you don't know |
| | `security-auditor` | Defensive review of anything touching input, auth, or I/O |
| | `devops-engineer` | Builds, CI/CD, containers, deploys, environment problems |
| **Marketing** | `market-researcher` | Facts about the market before you make positioning bets |
| | `content-writer` | Landing pages, posts, emails, release notes |
| | `seo-specialist` | Keyword maps and on-page changes that rank |
| | `social-media-manager` | Platform-native launch copy and calendars |
| | `growth-analyst` | Funnel analysis, experiment design, "is this working?" |
| | `brand-designer` | Identity direction, asset specs, visual QA |

## 2. Compatibility

The agent files are plain Markdown with a standard frontmatter block (`name`, `description`, `tools`, optional `model`), which is the subagent format used by Claude Code and compatible CLIs (ZCode and forks). Known working targets:

- **Claude Code** — project agents in `.claude/agents/`, personal agents in `~/.claude/agents/`
- **ZCode** — `.zcode/agents/` (project) or `~/.zcode/agents/` (global)

Any CLI that reads subagent definitions from a directory of Markdown files will work with the files as-is.

## 3. Install

Easiest — run the installer from this folder:

```bash
./install.sh                # into the current project (.claude/agents)
./install.sh --global       # ~/.claude/agents (all your projects)
./install.sh --zcode        # .zcode/agents in the current project
./install.sh --zcode-global # ~/.zcode/agents
```

The script backs up any existing agents directory before writing.

Manual — copy the 16 `.md` files from `agents/` into your CLI's agents directory.

## 4. How to drive the team

**Big or vague request → `team-lead`.** "Build me a booking app", "our onboarding converts badly, help" — anything without a ready plan. It writes acceptance criteria first, breaks the work into one-dispatch tickets, and runs the loop below.

**Small, well-defined change → the specialist directly.** A one-line fix doesn't need a PM. If you can write the ticket yourself in two sentences, dispatch the matching dev agent yourself.

### The quality loop (this is the product)

```
            ┌──────────────────────────────────────────────┐
            │                                              │
  vague ──▶ team-lead ──▶ architect ──▶ dev agents ──▶ test-engineer
  request      PM specs     design        implement        verify
                              │                              │
                              │                              ▼
                              │                         code-reviewer
                              │                              │
                              │            blocking findings ┘ (routed back
                              │                              to the dev agent)
                              ▼                              ▼
                        security-auditor  ◀── if it touches input/auth/I/O
                              │
                              ▼
                      done, verified against acceptance criteria
```

The two rules that make it work:

1. **No fix without a diagnosis.** When something breaks mid-flight, team-lead sends `debugger` for the root cause before letting a dev agent "fix" blind.
2. **Nothing is done until it's proven.** Every acceptance criterion gets closed out with how it was verified — a test run, a review verdict, a manual check. Unproven = not done.

### Parallelization pattern

The most common one: `frontend-dev` and `backend-dev` in parallel on an interface the `architect` (or `team-lead`) defined first. Agreement on the contract *before* dispatch is what makes the parallel dispatch cheap instead of expensive.

### Marketing loop

A launch mirrors the build loop: `market-researcher` (facts) → `content-writer` + `brand-designer` (assets) → `seo-specialist` / `social-media-manager` (distribution) → `growth-analyst` (did it work → next experiment).

## 5. The two-tier model setup (your token bill)

The single biggest cost lever: **not every agent needs your strongest model.** This team ships with a tiered split baked into the dispatch rules, and the `model:` frontmatter line is where you wire it to your CLI:

| Tier | Agents | Why |
|---|---|---|
| **Tier 1 — strong model, high effort** | architect, debugger, security-auditor, code-reviewer, growth-analyst, market-researcher, team-lead | Design trade-offs, unknown-cause failures, security judgment, go/no-go calls — output quality compounds |
| **Tier 2 — fast/cheap model** | frontend-dev, backend-dev, ios-dev, test-engineer, devops-engineer, content-writer, seo-specialist, social-media-manager, brand-designer | Well-specified execution — speed and cost win |

The shipped files deliberately carry **no `model:` line**, so every agent inherits your session default and works everywhere. To turn on tiering, add one line to each agent's frontmatter. Examples:

Claude Code style:

```yaml
---
name: architect
# ... 
model: opus        # Tier 1
---
name: frontend-dev
# ...
model: sonnet      # Tier 2 (or haiku for mechanical work)
---
```

ZCode / GLM style:

```yaml
model: account:your-plan/GLM-5.3$high    # Tier 1
model: account:your-plan/GLM-5.3-Flash   # Tier 2
```

Omitting the line = inherit the session model, which is a fine default until you know your workload.

**Rule of thumb from the field:** a ticket a Tier-2 agent can fully execute should never go to Tier 1. If team-lead can write the ticket without the specialist, the specialist stays benched. That rule, applied consistently, is where most of the savings live — more than the model split itself.

## 6. Customizing

- **Rename/re-scope an agent** — edit the frontmatter `description` (that's what the dispatcher reads to route) and the body's rules.
- **Add an agent** — copy the closest existing file, keep the structure: role sentence → numbered operating rules → output format → discipline section. Keep descriptions routing-oriented ("use WHEN X"), not biographies.
- **Shrink the team** — data/ML shop? `ios-dev` won't miss you. The team-lead file lists the roster; keep that list in sync when you add/remove agents.

The Pro playbook (in the paid bundle) goes deeper: a cost-tuning cookbook with real ticket→tier routing examples, a step-by-step agent-authoring template, and patterns for extending the team (second product line, ops team, etc.).

## 7. License

Free to use personally, inside your company, and on client work. Do not resell or redistribute the pack itself (as-is or modified), and do not publish it as your own. Full text in [LICENSE.md](LICENSE.md).
