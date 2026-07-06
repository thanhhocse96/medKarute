---
name: md-to-docx
description: Convert Markdown files to formatted Word documents (.docx). Use when the user wants to convert .md to .docx, create a Word document from Markdown, or mentions document conversion.
metadata:
  upstream: https://github.com/pickle-an/md-to-docx-skill
---

# Markdown to Word Document Converter

This skill converts Markdown files into professionally formatted Word documents (.docx).

**Upstream:** [pickle-an/md-to-docx-skill](https://github.com/pickle-an/md-to-docx-skill) — original Agent Skill and Python scripts. This copy lives under `.agents/skills/md-to-docx/` for MedKarute agent discovery; report bugs or request features upstream unless they are MedKarute-specific integration issues.

## When to Invoke

Invoke this skill when:

- The user wants to convert a Markdown file to a Word document
- The user asks to create a Word document from Markdown content
- The user mentions `.md` to `.docx` conversion
- The user needs formatted document output

## Processing Pipeline

One converter (`scripts/md_to_docx.py`). Optional side output: `_normalized.md` when normalization is enabled.

```mermaid
flowchart LR
    A[Input .md] --> B[Version + front-matter]
    B --> C[Normalize]
    C --> D[Parse]
    D --> E[Generate .docx]
```

## Features

### 1. Automatic Version Management

The skill automatically manages output file version numbers:

| Scenario | Input file | Output files |
| -------- | ---------- | ------------ |
| No version in filename | `document.md` | `document_V1.docx`, `document_V1_normalized.md` |
| Version in filename | `document_V3.md` | `document_V4.docx`, `document_V4_normalized.md` |
| V1 already exists | `document.md` | `document_V2.docx`, `document_V2_normalized.md` |

**Version rules:**

- If the input filename contains a version (e.g. `_V3`), increment from that version
- If the filename has no version, scan the directory for existing versions and increment
- Version format: `_V{n}` where n is an integer (V1, V2, V3...)
- `.docx` and `_normalized.md` files share the same version number

### 2. YAML Front-Matter

Optional metadata block at the top of the Markdown file:

```yaml
---
title: Project Name — Executive Summary
date: 2026-07-06
version: V2
audience: Research team, reviewers
---
```

- `title` — cover page; split on `—` or `–` into title + subtitle
- `date`, `version` — cover page (CLI args override when provided)
- `audience` — shown on cover page
- Body content is parsed after the front-matter block is stripped
- Duplicate `#` title matching front-matter `title` is skipped in the body

### 3. Static Table of Contents

When the document has `##` / `###` / `####` headings (mapped to heading levels 1–3), a **Table of Contents** page is inserted after the cover and before body content.

### 4. Markdown Format Normalization

Before conversion, the skill automatically normalizes common Markdown formatting issues:

| Issue type | Example | Fix |
| ---------- | ------- | --- |
| Unclosed code fence | ` ```python` without closing fence | Auto-add closing ` ``` ` |
| Missing space after heading | `###Heading` | → `### Heading` |
| Chinese numerals in headings | `## 一、Core principles` | → `## 1. Core principles` |
| Chinese numerals in headings | `### (一) Technical details` | → `### (1) Technical details` |
| Unordered list without space | `-item` | → `- item` |
| Ordered list without space | `1.item` | → `1. item` |
| Horizontal rule variants | `--` or `----` | → `---` |
| Unmatched bold markers | `**only opening` | Remove invalid markers |
| Unmatched italic markers | `*only opening` | Remove invalid markers |
| Missing table separator row | Table without `\|---\|` | Auto-add separator row |
| Inconsistent table columns | Rows with different column counts | Auto-pad/truncate |
| Multiple consecutive blank lines | 3+ blank lines | Compress to 1 |
| Missing blank line before heading | Text directly before heading | Add blank line |
| Ordered list spacing | Blank lines between list items | **Preserve** (do not remove) |
| Paragraph first-line indent | `   Text with leading spaces` | Remove leading spaces |
| Blank lines between paragraphs | Single blank line between paragraphs | **Remove** (cleanup) |

**Chinese numeral conversion:**
The skill automatically converts Chinese numeral sequences in headings to Arabic numerals:

- Supported: 一, 二, 三, 四, 五, 六, 七, 八, 九, 十 (up to twenty)
- Pattern 1: `一、` → `1.` (Chinese punctuation)
- Pattern 2: `(一)` → `(1)` (parentheses form)
- Applies to all heading levels (# through ######)

**Ordered list spacing:**
Blank lines between ordered list items are preserved for readability:

- If a blank line exists between two numbered items, it is kept
- Example: `1. Item 1` → (blank line) → `2. Item 2` keeps the spacing

**Blank line management:**
The skill manages blank lines based on context:

- **Remove**: Blank lines between ordinary paragraphs (cleanup for better formatting)
- **Preserve**: Blank lines around special elements (headings, lists, code blocks, tables, horizontal rules)
- **Preserve**: Blank lines around indented content (list item details, nested items)
- **Compress**: Multiple consecutive blank lines reduced to one

**Paragraph first-line whitespace:**
Leading whitespace on ordinary paragraphs is removed to prevent double indentation in Word:

- Word applies first-line indent automatically
- Leading spaces in Markdown cause visual inconsistency
- List item indentation is preserved (unordered and ordered lists)
- Code blocks and blockquotes keep their formatting

### 5. Supported Markdown Elements

| Element | Syntax | Support |
| ------- | ------ | ------- |
| Headings | `#` through `######` | Full |
| Paragraphs | Plain text | Full |
| Bold | `**text**` | Full |
| Italic | `*text*` | Full |
| Bold + italic | `***text***` | Full |
| Unordered lists | `- item` / `* item` | Full |
| Ordered lists | `1. item` | Full |
| Tables | `\| col \|` | Full |
| Code blocks | ` ```code``` ` | Full |
| Inline code | `` `code` `` | Full |
| Links | `[text](url)` | Full |
| Images | `![alt](path)` | Full |
| Blockquotes | `> quote` | Full |
| Horizontal rules | `---` | Full |
| Strikethrough | `~~text~~` | Full |
| Line breaks | `<br>` or `\\` | Full |

### 6. Document Formatting Specification

#### Font Specification

| Element | Chinese font | English font | Size | Notes |
| ------- | ------------ | ------------ | ---- | ----- |
| Body | SimSun | Times New Roman | 12pt | Standard body text |
| Heading 1 | SimSun | Times New Roman | 22pt | Major title |
| Heading 2 | SimSun | Times New Roman | 16pt | Section title |
| Heading 3 | SimSun | Times New Roman | 15pt | Subsection title |
| Heading 4 | SimSun | Times New Roman | 14pt | Item title |
| Heading 5 | SimSun | Times New Roman | 14pt | Sub-item title |
| Code block | Consolas | Consolas | 9pt | Slightly smaller than body |
| Inline code | Consolas | Consolas | 12pt | Same as body |

#### Paragraph Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| First-line indent | 0.74cm | ~two Chinese character widths |
| Line spacing | 1.5× | Improved readability |
| Space before | 0pt | Compact layout |
| Space after | 0pt | Compact layout |

#### Heading Specification

| Level | Markdown syntax | Size | Style |
| ----- | --------------- | ---- | ----- |
| Document title | `# Title` | 22pt | Bold, centered, can generate cover page |
| Level 1 | `## Title` | 22pt | Bold, page break before |
| Level 2 | `### Title` | 16pt | Bold, no page break |
| Level 3 | `#### Title` | 15pt | Bold, no page break |
| Level 4 | `##### Title` | 14pt | Bold, no page break |
| Level 5 | `###### Title` | 14pt | Bold, no page break |

#### Table Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| Table style | Table Grid | Standard bordered table |
| Alignment | Center | Table centered on page |
| Column width | Auto-calculated | Content-based distribution |
| Header background | #D9D9D9 | Light gray header row |
| Header alignment | Center | Header text centered |
| Cell alignment | Left | Data left-aligned |

#### Code Block Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| Font | Consolas | Monospace for clarity |
| Size | 9pt | Slightly smaller than body |
| Background | #F5F5F5 | Light gray background |
| Left indent | 0.5cm | Visual separation |
| Language label | Italic | e.g. `[python]` |

#### Inline Code Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| Font | Consolas | Monospace |
| Size | Same as body | Consistent line height |
| Background | #F0F0F0 | Light gray highlight |

#### Blockquote Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| Left border | #6366F1 | Purple vertical line |
| Border width | 1.5pt | Clearly visible |
| Left/right indent | 1cm | Emphasize quoted content |
| Font style | Italic | Distinguish quoted text |

#### List Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| Left indent | 0.74cm × level | Multi-level nesting |
| Line spacing | 1.5× | Matches body text |
| Unordered bullet | • | Solid circle |
| Ordered format | 1. 2. 3. | Numbered with period |

#### Horizontal Rule Specification

| Property | Value | Notes |
| -------- | ----- | ----- |
| Style | Bottom border | Line below paragraph |
| Color | #CCCCCC | Light gray |
| Space before/after | 6pt | Appropriate spacing |

#### Cover Page Specification

| Element | Value | Notes |
| ------- | ----- | ----- |
| Title size | 22pt | Matches level-1 heading |
| Title style | Bold, centered | Prominent document title |
| Version info | 12pt, centered | Format: Version: V1 |
| Date info | 12pt, centered | Format: Date: 2024-01-01 |
| Blank lines before title | 3 | Top margin |
| Blank lines after title | 14 | Space before version/date |

#### Page Break Control

| Rule | Description |
| ---- | ----------- |
| Page break before level-1 headings | Each `##` heading starts a new page |
| Other headings | No page break |
| After cover page | Automatic page break |

## Usage

### Basic Conversion

Run from the skill root (`.agents/skills/md-to-docx/`):

```bash
python scripts/md_to_docx.py <input.md> [template.docx] [output.docx] [version] [date]
```

Or ask the agent:

```
Convert this Markdown file to Word:
[provide .md file path or content]
```

### Custom Template

```
Convert Markdown to Word using this template:
Markdown: [path or content]
Template: [.docx template path]
```

### With Cover Page

```
Convert to Word with cover page:
[Markdown content]
Title: [document title]
Version: [version number]
Date: [date]
```

## Parameters

| Parameter | Type | Required | Description |
| --------- | ---- | -------- | ----------- |
| `markdown_content` | string | Yes | Markdown text or file path |
| `output_path` | string | No | Output .docx file path |
| `template_path` | string | No | Custom .docx template path |
| `version` | string | No | Cover page version (auto-generated if omitted) |
| `date` | string | No | Cover page date |
| `normalize` | boolean | No | Enable format normalization (default: true) |
| `save_normalized` | boolean | No | Save normalized MD file (default: true) |
| `use_versioning` | boolean | No | Enable automatic version numbering (default: true) |

## Implementation

The skill uses Python scripts with this pipeline:

### Step 0: Version Management (`scripts/version_manager.py`)

```python
# Automatically determine output file version
version_info = get_versioned_output_paths(input_path, output_dir)
# Returns: { 'version': 1, 'docx_path': 'document_V1.docx', 'normalized_md_path': 'document_V1_normalized.md' }
```

### Step 1: Format Normalization (`scripts/markdown_normalizer.py`)

```python
# Auto-fix common Markdown formatting issues
normalizer = MarkdownNormalizer()
normalized_content = normalizer.normalize(content)
# Saved to: original_filename_normalized.md
```

### Step 2: Parse Markdown (`scripts/md_to_docx.py`)

```python
# Convert normalized Markdown to structured elements
parser = MarkdownParser()
elements = parser.parse(normalized_content)
```

### Step 3: Generate Word Document

```python
# Create formatted Word document
generator = DocxGenerator(template_path)
generator.create_document(output_path)
generator.generate(elements, version, date)
generator.save(output_path)
```

## Output Files

After conversion, these files are produced:

| File | Description |
| ---- | ----------- |
| `document_V{n}.docx` | Final versioned Word document |
| `document_V{n}_normalized.md` | Versioned normalized Markdown |

**Version examples:**

- First conversion: `document_V1.docx`, `document_V1_normalized.md`
- Second conversion: `document_V2.docx`, `document_V2_normalized.md`
- Versioned input: `document_V3.md` → `document_V4.docx`

## Template Support

### Custom Template

When a template is provided:

- Inherit page settings (margins, paper size)
- Inherit style definitions (Heading 1–6, Normal)
- Clear template content before adding new content

### Built-in Styles (No Template)

**This skill runs standalone without an external template file.**

If no template is provided or the template file does not exist:

- Create a blank document automatically
- Use default page settings (A4, 2.54cm margins)
- Create styles programmatically
- Apply consistent formatting

The skill runs in any environment with Python and `python-docx`, without external template dependencies.

## Examples

### Example 1: Format Normalization

**Input (with issues):**

```markdown
# Test Document
## 1. Table Test
| Col1|Col2|Col3
|Data1|Data2|Data3
###Heading Without Space
-Item1 Without Space
```

**Normalized output:**

```markdown
# Test Document

## 1. Table Test

|Col1|Col2|Col3|
|---|---|---|
|Data1|Data2|Data3|

### Heading Without Space

- Item1 Without Space
```

### Example 2: Simple Conversion

Input:

```markdown
# Project Document

## Overview
This is the project overview.

## Features
- Feature 1
- Feature 2
```

Output: Formatted Word document with correct heading hierarchy and bullet list.

### Example 3: With Table

Input:

```markdown
## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/users | List all users |
| POST | /api/users | Create user |
```

Output: Word document with formatted table and gray header row.

### Example 4: With Code Block

Input:

````markdown
## Installation

```bash
npm install package-name
```
````

Output: Word document with monospace code block.

## Error Handling

- **Invalid Markdown**: Log warning, continue with partial parsing
- **Missing template**: Fall back to built-in styles
- **File not found**: Return clear error message
- **Permission error**: Suggest alternative output path
- **Format issues**: Auto-fix during normalization phase

## Dependencies

- Python 3.x
- `python-docx` library

Install:

```bash
pip install python-docx
```

Optional: `requests`, `Pillow` (for remote/local image embedding).

## Project Layout

| Path | Description |
| ---- | ----------- |
| `SKILL.md` | Agent entrypoint (this file) |
| `scripts/md_to_docx.py` | Main conversion script |
| `scripts/markdown_normalizer.py` | Markdown format normalization |
| `scripts/version_manager.py` | Automatic version numbering |
| `scripts/create_template.py` | Regenerate default template (optional) |
| `scripts/create_preview.py` | Generate format preview doc (optional) |
| `assets/template.docx` | Default Word template (optional) |
| `assets/template_preview.docx` | Sample output for style reference |

**Notes:**

- `assets/template.docx` is optional; if present it is used, otherwise a blank document is created
- `scripts/create_template.py` can regenerate a template matching the formatting specification
- This skill runs fully standalone with no external dependencies beyond Python packages

## Upstream repository

| Resource | URL |
| -------- | --- |
| Repository | https://github.com/pickle-an/md-to-docx-skill |
| Upstream `SKILL.md` | https://github.com/pickle-an/md-to-docx-skill/blob/main/skill/SKILL.md |
| Releases | https://github.com/pickle-an/md-to-docx-skill/releases |

Licensed MIT upstream. When updating this vendored copy, compare against upstream `skill/` and root Python modules.