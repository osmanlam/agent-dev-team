# Agent Dev Team

**A 16-agent dev + marketing team for Claude Code–style coding CLIs. One team-lead runs the project; specialists build, test, review, and ship — on a model split that keeps your token bill sane.**

You already have a coding agent. The problem isn't capability — it's that one agent doing everything means no design phase, no quality gate, and your strongest (most expensive) model spending high-effort reasoning on CSS tweaks. This pack turns a single chaotic agent into a team with roles, handoffs, and a definition of done.

```
vague request ──▶ team-lead ──▶ architect ──▶ dev agents ──▶ test-engineer
                   (specs)       (design)      (implement)     (verify)
                                                    │
                                              code-reviewer ──▶ security-auditor
                                               (quality gate)     (auth/input/I/O)
```

## The team

**Dev team** — `team-lead` (PM + dispatcher), `architect`, `frontend-dev`, `backend-dev`, `ios-dev`, `test-engineer`, `code-reviewer`, `debugger`, `security-auditor`, `devops-engineer`

**Marketing team** — `market-researcher`, `content-writer`, `seo-specialist`, `social-media-manager`, `growth-analyst`, `brand-designer`

Every agent file is a focused operating contract: when to dispatch it, its rules, its required output format, and its discipline ("you review, you don't fix"; "you diagnose, you don't patch blind"; "you coordinate, you don't implement").

## Quick start

```bash
git clone https://github.com/osmanlam/agent-dev-team.git
cd agent-dev-team
./install.sh          # into .claude/agents of your current project
# or: ./install.sh --global | --zcode | --zcode-global
```

Then hand your next vague request to the `team-lead` agent and let it plan, ticket, and dispatch. Small well-defined change? Skip the lead and dispatch the specialist directly.

## The two-tier setup (why your token bill drops)

The playbook ships with a cost model baked into the dispatch rules:

- **Tier 1 — your strongest model:** architect, debugger, security-auditor, code-reviewer, growth-analyst, market-researcher, team-lead. Deep reasoning compounds here.
- **Tier 2 — fast/cheap model:** all the execution agents. A fully-specified ticket doesn't need deep reasoning; it needs speed.

Files ship with no `model:` line (inherit your default, works everywhere). One added line per file turns tiering on — examples for Claude Code and GLM-style CLIs in [PLAYBOOK.md](PLAYBOOK.md). The routing rule that saves the most: *a ticket a Tier-2 agent can fully execute never goes to Tier 1.*

## Compatibility

Plain Markdown + standard agent frontmatter. Works with Claude Code (`.claude/agents/`), ZCode (`.zcode/agents/`), and any CLI that loads subagent definitions from a directory of Markdown files.

## Free vs Pro bundle

The repo is the full core product and always will be. The **Pro bundle** ([Gumroad → your-link-here]) adds the things that are easiest to deliver as a package:

| | Repo (free) | Pro bundle |
|---|---|---|
| All 16 agents + installer + core playbook | ✅ | ✅ |
| Extended playbook: cost-tuning cookbook, agent-authoring template, team-extension patterns | — | ✅ |
| Landing Pack: 5 production-ready single-file landing templates | — | ✅ |
| Lifetime updates | — | ✅ |
| Everything-in-one zip, ready to drop in | — | ✅ |

## License

Free for personal, company, and client use. No reselling/redistributing the pack itself. See [LICENSE.md](LICENSE.md).

---

Built by [osmanlam](https://github.com/osmanlam). Issues and PRs welcome — especially new agent ideas.
