module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        mytheme:{
          "primary":"#FF3B61",
          "primary-content": "#f3f4f6",
          "secondary":"#FF823B",
          "accent":"#33CDFF",
          "neutral":"#FF3B61",
          "base-100":"#ffffff",
          "info":"#00d0ff",
          "success":"#7ee861",
          "warning":"#ffa000",
          "error":"#ef4444",
        },
      },
      "cupcake",
    ],
  },
}
