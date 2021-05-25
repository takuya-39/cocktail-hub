const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const { resolve } = require('path')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)

environment.config.merge({
  resolve: {
    alias: {
      '@': resolve('app/javascript')
    }
  }
})

environment.loaders.prepend('typescript', typescript)
module.exports = environment
