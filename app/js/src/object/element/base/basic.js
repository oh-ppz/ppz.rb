const Base = require('./abstract')

module.exports = class extends Base {
  constructor(tagName, content){
    super({
      tagName,
      content
    })
  }
}