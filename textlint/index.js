const dic = require('./lib/dic')

function fixer (context, options = {}) {
  return {
    [context.Syntax.Str] (node) {
      var text = context.getSource()
      for (let zokuji of Object.keys(dic.zokuji)) {
        const seiji = dic.zokuji[zokuji]
        if (text.includes(zokuji)) {
          const err = new context.RuleError(
            `俗字「${zokuji}」has found. 正字 is 「${seiji}」`,
            {
              index: text.indexOf(zokuji)
            }
          )
          context.report(node, err)
        }
      }
    }
  }
}

module.exports = {
  fixer: fixer,
  linter: fixer
}
