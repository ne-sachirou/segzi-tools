'use strict'
const TextLintTester = require('textlint-tester')
const rule = require('../..').rules['no-kyuji']

const tester = new TextLintTester()

tester.run('no-kyuji', rule, {
  valid: [
    '人体'
  ],
  invalid: [
    {
      text: '人體\n人体',
      errors: [
        {
          message: '旧字「體」has found. 新字 is 「体」',
          line: 1,
          column: 2
        }
      ]
    }
  ]
})
