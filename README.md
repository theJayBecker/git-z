# git-z 🧃

> _Because `git commit` is cringe and `git push` deserves more YEET._

`git-z` is a Gen Z–styled wrapper around `git`, replacing boring developer commands with language that actually slaps.

Think of it as Git, but if it was powered by Red Bull and TikTok. Every command hits different. 

---

## 💾 Installation

### 🧠 Step 1: Clone the repo

```bash
git clone https://github.com/theJayBecker/git-z.git
cd git-z
```

### 🔧 Step 2: Install it

```bash
./install.sh
```

Supports:
- ✅ Bash
- ✅ Zsh
- ✅ Fish 🐟
- 🧠 Automatically detects your shell
- 🛡 Only wraps Git in interactive terminals (so your CI won't cancel you)

---

## 🎮 How to Use

After installing, you just use `git` like normal... but better:

```bash
git yoink
git bet "fixed that cursed bug"
git drip
```

To see all the supported Zoomer commands:

```bash
git halp
```

---

## 📋 Command Cheat Sheet

| Gen Z Command       | Real Git Command         | What It Do 💅                          |
|---------------------|--------------------------|----------------------------------------|
| `git yoink`         | `git pull`               | Pull the latest clout from origin      |
| `git yeet`          | `git push`               | Fling your cringe into the void        |
| `git finna add`     | `git add .`              | Stage all the vibes                    |
| `git bet "msg"`     | `git commit -m "msg"`    | Lock it in, no cap                     |
| `git cap`           | `git reset --hard`       | Undo that trash, no cap                |
| `git drip`          | `git status`             | Check your fit (file status)           |
| `git ghost`         | `git checkout`           | Dip to another branch                  |
| `git throw hands`   | `git merge`              | Smash branches together like drama     |
| `git realtalk`      | `git init`               | Start the repo — fr fr                 |
| `git shill <url>`   | `git remote add origin`  | Plug into origin and flex              |
| `git receipts`      | `git log`                | Show the messy receipts                |
| `git cancel <rev>`  | `git revert <rev>`       | Walk it back. It was not giving.       |
| `git vibecheck`     | `git diff`               | Check what broke the vibe              |
| `git maincharacter` | `git switch main`        | Take center stage                      |
| `git glowup [n]`    | `git rebase -i HEAD~n`   | Rewrite history to make it slap        |
| `git halp`          | `n/a`                    | Show this whole list again             |

---

## 🛟 Why?

Because the world is dark and full of `git rebase` errors.  
Because life is too short to type `git status`.  
Because _"yeet"_ is semantically richer than "push".

---

## 🧼 What It Doesn’t Do

- Doesn't touch CI/CD or non-interactive shells
- Doesn’t break existing git commands
- Doesn’t overwrite `git` binary — it just aliases `git` to `git-z` in your shell

---

## 🧽 Uninstall

You can remove `git-z` like so:

```bash
rm ~/.local/bin/git-z
```

Then delete the alias/function in:
- `~/.bashrc`, `~/.zshrc`, or
- `~/.config/fish/functions/git.fish`

---

## 🧃 Contributing

Fork it, meme responsibly, and drop a PR.  
No boomers allowed.

---

## 🧠 License

MIT — Maximum Internet Trolling
