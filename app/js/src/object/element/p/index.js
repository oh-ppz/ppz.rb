const Base = require('../base/ancestor')

module.exports = class extends Base {
  constructor(content){
    super({
      tagName: 'p',
      content
    })
  }
}