/* Гралик — офлайн-оболонка. Гра повністю в одному файлі, тому кеш маленький. */
const VERSION = 'gralyk-v1.0.6';
const SHELL = ['./', 'index.html', 'manifest.webmanifest'];
const OPTIONAL = ['icon-192.png', 'icon-512.png', 'icon-maskable-512.png'];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(VERSION)
    .then((c) => c.addAll(SHELL).then(() => Promise.all(OPTIONAL.map((u) => c.add(u).catch(() => {})))))
    .then(() => self.skipWaiting()));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== VERSION).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;

  // спершу мережа (щоб оновлення приходило одразу), але не довше 3 с — далі кеш
  e.respondWith((async () => {
    const cache = await caches.open(VERSION);
    const cached = () => cache.match(req, { ignoreSearch: true })
      .then((r) => r || (req.mode === 'navigate' ? cache.match('index.html') : null));
    if (!navigator.onLine) {
      const hit = await cached();
      if (hit) return hit;
    }
    try {
      const ctl = new AbortController();
      const timer = setTimeout(() => ctl.abort(), 3000);
      const res = await fetch(new Request(req.url, { cache: 'reload' }), { signal: ctl.signal });
      clearTimeout(timer);
      if (res && res.ok) { cache.put(req, res.clone()); return res; }
      throw new Error('bad status');
    } catch (err) {
      const hit = await cached();
      if (hit) return hit;
      return new Response('', { status: 504, statusText: 'offline' });
    }
  })());
});
