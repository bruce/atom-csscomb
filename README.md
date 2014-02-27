# Atom Editor Plugin for CSSComb

Sort properties of one or more CSS rules using [CSSComb](http://csscomb.com/).

## CSSComb Configuration

The plugin uses the following strategy to determine the CSSComb configuration to use.

* First, it looks for a user configuration; a `csscomb` property in your Atom
  `config.cson`.
* Next, it looks for a project configuration; `.csscomb.json` or `.csscomb.cson`
  in your project root.
* If no configuration is found, it falls back to the predefined "csscomb"
  configuration that ships with [csscomb.js](https://github.com/csscomb/csscomb.js/blob/master/config/csscomb.json).

Your configuration can be a CSSComb configuration object or the [name of a predefined configuration](https://github.com/csscomb/csscomb.js/tree/master/config).
