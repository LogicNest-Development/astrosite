/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./src/**/*.{astro,html,js,jsx,ts,tsx,md,mdx}",
    "./public/**/*.html"
  ],
  darkMode: ["class"],
  theme: {
    container: {
      center: true,
      padding: {
        DEFAULT: "1rem",
        sm: "1rem",
        lg: "2rem",
        xl: "2.5rem",
        "2xl": "3rem",
      },
      screens: { "2xl": "1200px" }
    },
    extend: {
      colors: {
        ln: {
          bg: "#0b1220",
          bgSoft: "#0f1a2e",
          primary: "#2F6FFF",   /* neon LogicNest blue */
          primaryDim: "#214FCC",
          ring: "#67A3FF",
          text: "#D7E3FF",
          muted: "#96A1B5",
          card: "#0f1626",
          border: "#1b2640",
          badge: "#13213a"
        }
      },
      boxShadow: {
        "brand": "0 0 32px rgba(47,111,255,0.35)",
        "card": "0 10px 30px rgba(0,0,0,0.35)"
      },
      borderRadius: {
        xl: "0.9rem",
        "2xl": "1.25rem"
      }
    }
  },
  plugins: [
    require("@tailwindcss/typography")
  ],
};
