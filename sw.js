/* Energy UA Junior — офлайн-оболонка.
   З 1.2.4 цей файл між версіями НЕ змінюється: інакше браузер сам ставив би
   новий service worker і гра оновлювалась би без дозволу. Нову версію гра
   ставить лише після «🔄 Оновити» в діалозі: тоді вона чистить цей кеш,
   знімає service worker і перезавантажується - і він кешує вже нові файли. */
const CACHE = 'eua-junior';
const SHELL = ['./', 'index.html', 'manifest.webmanifest'];
const OPTIONAL = ['icon-192.png', 'icon-512.png', 'icon-maskable-512.png', 'voice.pack'];
const fresh = (u) => new Request(u, { cache: 'reload' });   // повз HTTP-кеш браузера

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE)
    .then((c) => c.addAll(SHELL.map(fresh)).then(() => Promise.all(OPTIONAL.map((u) => c.add(fresh(u)).catch(() => {})))))
    .then(() => self.skipWaiting()));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;
  // перевірка оновлень - завжди з мережі, нічого не кешуємо
  if (url.pathname.endsWith('/version.json') || url.searchParams.has('t')) return;
  // решта - спершу збережене (так нова версія не підміняє стару сама), інакше мережа
  e.respondWith(caches.open(CACHE).then(async (c) => {
    const hit = await c.match(req, { ignoreSearch: true }) ||
      (req.mode === 'navigate' ? await c.match('index.html') : null);
    if (hit) return hit;
    try {
      const res = await fetch(req);
      if (res && res.ok) c.put(req, res.clone());
      return res;
    } catch (err) {
      return new Response('', { status: 504, statusText: 'offline' });
    }
  }));
});
