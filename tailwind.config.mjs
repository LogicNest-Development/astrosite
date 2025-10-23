/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    extend: {
      colors: { ink: "#0b1020", panel: "#0f162b" },
      boxShadow: {
        ring: "0 0 0 1px rgba(255,255,255,.06), 0 10px 25px -5px rgba(0,0,0,.45)"
      }
    }
  },
  plugins: [require('@tailwindcss/typography')]
}
