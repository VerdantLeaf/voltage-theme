# Changelog

## 1.0.4

- Markdown inline code spans and fenced code blocks now use orchid instead of green, so they read as raw code rather than string literals (both in the editor and the preview pane).

## 1.0.3

- Fixed bolded/italicized markdown headings falling back to white instead of keeping their heading color.
- Added themed colors for the Markdown preview pane (headings, bold/italic, code, blockquotes, links, strikethrough, table borders), not just the editor.

## 1.0.2

- Coloring for markdown files 
- Orchid color for language constants 

## 1.0.1

- Editor/UI chrome (backgrounds, borders, indent guides, line numbers) realigned to match GitHub Dark Default's actual values — was a near-black `#0a0a0a`, now the correct dark blue-gray `#0d1117`.
- Git decoration colors reworked: added/untracked are both green, modified is gold, deleted is red (was blue/pink, mismatched with `M`/`U` conventions).

## 1.0.0

- Initial release as a standalone theme extension (previously a `settings.json` override on top of GitHub Dark Default).
- Color definitions for the editor, terminal, git decorations, and bracket pair highlighting.
- Token color rules for C/C++, CUDA, SystemVerilog, Tcl, and Python.
