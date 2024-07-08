'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "db86e8c6a827572293eaa7de96a5a035",
"assets/AssetManifest.bin.json": "78be9962deff8ab1408391974c8d4c82",
"assets/AssetManifest.json": "56afe9c2a594c32e0cb97054dbd7f0bb",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "7469150e923889d898e60e5e729443e2",
"assets/NOTICES": "15624cbf642a9451b06400390bfb478f",
"assets/packages/avatar_maker/assets/icons/accessories.svg": "2aab6b9fbe1abe57337bbe1440e12fe4",
"assets/packages/avatar_maker/assets/icons/background.svg": "bcfa549aea018f81cfc9e08084177f5b",
"assets/packages/avatar_maker/assets/icons/eyebrows.svg": "9c01feae151b49c5f2648fbeb91fa704",
"assets/packages/avatar_maker/assets/icons/eyes.svg": "21ccc3a181a0bd086f7c1cdf33f8caee",
"assets/packages/avatar_maker/assets/icons/facial_hair.svg": "3aacf7e9f7415f0047e086a450c10731",
"assets/packages/avatar_maker/assets/icons/facial_hair_color.svg": "4b52cdffec910b19ec2433a9e97c10a5",
"assets/packages/avatar_maker/assets/icons/hair.svg": "7308eb64cc007ed31d20c8845287eeec",
"assets/packages/avatar_maker/assets/icons/hair_color.svg": "6eff8b28ce0dae8c1f39703d9685d84a",
"assets/packages/avatar_maker/assets/icons/mouth.svg": "59fe8c742a122a56812418808f6a93ca",
"assets/packages/avatar_maker/assets/icons/noses.svg": "b9b1deb166a2ddfded9d523ac52c13c0",
"assets/packages/avatar_maker/assets/icons/outfit.svg": "863d9bd68b6d3f2945d2c7e090fdee47",
"assets/packages/avatar_maker/assets/icons/outfit_color.svg": "add9b32737074b18be171684feeef23a",
"assets/packages/avatar_maker/assets/icons/skin.svg": "4e716cbbe926c05bf47cec8b658c35a1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.ico": "383d179b8b6779b538e479990b598a02",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "ef00fb5d82538bee77909d13f1fddf43",
"icons/android-icon-144x144.png": "843781c1c80597dcf7182dece8474321",
"icons/android-icon-192x192.png": "3458963860f3ebc53f78a82a005cde4a",
"icons/android-icon-36x36.png": "01587d916a2af2fc797c4629d515fc2b",
"icons/android-icon-48x48.png": "7daaf8e83b9360ba9c2f99c57f858f5e",
"icons/android-icon-72x72.png": "ffbb9f2db183b54b69a155aac31e8864",
"icons/android-icon-96x96.png": "f3d38ce63e89b0ee161514b3b6c967e3",
"icons/apple-icon-114x114.png": "ffe8811a013a8c1a0e8520a324a20d62",
"icons/apple-icon-120x120.png": "1a543101c9cdbb8753ade58675bebb66",
"icons/apple-icon-144x144.png": "843781c1c80597dcf7182dece8474321",
"icons/apple-icon-152x152.png": "200b7946593ba1801517b8056a53c386",
"icons/apple-icon-180x180.png": "c11f5859ba01c9f3722bb1dde902952e",
"icons/apple-icon-57x57.png": "ea2f41adf267bbb19a00efa4b693cb90",
"icons/apple-icon-60x60.png": "3b641be7d6c88df68eaec718ee7ebfa9",
"icons/apple-icon-72x72.png": "ffbb9f2db183b54b69a155aac31e8864",
"icons/apple-icon-76x76.png": "9a22899425a043162d3534148e623998",
"icons/apple-icon-precomposed.png": "2735dbbc0a88d6b12ebea7364d8fbfd7",
"icons/apple-icon.png": "2735dbbc0a88d6b12ebea7364d8fbfd7",
"icons/browserconfig.xml": "97775b1fd3b6e6c13fc719c2c7dd0ffe",
"icons/favicon-16x16.png": "d6b16d7b22cbb0f5b69f808c7ec794d5",
"icons/favicon-32x32.png": "57cda12ea82a2933ff648813ae6d0e28",
"icons/favicon-96x96.png": "f3d38ce63e89b0ee161514b3b6c967e3",
"icons/favicon.ico": "383d179b8b6779b538e479990b598a02",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/manifest.json": "e50e6a1c9ed6452635d3211f39501e0d",
"icons/ms-icon-144x144.png": "843781c1c80597dcf7182dece8474321",
"icons/ms-icon-150x150.png": "9e0fdf5f60936b1c3e95135e039a4c94",
"icons/ms-icon-310x310.png": "423ee2e3583c91d7b9d98d394184cf66",
"icons/ms-icon-70x70.png": "e45bafd0b3047150797c7aed0fc372df",
"index.html": "8bf520884809d54dbb194086e2a7ae47",
"/": "8bf520884809d54dbb194086e2a7ae47",
"main.dart.js": "7b485abb52d364592ae05ef07295116b",
"manifest.json": "9e7b34fd7c291ca2523123ef20497930",
"version.json": "ee0df5858f5f08c24827532738d77210"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
