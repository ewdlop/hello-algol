# GitHub Wiki Sync Script

This directory contains scripts for syncing documentation to GitHub Wiki.

## sync-to-wiki.py

This Python script converts the mkdocs-formatted documentation in the `docs/` directory to GitHub Wiki format and prepares it for publishing to the repository's wiki.

### What it does:

1. **Cleans the wiki directory**: Removes all files except the `.git` folder
2. **Creates a Home page**: Uses `docs/index.md` or `README.md` as the wiki home page
3. **Processes all documentation**: 
   - Reads the navigation structure from `mkdocs.yml`
   - Converts each page from mkdocs format to wiki format
   - Removes YAML front matter
   - Converts relative links to wiki-style links
   - Converts image paths to GitHub raw URLs
4. **Creates navigation**: Generates a `_Sidebar.md` file with links to all pages

### Usage:

The script is automatically run by the GitHub Actions workflow `.github/workflows/sync-wiki.yml` whenever changes are pushed to the `docs/` directory.

To run manually:
```bash
python3 .github/scripts/sync-to-wiki.py
```

### Requirements:

- Python 3.7+
- pyyaml

Install dependencies:
```bash
pip install pyyaml
```

### Notes:

- The wiki directory structure flattens the hierarchical docs structure into a single level with page names like `chapter-section-page`
- Internal links are automatically converted from mkdocs format `[text](path/to/page.md)` to wiki format `[text](chapter-section-page)`
- Images are converted to use GitHub's raw content URLs to ensure they display properly in the wiki
