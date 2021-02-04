const ejs = require('ejs')
const fs = require('fs')
const path = require('path')
const promisify = require('../lib/promisify')

Promise.all([
  promisify(fs.readFile)(path.join(__dirname, '..', 'src', 'dic.js.ejs'), 'utf8'),
  promisify(fs.readFile)(path.join(__dirname, '..', '..', 'dic', '新字舊字對照表.txt'), 'utf8')
])
  .then(results => new Promise((resolve, reject) => {
    var dicjs = results[0]
    var dic = results[1]
    dic = dic
      .replace(/^---[\s\S]+\n---\n/, '')
      .replace(/\s*#.*$/gm, '')
      .replace(/^\s*\n/gm, '')
    var zokuji = dic.split('\n')
      .map(line => line.split(' '))
      .filter(chars => chars.length === 2)
    resolve(ejs.render(dicjs, {zokuji: zokuji}))
  }))
  .then(dicjs => promisify(fs.writeFile)(path.join(__dirname, '..', 'lib', 'dic.js'), dicjs, 'utf8'))
