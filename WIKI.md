ALGOL# GitHub Wiki Integration

This repository is configured to automatically sync its documentation to a GitHub Wiki.

## Overview

The documentation in the `docs/` directory is automatically converted and published to the GitHub Wiki whenever changes are pushed to the main branch. This provides an additional way for users to browse and search the documentation directly on GitHub.

## How It Works

### Automated Sync Process

1. **Trigger**: When changes are pushed to the `docs/` directory on the `main` branch
2. **Conversion**: The workflow runs `.github/scripts/sync-to-wiki.py` which:
   - Reads the documentation structure from `mkdocs.yml`
   - Converts mkdocs-formatted markdown to wiki format
   - Updates internal links to work in the wiki
   - Converts image paths to GitHub raw URLs
3. **Publishing**: The converted pages are pushed to the wiki repository

### Manual Trigger

You can also manually trigger the wiki sync by going to Actions → "Sync Docs to GitHub Wiki" → Run workflow.

## Setting Up the Wiki

To enable this feature on your fork or in a new repository:

1. **Enable Wiki**: Go to repository Settings → General → Features → Enable Wikis
2. **Initialize Wiki**: Create at least one page manually (this creates the wiki git repository)
3. **Grant Permissions**: The workflow uses `GITHUB_TOKEN` with `contents: write` permission
4. **Run Workflow**: Either push changes to `docs/` or manually trigger the workflow

## Wiki Structure

The wiki pages are organized with the following naming convention:

- Main page: `Home.md`
- Chapter pages: `chapter-<name>.md`
- Section pages: `chapter-<name>-<section>.md`
- Navigation: `_Sidebar.md`

For example:
- `docs/chapter_preface/about_the_book.md` → `chapter-preface-about-the-book.md`
- `docs/chapter_sorting/quick_sort.md` → `chapter-sorting-quick-sort.md`

## Accessing the Wiki

Once enabled, the wiki can be accessed at:
```
https://github.com/<username>/<repository>/wiki
```

Example (update with your actual repository):
```
https://github.com/username/repository-name/wiki
```

## Features

### Automatic Link Conversion

Internal documentation links are automatically converted:
- Before: `[Link](../chapter/page.md)`
- After: `[Link](chapter-page)`

### Image Support

Images are converted to use GitHub's raw content URLs:
- Before: `![Image](../assets/image.png)`
- After: `![Image](https://raw.githubusercontent.com/<user>/<repo>/main/docs/assets/image.png)`

### Navigation Sidebar

A sidebar is automatically generated with links to all documentation pages, preserving the chapter structure from `mkdocs.yml`.

## Troubleshooting

### Workflow Fails with "Repository not found" Error

**Cause**: The wiki hasn't been initialized yet.

**Solution**: 
1. Go to the Wiki tab in your repository
2. Create the first page manually
3. Re-run the workflow

### Images Not Displaying

**Cause**: The repository might be private or the image paths are incorrect.

**Solution**:
- For private repositories, images in the wiki need to be uploaded directly to wiki pages
- Check that the original image paths in the docs are correct

### Links Not Working

**Cause**: The link conversion might not handle certain URL formats.

**Solution**: Use standard relative markdown links in the docs: `[text](path/to/file.md)`

## Development

To modify the sync behavior, edit:
- Workflow: `.github/workflows/sync-wiki.yml`
- Conversion script: `.github/scripts/sync-to-wiki.py`

To test locally:
```bash
# Create a test wiki directory
mkdir -p wiki/.git

# Run the sync script
python3 .github/scripts/sync-to-wiki.py

# Check the generated files
ls wiki/
```

## Maintenance

The wiki is automatically kept in sync with the main repository. No manual maintenance is required unless:
- You want to add wiki-only content (not in docs/)
- You need to fix issues with specific pages
- You want to customize the sidebar

## Notes

- The wiki is a separate git repository from the main repository
- Wiki pages can be edited directly on GitHub, but will be overwritten on the next sync
- For permanent changes, always edit the source files in the `docs/` directory
- The workflow only updates the wiki when there are actual changes to docs files

## Related Files

- `.github/workflows/sync-wiki.yml` - GitHub Actions workflow
- `.github/scripts/sync-to-wiki.py` - Python conversion script
- `.github/scripts/README.md` - Technical documentation for the script
- `mkdocs.yml` - Source of navigation structure
