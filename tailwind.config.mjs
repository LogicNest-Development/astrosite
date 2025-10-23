/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{astro,html,js,jsx,ts,tsx,md,mdx}"],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: "#7C3AED",
          50: "#F5F3FF",
          100: "#EDE9FE",
          200: "#DDD6FE",
          300: "#C4B5FD",
          400: "#A78BFA",
          500: "#8B5CF6",
          600: "#7C3AED",
          700: "#6D28D9"
        }
      },
      boxShadow: {
        ring: "0 0 0 1px rgba(255,255,255,0.08), 0 10px 30px rgba(0,0,0,0.35)"
      }
    }
  },
  plugins: [require('@tailwindcss/typography')]
};
