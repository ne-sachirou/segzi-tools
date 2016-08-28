const TextLintTester = require('textlint-tester')
const rule = require('..')

const tester = new TextLintTester()

tester.run('seiji', rule, {
  valid: [
    '人體'
  ],
  invalid: [
    {
      text: '人体',
      errors: [
        {
          message: '俗字「体」has found. 正字 is 「體」',
          line: 1,
          column: 2
        }
      ]
    }
  ]
})
