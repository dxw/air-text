module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/components/**/*.html.erb'
  ],
  theme: {
    extend: {
      colors: {
        'moderate-alert-guidance-panel': '#FBDA3033',
        'high-alert-guidance-panel': '#EBDBDE',
        'very-high-alert-guidance-panel': '#EBDBDE',
      },
    }
  },
  safelist: [
    'bg-moderate-alert-guidance-panel',
    'bg-high-alert-guidance-panel',
    'bg-very-high-alert-guidance-panel',
    "bg-lime-400",
    "bg-green-400",
    "bg-lime-600",
    "bg-yellow-300",
    "bg-amber-200",
    "bg-yellow-500",
    "bg-orange-500",
    "bg-red-500",
    "bg-red-800",
    "bg-stone-700",
    "text-lime-400",
    "text-green-400",
    "text-lime-600",
    "text-yellow-300",
    "text-amber-200",
    "text-yellow-500",
    "text-orange-500",
    "text-red-500",
    "text-red-800",
    "text-stone-700"
  ],
}
