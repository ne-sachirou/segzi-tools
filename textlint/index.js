'use strict'
const noZokuji = require('./lib/rules/no-zokuji')
const noKyuji = require('./lib/rules/no-kyuji')

module.exports = {
  rules: {
    'no-zokuji': noZokuji,
    'no-kyuji': noKyuji
  },
  rulesConfig: {
  }
}
