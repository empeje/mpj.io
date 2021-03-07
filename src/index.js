import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
import 'jquery'
import 'popper.js'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap'

Elm.Main.init({
  node: document.getElementById('root')
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
