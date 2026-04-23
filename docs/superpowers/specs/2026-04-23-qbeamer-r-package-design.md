# qbeamer R Package Design Spec

## Overview

Transform the qbeamer Quarto Beamer template into a full R package that provides:
1. A Quarto extension format (`qbeamer-beamer`)
2. RStudio project and document templates
3. Helper functions for rendering and previewing

## Package Structure

```
qbeamer/
├── DESCRIPTION
├── NAMESPACE
├── LICENSE
├── LICENSE.md
├── R/
│   ├── install_extension.R
│   ├── render.R
│   └── zzz.R
├── inst/
│   ├── extdata/
│   │   └── _extensions/
│   │       └── qbeamer/
│   │           ├── _extension.yml
│   │           ├── before-body.tex
│   │           └── title.tex
│   ├── rstudio/
│   │   └── templates/
│   │       └── project/
│   │           ├── dcf
│   │           └── skeleton/
│   │               └── skeleton.qmd
│   └── rmarkdown/
│       └── templates/
│           └── qbeamer-presentation/
│               ├── template.yaml
│               └── skeleton/
│                   └── skeleton.qmd
├── vignettes/
│   └── example.qmd
├── man/
└── .Rbuildignore
```

## Quarto Extension

`_extension.yml` registers the format:

```yaml
title: qbeamer
author: Gabriel Cabrera Guzmán
version: 0.1.0
contributes:
  formats:
    beamer:
      include-in-header:
        - before-body.tex
      template-partials:
        - title.tex
      pdf-engine: xelatex
      navigation: horizontal
      theme: default
      colortheme: default
      aspectratio: 43
      keep-tex: true
```

The existing `before-body.tex` and `title.tex` move into `inst/extdata/_extensions/qbeamer/` as the single source of truth. Users reference the format as `format: qbeamer-beamer` in their QMD YAML.

## R Functions

### `install_extension(path = ".", overwrite = FALSE)`

Copies `_extensions/qbeamer/` from the installed R package into the target project directory. Creates the `_extensions/` folder if needed. Warns if already installed unless `overwrite = TRUE`.

### `qbeamer_render(input, ...)`

Thin wrapper around `quarto::quarto_render()`. Checks that the extension is installed in the project before rendering. Passes `...` through.

### `qbeamer_preview(input, ...)`

Thin wrapper around `quarto::quarto_preview()`. Same pre-check for extension installation.

## RStudio Integration

### Project Template

Location: `inst/rstudio/templates/project/`

Appears in **File > New Project > New Directory > Quarto Beamer Presentation (qbeamer)**. On creation:
- Creates a new directory with the project name
- Copies a minimal `skeleton.qmd` with `format: qbeamer-beamer`
- Installs the `_extensions/qbeamer/` directory automatically
- Creates an `.Rproj` file

The `dcf` file defines the template metadata and input parameters (title, author) shown in the RStudio wizard dialog.

### Document Template

Location: `inst/rmarkdown/templates/qbeamer-presentation/`

Appears in **File > New File > R Markdown > From Template > Quarto Beamer (qbeamer)**. Creates a single `skeleton.qmd` with minimal YAML front matter. User needs to run `qbeamer::install_extension()` to get the extension files.

### Skeleton QMD

```yaml
---
title: "Untitled Presentation"
author:
  - name: "Author Name"
format:
  qbeamer-beamer: default
---

## First Slide

Content here.
```

## Vignette

The current `example.qmd` (E-M algorithm demo) becomes `vignettes/example.qmd`, showcasing all features: multiple authors with ORCID, affiliations, callouts, buttons, math content, and figures.

## Package Metadata

```
Package: qbeamer
Title: Custom Quarto Beamer Presentation Template
Version: 0.1.0
Authors@R: person("Gabriel", "Cabrera Guzmán",
                   email = "gc@abrerag.rbind.io",
                   role = c("aut", "cre"),
                   comment = c(ORCID = "..."))
Description: Provides a Quarto extension and RStudio integration for creating
    professional Beamer presentations. Includes custom styling, enhanced
    author/affiliation support with ORCID, and helper functions for rendering
    and previewing presentations.
License: MIT + file LICENSE
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.3.0
Imports: fs
Suggests: quarto
```

## Decisions

- **Package name:** qbeamer
- **Format reference:** `qbeamer-beamer` (Quarto extension style)
- **License:** MIT
- **Approach:** Quarto extension bundled inside the R package (`inst/extdata/`)
- **Dependencies:** `fs` (Imports), `quarto` (Suggests)
