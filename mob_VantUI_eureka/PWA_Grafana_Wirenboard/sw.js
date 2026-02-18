const CACHE_NAME = 'wb-monitoring-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/manifest.json',
  'https://fastly.jsdelivr.net/npm/vant@4/lib/index.css',
  'https://fastly.jsdelivr.net/npm/vue@3/dist/vue.global.prod.js',
  'https://fastly.jsdelivr.net/npm/vant@4/lib/vant.min.js',
  'https://fastly.jsdelivr.net/npm/echarts@5/dist/echarts.min.js'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => response || fetch(event.request))
  );
});

self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (!cacheWhitelist.includes(cacheName)) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
