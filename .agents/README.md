# Agent Skills

Project skills follow the [Agent Skills](https://agentskills.io) open standard. Each skill is a directory with a `SKILL.md` entrypoint and optional scripts, templates, and assets.

## Canonical location

```
.agents/skills/<skill-name>/
├── SKILL.md          # Required: metadata + instructions
├── README.md         # Optional: human notes, upstream link
├── scripts/          # Optional: executable code
└── assets/           # Optional: templates, binaries, static files
```

**Source of truth:** `.agents/skills/` — edit skills here only.

## Agent discovery paths

| Agent | Project path | Notes |
| ----- | ------------ | ----- |
| **Codex** | `.agents/skills/` | Scans from CWD up to repo root |
| **Cursor** | `.agents/skills/`, `.cursor/skills/` | Also reads `.claude/skills/`, `.codex/skills/` |
| **Claude Code** | `.claude/skills/` | Symlinked from `.agents/skills/` |
| **Grok** | `.grok/skills/` | Symlinked from `.agents/skills/` |

Compatibility symlinks in this repo point to `.agents/skills/` so all agents share one skill tree:

```
.claude/skills/<name>  →  ../../.agents/skills/<name>
.codex/skills/<name>   →  ../../.agents/skills/<name>
.grok/skills/<name>    →  ../../.agents/skills/<name>
```

## Available skills

| Skill | Description | Upstream |
| ----- | ----------- | -------- |
| `md-to-docx` | Convert Markdown to formatted Word (.docx) with versioning and normalization | [pickle-an/md-to-docx-skill](https://github.com/pickle-an/md-to-docx-skill) |

Vendored skills in `.agents/skills/` may diverge from upstream (e.g. English `SKILL.md`, MedKarute symlink layout). To sync or report issues, use the upstream repository.

## Adding a new skill

For third-party skills, link the upstream repo in the skill table above and in `SKILL.md` / `README.md` under the skill folder (see [`md-to-docx`](./skills/md-to-docx/README.md) as reference).

1. Create `.agents/skills/<skill-name>/SKILL.md` with YAML frontmatter (`name`, `description`).
2. Add compatibility symlinks:

   ```bash
   SKILL=your-skill-name
   for dir in .claude/skills .codex/skills .grok/skills; do
     mkdir -p "$dir"
     ln -sfn "../../.agents/skills/$SKILL" "$dir/$SKILL"
   done
   ```

3. Restart the agent session (or wait for live reload) so discovery picks up the new skill.

## Invoking skills

- **Automatic:** Agents load skill name + description at startup; full `SKILL.md` loads when the task matches `description`.
- **Manual:** Type `/md-to-docx` (Claude Code, Cursor) or `$md-to-docx` (Codex CLI).