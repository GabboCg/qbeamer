# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

qbeamer is an R package that provides a Quarto Beamer presentation template with custom styling, enhanced author/affiliation support (including ORCID), and RStudio integration. Inspired by [beamer-tips](https://github.com/paulgp/beamer-tips), adapted for Quarto.

## Development Commands

```r
# Generate NAMESPACE and man pages
devtools::document()

# Run R CMD check
devtools::check()

# Install locally
devtools::install()

# Load for interactive testing
devtools::load_all()
```

## Architecture

The package bundles a Quarto extension inside `inst/extdata/_extensions/qbeamer/` and provides R functions + RStudio integration to use it.

**Quarto Extension** (`inst/extdata/_extensions/qbeamer/`):
- `_extension.yml` — registers the `qbeamer-beamer` format with defaults (xelatex, horizontal nav, 4:3 aspect ratio)
- `preamble.tex` — LaTeX preamble: custom color palette (blue/red/yellow/green RGB), bullet styling, custom footline with frame numbers, section break slides, ORCID support, text justification, itemize/enumerate spacing
- `title.tex` — Beamer title slide partial: short titles, multiple authors with ORCID, affiliations, title graphics, callout colors

**R Functions** (`R/`):
- `install_extension(path, overwrite)` — copies extension files into a project's `_extensions/qbeamer/`
- `create_project(path, title)` — RStudio project template binding, scaffolds project + installs extension
- `qbeamer_render(input, ...)` / `qbeamer_preview(input, ...)` — wrappers around `quarto::quarto_render/preview` with extension pre-check

**RStudio Integration**:
- Project template: `inst/rstudio/templates/project/` — shows in File > New Project
- Document template: `inst/rmarkdown/templates/qbeamer-presentation/` — shows in File > New File > R Markdown > From Template

**Dependencies**: `fs` (Imports), `quarto` (Suggests).

## Key LaTeX Packages

ragged2e, etoolbox, orcidlink, amsmath (loaded in preamble.tex).
