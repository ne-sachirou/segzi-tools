'use strict'
const dic = require('../dic')

function reporter (context, options = {}) {
  return {
    [context.Syntax.Str] (node) {
      const text = context.getSource()
      for (let sinji of Object.keys(dic.zokuji)) {
        const kyuji = dic.zokuji[sinji]
        const nextIndex = (fromIndex) => text.indexOf(kyuji, fromIndex)
        for (
          let fromIndex = 0, index = nextIndex(fromIndex);
          index !== -1;
          fromIndex = index + 1, index = nextIndex(fromIndex)
        ) {
          const err = new context.RuleError(
            `旧字「${kyuji}」has found. 新字 is 「${sinji}」`,
            {
              index: index,
              fix: context.fixer.replaceTextRange([index, index + 1], sinji)
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
