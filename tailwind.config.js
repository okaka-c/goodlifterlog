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
          "primary":"#fc345c",
          "primary-content": "#eafff7",
          "secondary":"#FF823B",
          "accent":"#49BEB7",
          "accent-content": "#eafff7",
          "neutral":"#fc345c",
          "neutral-content": "#eafff7",
          "base-100":"#ffffff",
          "info":"#00d0ff",
          "info-content": "#ffffff",
          "success": "#AFFFDF",
          "success-content": "#166534",
          "warning": "#fde047",
          "warning-content": "#160900",
          "error":"#fecdd3",
          "error-content":"#881337", 
        },
      },
      "cupcake",
    ],
  },
}
