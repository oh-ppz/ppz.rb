const Base = require('../base/base')

module.exports = class extends Base {
  toString(){
    return new Base()
      .append(this)
      .append(new Base({
        content: this.children.toString()
      }))
      .toString()
  }
}