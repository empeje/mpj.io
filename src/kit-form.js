// Kit Form Web Component
export default class KitForm extends HTMLElement {
  connectedCallback() {
    const script = document.createElement('script');
    script.src = 'https://yokulguy.kit.com/10def2dd7a/index.js';
    script.async = true;
    script.setAttribute('data-uid', '10def2dd7a');

    this.appendChild(script);
  }
}

if (!window.customElements.get('kit-form')) {
  window.KitForm = KitForm;
  window.customElements.define('kit-form', KitForm);
}

