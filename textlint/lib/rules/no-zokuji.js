'use strict'
const dic = require('../dic')

function reporter (context, options = {}) {
  return {
    [context.Syntax.Str] (node) {
      const text = context.getSource()
      for (let zokuji of Object.keys(dic.zokuji)) {
        const seiji = dic.zokuji[zokuji]
        const nextIndex = (fromIndex) => text.indexOf(zokuji, fromIndex)
        for (
          let fromIndex = 0, index = nextIndex(fromIndex);
          index !== -1;
          fromIndex = index + 1, index = nextIndex(fromIndex)
        ) {
          const err = new context.RuleError(
            `俗字「${zokuji}」has found. 正字 is 「${seiji}」`,
            {
              index: index,
              fix: context.fixer.replaceTextRange([index, index + 1], seiji)
            }
          )
          context.report(node, err)
        }
      }
    }
  }
}

module.exports = {
  fixer: reporter,
  linter: reporter
}
