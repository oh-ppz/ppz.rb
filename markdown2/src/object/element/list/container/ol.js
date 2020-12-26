const Base = require('./base')

module.exports = class extends Base {
  constructor(){
    super({
      tagName: 'ol'
    })
  }
}