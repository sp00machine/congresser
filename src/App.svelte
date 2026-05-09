<script>
  import { fly } from 'svelte/transition';
  import legislators from './lib/legislators.json';

  const PARTIES = ['Democrat', 'Republican', 'Independent'];

  const COLORS = {
    Democrat:    { base: '#1a56db', light: '#ebf5ff' },
    Republican:  { base: '#c81e1e', light: '#fdf2f2' },
    Independent: { base: '#7e3af2', light: '#f5f3ff' },
  };

  let guesses = $state([]);
  let revealing = $state(false);
  let reveal = $state(null);
  let copied = $state(false);
  let imgKey = $state(0);
  let imgError = $state(false);

  function pick() {
    const recent = new Set(guesses.slice(0, 15).map(g => g.member.bioguide));
    const pool = legislators.filter(m => !recent.has(m.bioguide));
    const src = pool.length > 0 ? pool : legislators;
    return src[Math.floor(Math.random() * src.length)];
  }

  let current = $state(pick());

  function guess(party) {
    if (revealing) return;
    const correct = party === current.party;
    const record = { id: Date.now(), correct, member: { ...current }, guessedParty: party };
    reveal = record;
    revealing = true;

    setTimeout(() => {
      guesses = [record, ...guesses];
      current = pick();
      imgKey += 1;
      imgError = false;
      revealing = false;
      reveal = null;
    }, 1800);
  }

  async function share() {
    const score = guesses.filter(g => g.correct).length;
    const grid = guesses.map(g => g.correct ? '✅' : '❌').join('');
    const text = `Congress Guesser 🇺🇸\n${score}/${guesses.length} correct\n\n${grid}`;
    try {
      await navigator.clipboard.writeText(text);
      copied = true;
      setTimeout(() => (copied = false), 2000);
    } catch { /* clipboard not available */ }
  }

  const photoUrl = b => `https://theunitedstates.io/images/congress/225x275/${b}.jpg`;
</script>

<main>
  <header class="app-header">
    <h1>Congress Guesser</h1>
    <p class="subtitle">Democrat, Republican, or Independent?</p>
  </header>

  <div class="game-area">
    {#key imgKey}
      <div class="photo-wrap" in:fly={{ y: 40, duration: 320 }}>
        {#if !imgError}
          <img
            class="member-photo"
            src={photoUrl(current.bioguide)}
            alt="A member of Congress"
            onerror={() => (imgError = true)}
          />
        {:else}
          <div class="photo-placeholder"><span>?</span></div>
        {/if}

        {#if revealing && reveal}
          <div
            class="reveal-banner"
            class:correct={reveal.correct}
            class:incorrect={!reveal.correct}
            in:fly={{ y: 8, duration: 180 }}
          >
            <span class="reveal-icon">{reveal.correct ? '✓' : '✗'}</span>
            <div class="reveal-info">
              <span class="reveal-name">{reveal.member.name}</span>
              <span class="reveal-meta">
                {reveal.member.party} · {reveal.member.state} · {reveal.member.chamber}
              </span>
            </div>
          </div>
        {/if}
      </div>
    {/key}

    <div class="party-buttons">
      {#each PARTIES as party}
        {@const isCorrect = revealing && reveal && party === reveal.member.party}
        {@const isWrong = revealing && reveal && party === reveal.guessedParty && !reveal.correct}
        <button
          class="party-btn"
          class:btn-correct={isCorrect}
          class:btn-wrong={isWrong}
          style="--c: {COLORS[party].base}; --cl: {COLORS[party].light}"
          disabled={revealing}
          onclick={() => guess(party)}
        >
          {party}
        </button>
      {/each}
    </div>
  </div>

  {#if guesses.length > 0}
    <div class="score-row">
      <span class="score-text">{guesses.filter(g => g.correct).length}/{guesses.length} correct</span>
      <button class="share-btn" onclick={share}>
        {copied ? '✓ Copied!' : '📋 Share Results'}
      </button>
    </div>

    <div class="history">
      {#each guesses as g (g.id)}
        <div
          class="history-item"
          class:item-correct={g.correct}
          class:item-wrong={!g.correct}
          in:fly={{ x: -16, duration: 250 }}
        >
          <img
            class="history-thumb"
            src={photoUrl(g.member.bioguide)}
            alt={g.member.name}
            onerror={e => (e.target.style.display = 'none')}
          />
          <div class="history-text">
            <span class="history-name">{g.member.name}</span>
            <span class="history-meta">
              {g.member.party} · {g.member.state} · {g.member.chamber}{#if !g.correct} · <em>you guessed {g.guessedParty}</em>{/if}
            </span>
          </div>
          <span class="history-emoji">{g.correct ? '✅' : '❌'}</span>
        </div>
      {/each}
    </div>
  {/if}
</main>
