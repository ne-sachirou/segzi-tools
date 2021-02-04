'use strict'
const TextLintTester = require('textlint-tester')
const rule = require('../..').rules['no-zokuji']

const tester = new TextLintTester()

tester.run('no-zokuji', rule, {
  valid: [
    '人體'
  ],
  invalid: [
    {
      text: '人體\n人体',
      errors: [
        {
          message: '俗字「体」has found. 正字 is 「體」',
          line: 2,
          column: 2
        }
      ]
    }
  ]
})
