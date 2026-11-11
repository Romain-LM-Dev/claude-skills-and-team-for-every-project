<div align="center">

🇬🇧 English | 🇫🇷 [Français](README.md)

</div>

# claude-skills-and-team-for-every-project

A team of Claude Code agents that works in any project, plus skills you can import into claude.ai.
Principle: few agents, short descriptions, the model matched to the task (haiku for mechanical work, sonnet for
code, opus for design), and complete briefs so that each subagent starts off on the right foot.

## Contents

| Item | Role | Model |
|---|---|---|
| agent `orchestrateur` | splits the work, delegates, checks, reports back; no editing tool or shell | the session's model |
| agent `architecte` | cross-cutting decisions, ADRs, contracts, execution plan | opus |
| agent `developpeur` | implements with its tests, within a precise scope | sonnet |
| agent `qa-reviewer` | reviews the diff, writes missing tests, runs the checks | sonnet |
| agent `documentaliste` | docs, CLAUDE.md, the project's `.claude/`, creation of project agents | sonnet |
| agent `coach-equipe` | measured retrospective based on transcripts, at most three proposals | opus |
| skill `regles-equipe` | cost rules, model choice, five-section brief, proof, pause and resume (preloaded by the orchestrator) | - |
| skill `adapter-au-projet` | analyzes a repository, proposes project agents, writes the CLAUDE.md | - |
| skill `domain-designer` | rules, figures, user journeys and domain content for any project, whatever the domain | - |
| skill `mesure-equipe` | measures the team from transcripts and checks the ownership map (preloaded by coach-equipe) | - |

For business games and training simulations, the sister repository
[claude-skills-and-team-for-business-game-generation](https://github.com/Romain-LM-Dev/claude-skills-and-team-for-business-game-generation)
adds the domain agents and skills; its plugin depends on this one and installs it alongside.

A project can add its own review points to its CLAUDE.md: `qa-reviewer` checks them.

For read-only exploration, use the built-in `Explore` agent (haiku); there is no copy of it here.

## Installation in Claude Code

In a session, once the repository is published:

```
/plugin marketplace add Romain-LM-Dev/claude-skills-and-team-for-every-project
/plugin install team-for-every-project@skills-and-team
```

Without installing, for a local trial: `claude --plugin-dir <dossier-du-dépôt>`.
The plugin's agents are named `team-for-every-project:orchestrateur`, etc. A project or user agent with the
same name hides them (the plugin has the lowest priority).
Skills preloaded by an agent only apply when the orchestrator launches that agent as a subagent.

## Enabling the orchestrator

It is not forced: on a small task it costs more than it saves. For a project spanning several domains:

- for one session: `claude --agent team-for-every-project:orchestrateur`;
- permanently for a project: in the project's `.claude/settings.json`, `{ "agent": "team-for-every-project:orchestrateur" }`;
- for all projects: the same key in `~/.claude/settings.json` (not recommended).

To adapt the team to a repository, ask: "use the adapter-au-projet skill".

## Cost

Every agent and every skill adds its name and description to the context of every turn: the whole set is deliberately kept
short. A subagent starts cold; only delegate large outputs, autonomous or parallel work,
or an independent review to it. The details are in `skills/regles-equipe/SKILL.md`.

Measured on 2026-11-10 with `claude plugin details team-for-every-project@skills-and-team`: about 990 tokens always
on per session, then 440 to 2,200 tokens each time an agent or skill is invoked.

## Using the skills in claude.ai

Agents and hooks do not run in the claude.ai chat; only skills can be imported there, as ZIP files.

```powershell
.\scripts\package-skills.ps1
```

The script writes one ZIP per skill to `dist/` (ignored by git), after checking `name` (64 characters at most,
identical to the folder) and `description` (200 at most). Then, in claude.ai: Customize, Skills, Upload, and pick the ZIP.
The `regles-equipe` skill is mostly useful there as a cheat sheet.

## Project priority

Claude Code only arbitrates between agents with the same name: the plugin's agents (prefixed) coexist with the project's. Team
rule: a project agent or skill that covers the domain takes precedence; the plugin's ones fill in the uncovered
domains. `adapter-au-projet` records in the CLAUDE.md which plugin agents each project agent replaces. If the
project covers every role, disable the plugin in its `.claude/settings.json`:
`"enabledPlugins": {"team-for-every-project@skills-and-team": false}`.

## Validation

```
claude plugin validate .
claude plugin validate . --strict
```

GitHub CI (`.github/workflows/validate.yml`) runs strict validation, skill packaging (fails if a skill is skipped)
and the `team_metrics.py` self-test on every push.

## Evaluations

`evals/` holds three cases that check agent behavior: the orchestrator stops on a request that is already met,
`qa-reviewer` files an unverifiable doubt under "Non prouvé", `developpeur` reproduces a bug before fixing it. Each run
spends tokens and needs a logged-in session: run them by hand.

```
claude plugin eval . --ablation none --no-publish --trust-plugin --allow-tools Write Edit --case qa-non-prouve
```

`--ablation none`: without the plugin, the called agent does not exist. `--no-publish` keeps the report local
(`evals/results/`, ignored by git). `dev-reproduit-avant` must run code: it also needs `Bash` in `--allow-tools`,
which evals only grant on Linux or macOS with the sandbox installed (on Windows, use WSL).

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Agents or skills from an old version | auto-update is off by default for third-party marketplaces | `claude plugin update team-for-every-project@skills-and-team`, then restart |
| A preloaded skill is not applied | the agent was not launched as a subagent | go through the orchestrator, or load the skill with the Skill tool |
| `claude plugin prune` offers to remove this plugin | it was installed as a dependency of business-game | reinstall it explicitly: `claude plugin install team-for-every-project@skills-and-team` |

## License

Non-commercial source-available license: see `LICENSE.md`. Commercial use requires written permission from the rights holder.
