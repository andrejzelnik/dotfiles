---
name: update-repo
description: Pull latest changes, reinstall brew packages, and verify everything works
user_invocable: true
---

Run the full update sequence:
1. `make update` — pull latest, brew bundle, zim update
2. If any step fails, diagnose and fix the issue
3. Report what was updated and any problems encountered
