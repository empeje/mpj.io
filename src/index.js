import 'bootstrap/dist/css/bootstrap.css'
import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
import './kit-form.js';

const app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: null
});

// Handle structured data injection based on route
if (app.ports && app.ports.updateStructuredData) {
  app.ports.updateStructuredData.subscribe(function(data) {
    // Remove any existing structured data script
    const existingScript = document.querySelector('script[type="application/ld+json"]');
    if (existingScript) {
      existingScript.remove();
    }

    // If data is provided, add new structured data script to head
    if (data && data.trim() !== '') {
      const script = document.createElement('script');
      script.type = 'application/ld+json';
      script.text = data;
      document.head.appendChild(script);
    }
  });
}

// Handle Open Graph URL updates based on route
if (app.ports && app.ports.updateOgUrl) {
  app.ports.updateOgUrl.subscribe(function(url) {
    // Update og:url meta tag
    let ogUrlMeta = document.querySelector('meta[property="og:url"]');
    if (ogUrlMeta) {
      ogUrlMeta.setAttribute('content', url);
    }

    // Update twitter:url meta tag
    let twitterUrlMeta = document.querySelector('meta[property="twitter:url"]');
    if (twitterUrlMeta) {
      twitterUrlMeta.setAttribute('content', url);
    }
  });
}

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();


