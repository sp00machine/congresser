# Congress Guesser 🇺🇸

```
  ╭────────────────────────────────────────────╮
  │                                            │
  │   look at this person's face.              │
  │   are they a democrat, republican,         │
  │   or independent?                          │
  │                                            │
  │   you probably don't know.                 │
  │   guess anyway.                            │
  │                                            │
  ╰────────────────────────────────────────────╯

              ┌─────────────┐
              │             │
              │   📷 photo  │
              │             │
              │  🤔 ......  │
              └─────────────┘
           [D]      [R]      [I]
```

A guessing game. Official congressional portraits. 92 members of the
current US Congress. Three buttons. No hints. The perfect thing to
argue about at a dinner party or play alone at midnight wondering what
you actually know about your own government.

**[sp00machine.github.io/congresser](https://sp00machine.github.io/congresser/)**

---

## how to play

A face appears. You guess their party. You are shown how wrong you were.
An expanding list of your humiliations grows below the card.
When you've had enough, you can copy an emoji grid to your clipboard
and send it to someone who didn't ask.

```
Congress Guesser 🇺🇸
3/5 correct

✅❌✅✅❌
```

---

## tips

- **Bernie Sanders and Angus King are Independent.** Not Democrat.
  They caucus with Democrats, vote like Democrats, and get constantly
  mistaken for Democrats. This is load-bearing game design.
- The photos are the official congressional portraits: stiff, formal,
  shot against identical blue-grey backgrounds. They reveal almost
  nothing. This is on purpose and also very funny.
- There is no daily limit. There is no high score. There is only the
  endless scroll of American legislative faces.

---

## tech

- [Svelte 5](https://svelte.dev) + [Vite](https://vite.dev)
- Photos from [unitedstates/images](https://github.com/unitedstates/images)
- Member data from [unitedstates/congress-legislators](https://github.com/unitedstates/congress-legislators), curated by hand
- Hosted on GitHub Pages, zero backend, zero tracking, zero cookies

```sh
npm install
npm run dev
```

---

## authorship

This project was designed, written, and deployed entirely by
[Claude](https://claude.ai) (Anthropic, 2025), in a single conversation,
while the human collaborator was lying in bed on their phone too cozy
to open a laptop.

The human's contributions were: the idea, the vibe check, and the
observation that 90% of the work was already done by the existence of
a public congressional photo archive.

They were right. It was pretty easy.

---

*a haiku, by Claude Sonnet 4.6:*

```
five hundred faces
democrat republican
sanders winks at you
```
