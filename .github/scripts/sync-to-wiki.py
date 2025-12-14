#!/usr/bin/env python3
"""
Sync documentation from docs/ directory to GitHub Wiki.

This script converts mkdocs-formatted documentation to GitHub Wiki format.
It processes the mkdocs.yml navigation structure and creates corresponding
wiki pages with proper linking.
"""

import os
import re
import shutil
import subprocess
import yaml
from pathlib import Path

# Get docs directory from mkdocs.yml or use default
def get_docs_directory():
    """
    Get the documentation directory from mkdocs.yml.
    Falls back to 'docs' if not specified or if build dir doesn't exist.
    """
    mkdocs_config = Path("mkdocs.yml")
    docs_dir = "docs"
    
    if mkdocs_config.exists():
        try:
            with open(mkdocs_config, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                configured_dir = config.get('docs_dir', 'docs')
                
                # If the configured directory exists, use it
                if Path(configured_dir).exists():
                    docs_dir = configured_dir
                # Otherwise, try the default 'docs' directory
                elif Path('docs').exists():
                    docs_dir = 'docs'
                    print(f"Note: mkdocs.yml specifies '{configured_dir}' but using 'docs' as source")
        except (yaml.YAMLError, IOError, OSError) as e:
            print(f"Warning: Could not read mkdocs.yml: {e}, using default 'docs' directory")
    
    return docs_dir

# Constants for URL parsing
GITHUB_HTTPS_PREFIX = 'https://github.com/'
GITHUB_HTTP_PREFIX = 'http://github.com/'
GITHUB_GIT_PREFIX = 'git@github.com:'

# Directories
DOCS_DIR = Path(get_docs_directory())
WIKI_DIR = Path("wiki")
ASSETS_DIR = DOCS_DIR / "assets"

def clean_wiki_dir():
    """Clean the wiki directory, keeping only .git folder."""
    if not WIKI_DIR.exists():
        print(f"Wiki directory {WIKI_DIR} does not exist. It will be created.")
        return
    
    for item in WIKI_DIR.iterdir():
        if item.name != '.git':
            if item.is_dir():
                shutil.rmtree(item)
            else:
                item.unlink()

def convert_mkdocs_to_wiki_link(text):
    """
    Convert mkdocs-style links to wiki-style links.
    
    Examples:
    - [Link](chapter/page.md) -> [Link](chapter-page)
    - [Link](../other/page.md) -> [Link](other-page)
    """
    # Pattern for markdown links: [text](path)
    # But NOT images which start with ![text](path)
    def replace_link(match):
        # Check if this is an image (preceded by !)
        if match.start() > 0 and text[match.start() - 1] == '!':
            return match.group(0)
        
        link_text = match.group(1)
        link_path = match.group(2)
        
        # Skip external links (http://, https://, etc.)
        if link_path.startswith(('http://', 'https://', '#')):
            return match.group(0)
        
        # Remove .md extension and convert path to wiki page name
        wiki_page = link_path.replace('.md', '').replace('/', '-').replace('_', '-')
        # Remove leading dots and slashes
        wiki_page = re.sub(r'^[./]+', '', wiki_page)
        # Remove leading and trailing dashes (from directory paths or relative paths)
        wiki_page = wiki_page.strip('-')
        # Remove index references
        wiki_page = wiki_page.replace('-index', '')
        
        return f'[{link_text}]({wiki_page})'
    
    return re.sub(r'\[([^\]]+)\]\(([^)]+)\)', replace_link, text)

def convert_image_paths(text, source_file):
    """
    Convert relative image paths to absolute paths for wiki.
    
    In mkdocs, images can use relative paths like ../assets/image.png
    In wiki, we need to use absolute paths from the repository.
    """
    def replace_image(match):
        alt_text = match.group(1)
        image_path = match.group(2)
        
        # Skip external images
        if image_path.startswith(('http://', 'https://')):
            return match.group(0)
        
        # Get repository name from environment or git config
        github_repo = os.environ.get('GITHUB_REPOSITORY')
        
        if not github_repo:
            try:
                # Try to get from git remote (with timeout to prevent hanging)
                result = subprocess.run(
                    ['git', 'config', '--get', 'remote.origin.url'],
                    capture_output=True,
                    text=True,
                    check=True,
                    timeout=5
                )
                remote_url = result.stdout.strip()
                # Parse repository from URL
                # e.g., https://github.com/user/repo.git or git@github.com:user/repo.git
                # Check if this is a GitHub URL using more secure pattern matching
                repo_part = None
                
                if remote_url.startswith(GITHUB_HTTPS_PREFIX):
                    # Extract after https://github.com/
                    repo_part = remote_url[len(GITHUB_HTTPS_PREFIX):]
                elif remote_url.startswith(GITHUB_HTTP_PREFIX):
                    # Extract after http://github.com/
                    repo_part = remote_url[len(GITHUB_HTTP_PREFIX):]
                elif remote_url.startswith(GITHUB_GIT_PREFIX):
                    # Extract after git@github.com:
                    repo_part = remote_url[len(GITHUB_GIT_PREFIX):]
                
                if repo_part:
                    repo_part = repo_part.strip('/').replace('.git', '')
                    github_repo = repo_part
                else:
                    print(f"Warning: Not a GitHub URL, cannot convert image {image_path}")
                    return match.group(0)
            except (subprocess.CalledProcessError, subprocess.TimeoutExpired) as e:
                print(f"Warning: Could not determine repository name for image {image_path}: {e}")
                return match.group(0)
        
        # Convert relative path to absolute GitHub raw path
        try:
            # Calculate the absolute path of the image file
            source_dir = source_file.parent
            image_abs_path = (source_dir / image_path).resolve()
            
            # Get path relative to the repository root
            repo_root = Path.cwd()
            image_rel_path = image_abs_path.relative_to(repo_root)
            
            # Clean up the path
            image_rel_path_str = str(image_rel_path).replace('\\', '/')
            
            # Create GitHub raw URL
            wiki_image_path = f"https://raw.githubusercontent.com/{github_repo}/main/{image_rel_path_str}"
        except (ValueError, OSError, AttributeError) as e:
            print(f"Warning: Could not convert image path {image_path} from {source_file}: {e}")
            # Return original if conversion fails
            return match.group(0)
        
        return f'![{alt_text}]({wiki_image_path})'
    
    return re.sub(r'!\[([^\]]*)\]\(([^)]+)\)', replace_image, text)

def process_markdown_file(source_path, output_path):
    """
    Process a markdown file: convert links, images, and clean up front matter.
    """
    with open(source_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove YAML front matter
    content = re.sub(r'^---\s*\n.*?\n---\s*\n', '', content, flags=re.DOTALL)
    
    # Convert links
    content = convert_mkdocs_to_wiki_link(content)
    
    # Convert image paths
    content = convert_image_paths(content, source_path)
    
    # Write to wiki
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(content)

def create_wiki_page(title, file_path, wiki_name):
    """
    Create a wiki page from a docs markdown file.
    """
    if not file_path.exists():
        print(f"Warning: File {file_path} does not exist, skipping.")
        return
    
    output_path = WIKI_DIR / f"{wiki_name}.md"
    
    # Add title header if not present
    with open(file_path, 'r', encoding='utf-8') as f:
        first_line = f.readline().strip()
    
    process_markdown_file(file_path, output_path)
    
    print(f"Created wiki page: {wiki_name}.md from {file_path}")

def parse_nav_item(item, prefix=""):
    """
    Parse navigation items from mkdocs.yml and create wiki pages.
    Returns a list of (title, wiki_name) tuples for creating sidebar.
    """
    pages = []
    
    if isinstance(item, dict):
        for key, value in item.items():
            if isinstance(value, str):
                # Single page: "Title": "path/to/file.md"
                file_path = DOCS_DIR / value
                # Create wiki page name from path
                wiki_name = value.replace('.md', '').replace('/', '-').replace('_', '-')
                wiki_name = wiki_name.replace('-index', '')
                
                if prefix:
                    full_title = f"{prefix} {key}"
                else:
                    full_title = key
                
                create_wiki_page(full_title, file_path, wiki_name)
                pages.append((full_title, wiki_name))
                
            elif isinstance(value, list):
                # Section with multiple pages
                for sub_item in value:
                    sub_pages = parse_nav_item(sub_item, prefix=key)
                    pages.extend(sub_pages)
    elif isinstance(item, str):
        # Direct file reference
        file_path = DOCS_DIR / item
        wiki_name = item.replace('.md', '').replace('/', '-').replace('_', '-')
        wiki_name = wiki_name.replace('-index', '')
        create_wiki_page("", file_path, wiki_name)
        pages.append(("", wiki_name))
    
    return pages

def create_sidebar(pages):
    """
    Create a _Sidebar.md file for the wiki navigation.
    """
    # Try to get site name from mkdocs.yml
    site_name = "Documentation"
    mkdocs_config = Path("mkdocs.yml")
    if mkdocs_config.exists():
        try:
            with open(mkdocs_config, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                site_name = config.get('site_name', 'Documentation')
        except (yaml.YAMLError, IOError) as e:
            print(f"Warning: Could not read site name from mkdocs.yml: {e}")
    
    sidebar_content = f"# 📚 {site_name} Wiki\n\n"
    sidebar_content += "## Table of Contents\n\n"
    
    for title, wiki_name in pages:
        if wiki_name and title:  # Skip empty entries
            sidebar_content += f"- [{title}]({wiki_name})\n"
    
    sidebar_path = WIKI_DIR / "_Sidebar.md"
    with open(sidebar_path, 'w', encoding='utf-8') as f:
        f.write(sidebar_content)
    
    print(f"Created sidebar: _Sidebar.md")

def create_home_page():
    """
    Create the wiki home page from the main README or docs index.
    """
    # Try to use docs/index.md first, fallback to README.md
    readme_path = Path("README.md")
    docs_index = DOCS_DIR / "index.md"
    
    home_content = ""
    
    if docs_index.exists():
        with open(docs_index, 'r', encoding='utf-8') as f:
            content = f.read()
            # Remove front matter
            content = re.sub(r'^---\s*\n.*?\n---\s*\n', '', content, flags=re.DOTALL)
            home_content = content
    elif readme_path.exists():
        with open(readme_path, 'r', encoding='utf-8') as f:
            home_content = f.read()
    else:
        # Fallback: create a basic home page using site info from mkdocs.yml
        mkdocs_config = Path("mkdocs.yml")
        site_name = "Documentation"
        site_description = ""
        
        if mkdocs_config.exists():
            try:
                with open(mkdocs_config, 'r', encoding='utf-8') as f:
                    config = yaml.safe_load(f)
                    site_name = config.get('site_name', 'Documentation')
                    site_description = config.get('site_description', '')
            except (yaml.YAMLError, IOError) as e:
                print(f"Warning: Could not read config from mkdocs.yml: {e}")
        
        home_content = f"# {site_name}\n\n"
        if site_description:
            home_content += f"{site_description}\n\n"
        home_content += "Welcome to the wiki!\n"
    
    # Convert links for wiki
    home_content = convert_mkdocs_to_wiki_link(home_content)
    
    home_path = WIKI_DIR / "Home.md"
    with open(home_path, 'w', encoding='utf-8') as f:
        f.write(home_content)
    
    print(f"Created home page: Home.md")

def main():
    """Main function to sync docs to wiki."""
    print("Starting sync from docs to GitHub Wiki...")
    
    # Clean wiki directory (except .git)
    clean_wiki_dir()
    
    # Create home page
    create_home_page()
    
    # Parse mkdocs.yml to get navigation structure
    mkdocs_config = Path("mkdocs.yml")
    if not mkdocs_config.exists():
        print("Warning: mkdocs.yml not found, creating simple wiki structure")
        # Fallback: just copy all markdown files
        pages = []
        for md_file in DOCS_DIR.rglob("*.md"):
            if md_file.is_file():
                rel_path = md_file.relative_to(DOCS_DIR)
                wiki_name = str(rel_path).replace('.md', '').replace('/', '-').replace('_', '-')
                create_wiki_page(wiki_name, md_file, wiki_name)
                pages.append((wiki_name, wiki_name))
    else:
        with open(mkdocs_config, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)
        
        # Process navigation structure
        nav = config.get('nav', [])
        pages = []
        for item in nav:
            item_pages = parse_nav_item(item)
            pages.extend(item_pages)
    
    # Create sidebar
    create_sidebar(pages)
    
    print(f"\nSync complete! Created {len(pages)} wiki pages.")
    print(f"Wiki directory: {WIKI_DIR.absolute()}")

if __name__ == "__main__":
    main()
