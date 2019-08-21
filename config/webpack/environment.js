const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

// UglifyJsPlugin のインスタンスを見つけて置き換える
environment.plugins = environment.plugins
  .map(plug => {
    if (plug instanceof webpack.optimize.UglifyJsPlugin) {
      return new webpack.optimize.UglifyJsPlugin({
        sourceMap: false,
        parallel: true,
        mangle: false,
        uglifyOptions: {
          mangle: false
        },
        compress: {
          warnings: false
        },
        output: {
          comments: false
        }
      });
    }
    return plug;
  })

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
});

environment.devtool = 'eval';
module.exports = environment
