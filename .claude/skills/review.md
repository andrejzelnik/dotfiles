---
name: review
description: Review current branch changes for issues, security concerns, and style consistency
user_invocable: true
---

Review all uncommitted and staged changes in the current branch. Check for:
- Shell script issues (shellcheck compliance)
- Security concerns (secrets, credentials, unsafe defaults)
- Style consistency with existing dotfiles conventions
- Broken symlink paths or missing dependencies

Use `git diff` and `git diff --staged` to inspect changes. Report findings concisely.
