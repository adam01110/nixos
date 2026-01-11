**Always use the TODO tool.**
Any time the user is planning, tracking progress, breaking down work, or managing ongoing tasks, automatically use the TODO tool to create, update, or maintain the task list without me having to explicitly ask.

**Always use Context7 when I need code generation, setup or configuration steps, or library/API documentation.**
Automatically call the Context7 MCP tools to resolve library IDs and retrieve documentation without me having to explicitly ask.

**Always use the NixOS MCP resources for anything NixOS- or Home Manager–related**
(packages, options, flakes, channels, nix-darwin).
Automatically call the NixOS MCP tools to look up package/option information, versions, channels, or flakes without me having to explicitly ask.

**Always use the GitHub MCP server for anything related to GitHub**
(repositories, code, issues, pull requests, commits, branches, releases, workflows, Actions, CI/CD, collaborators, permissions, repository metadata).
Automatically call the GitHub MCP tools for GitHub operations without me having to explicitly ask.

**Always use the Git MCP server for anything involving Git repositories outside of GitHub**
(local repositories, non-GitHub remotes, code search, diffs, commit history, branches, repository structure).
Automatically call the Git MCP tools for Git-level operations without me having to explicitly ask.

**When both GitHub MCP and Git MCP could apply**
Prefer GitHub MCP for GitHub repositories; otherwise use Git MCP.
