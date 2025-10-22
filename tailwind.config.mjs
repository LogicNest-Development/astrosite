/**** Tailwind config ****/
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        bg: '#0b1220',
      },
      boxShadow: {
        ring: '0 0 0 1px rgba(255,255,255,.08), 0 10px 30px rgba(0,0,0,.35)'
      }
    },
  },
  plugins: [require('@tailwindcss/typography')],
}
