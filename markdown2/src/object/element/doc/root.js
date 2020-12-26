const Base = require('./base')

module.exports = class extends Base {
  append(h1){
    h1.attr.id = this.children.length + 1
    h1.hIndex = 1
    h1.tagName = 'h1'
    return super.append(el)
  }
}
