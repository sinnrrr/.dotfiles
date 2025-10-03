# Minimal, Simple, Opinionated, Fast

<img src="https://i.imgur.com/rdkAsQ0.png" />

```bash
git clone git@github.com:sinnrrr/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./my.sh --init
```

<details>
<summary>😁 No Neovim</summary>

[**Neovim**](https://neovim.io/) is awesome. I started with [**LunarVim**](https://www.lunarvim.org/), slowly moving to [**LazyVim**](https://www.lazyvim.org/). It’s truly a magnificent experience.

But those breaking changes.. man. Say what you want — lock files, no to updates, . Yet, the hell will still break loose. Your package manager will install unsupported version of dependency or some other shit will show you Murphy’s Law in its best essence.

[**Helix**](https://helix-editor.com/) is **Neovim** but with sane defaults and no config. You can tweak it with TOML, as you should. Neither you or me are code editor developers. You don’t need it as your second job. I believe you should spend this time solving world hunger, treating cancer or launching aircrafts onto mars than your vim plugin breaking changes.
</details>


<details>
<summary>🐟 Fish!</summary>

[**Fish**](https://fishshell.com/) is heavily maintained and one of the mainstream shells. It will live long enough before AI takes over my job. 

It’s mature and seems like its plugin system is dying. But I consider it to be a good sign. That means they’re not needed!

What **Fish** is good for is — you guessed it right - sane defaults! 

I used zsh with [**powerlevel10k**](https://github.com/romkatv/powerlevel10k) and [**zinit**](https://github.com/zdharma-continuum/zinit). Using these 3 now requires you to know about p10k caching, how zsh plugins system works, zinit icing, plugins, etc.

**Fish** is just fish. Install it and use — no config needed. It’s good already. Wanna run POSIX? Good — create script file and execute with bash or zsh! Otherwise, you can use GPT for your day to day oneliner cli commands.
</details>


<details>
<summary>🙆 No chezmoi, ansible, etc.</summary>

[**Chezmoi**](https://www.chezmoi.io/) looks solid. [**Ansible**](https://www.ansible.com/) has also got its own fair use cases for dotfiles. Tho, as we all know by now - it’s the abstraction layer we don’t need.

Use shell script and [**stow**](https://www.gnu.org/software/stow/)! It’s 0 vendor lock in and native to UNIX philosophy (GNU). No need to make it more complex than it should.
</details>

<details>
<summary>🙂‍↔️ No Zellij, Tmux (but i might reconsider lmao)</summary>

While I am a fan of terminal multiplexers, they inherently introduce another layer of abstraction, additional keybinds and complexity to the terminal. It’s already pretty hard to grasp, why making it harder?

As an alternative, I propose using combination of [**Wezterm**](https://wezfurlong.org/wezterm/)'s Panes and [**Yabai**](https://github.com/koekeishiya/yabai) window manager. **Wezterm** can manage panes, and **Yabai** will manage windows, as they were created for that.
</details>

<details>
<summary>🤔 Why yabai?</summary>

While I know [**yabai**](https://github.com/koekeishiya/yabai) is one of the harder to learn ones it’s also best in class. My 2020 Macbook Air 8/256 just sometimes freezes with other window managers. **Yabai** is open source, VERY configurable and BLAZINGLY FAST ⚡️⚡️

I also love that it’s using native MacOS windows instead of virtual ones. You can call mission control and see all of your workspaces at glance — it’s all native!

Please consider [supporting Yabai’s developer](https://github.com/sponsors/koekeishiya)! He’s been doing it for years solo, he deserves to be supported!
</details>
<details>
<summary>💻 Use TUI, PLEASE</summary>

[**Lazygit**](https://github.com/jesseduffield/lazygit) is hands down my best productivity tool ever. It saved me tons of hours on my commits, branching, PRs, merging/rebasing.

Consider using TUI where you can. It’s like UI but faster. Tho I’d advise to be careful and not use the less popular/niche ones and stick to UI in those situations. For example [**DBeaver**](https://dbeaver.io/) over TUI SQL thingys. **DBeaver** is a best in industry DB UI, you can’t compete with it.

See the philosophy? Choose software wisely. Don’t pick something you’ll throw away soon. Pick stuff that will serve you for years with no maintenance. Get dat muscle memory, but be open for someting new! Maybe those SQL TUIs will get better!! Or AI will replace you (this is more probable)

Btw I don’t use Spotify TUI as I like seeing album covers. Music is an art and I want to experience it in its full, as it was designed by the artists.
</details>
