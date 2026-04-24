# qbeamer <a href="https://github.com/GabboCg/qbeamer"><img src="man/figures/logo.png" align="right" height="138" /></a>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

qbeamer is an R package that provides a custom [Quarto](https://quarto.org) Beamer presentation format with professional styling, enhanced author/affiliation support (including ORCID), and RStudio integration. Inspired by [beamer-tips](https://github.com/paulgp/beamer-tips), adapted for a Quarto-based workflow.

## Installation

```r
# Install from GitHub
# install.packages("remotes")
remotes::install_github("GabboCg/qbeamer")
```

## Usage

### From RStudio

- **New Project**: File > New Project > New Directory > Quarto Beamer Presentation (qbeamer)
- **New File**: File > New File > R Markdown > From Template > Quarto Beamer (qbeamer)

### From R

```r
# Install the extension in your project
qbeamer::install_extension()

# Render a presentation
qbeamer::qbeamer_render("slides.qmd")

# Preview with live reload
qbeamer::qbeamer_preview("slides.qmd")
```

### QMD format

Use `qbeamer-beamer` as the format in your YAML front matter:

```yaml
---
title: "My Presentation"
author:
  - name: Author Name
    orcid: 0000-0000-0000-0000
    affiliations:
      - ref: inst1

affiliations:
  - id: inst1
    name: Institution Name
    department: Department Name

format:
  qbeamer-beamer: default
---
```

## Features

- Custom color palette (blue, red, yellow, green)
- Modified bullet styling and itemize/enumerate spacing
- Custom footline with frame numbers and navigation buttons
- Yellow section break slides
- ORCID support for author metadata
- Multiple authors with affiliations
- Short title and short author support
- Callout styling (note, warning)
- Text justification across all frames
