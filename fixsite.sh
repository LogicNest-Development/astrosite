#!/usr/bin/env bash
set -euo pipefail

echo "==> Creating folders"
mkdir -p public/admin public/uploads src/{components,content/{legal,product-groups,products,faqs,settings},data,layouts,pages,styles} .github/workflows

########################################
# Root & tooling
########################################

cat > package.json <<'JSON'
{
  "name": "logicnest-astro-site",
  "version": "1.0.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "astro dev",
    "build": "astro build",
    "preview": "astro preview",
    "format": "prettier --write ."
  },
  "dependencies": {
    "astro": "^4.14.5",
    "@astrojs/tailwind": "^5.1.0",
    "tailwindcss": "^3.4.13",
    "@tailwindcss/typography": "^0.5.15",
    "typescript": "^5.6.3"
  },
  "devDependencies": {
    "prettier": "^3.3.3",
    "prettier-plugin-astro": "^0.14.1",
    "postcss": "^8.4.47",
    "autoprefixer": "^10.4.20"
  }
}
JSON

cat > tsconfig.json <<'JSON'
{
  "extends": "astro/tsconfigs/strict",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@components/*": ["src/components/*"],
      "@content/*": ["src/content/*"],
      "@data/*": ["src/data/*"]
    }
  },
  "include": ["src", "astro.config.mjs", "env.d.ts"],
  "exclude": ["dist", "node_modules"]
}
JSON

cat > astro.config.mjs <<'JS'
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  integrations: [tailwind({ applyBaseStyles: true })],
  output: 'static'
});
JS

cat > postcss.config.cjs <<'JS'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};
JS

cat > tailwind.config.mjs <<'JS'
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
JS

cat > .gitignore <<'TXT'
# OS junk
.DS_Store
__MACOSX/
# build
dist/
# node
node_modules/
npm-debug.log*
# envs
.env
TXT

########################################
# Styles & typings
########################################

cat > src/styles/tailwind.css <<'CSS'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  color-scheme: dark;
}

.container {
  @apply max-w-7xl mx-auto px-4;
}

.btn-primary {
  @apply inline-flex items-center justify-center rounded-xl px-4 py-2 font-medium border border-white/10 bg-brand-600 hover:bg-brand-700 transition;
}
.card {
  @apply rounded-2xl border border-white/10 bg-black/20 shadow-ring;
}
.text-muted {
  @apply text-white/80;
}
CSS

cat > src/env.d.ts <<'TS'
/// <reference path="../.astro/types.d.ts" />
/// <reference types="astro/client" />
TS

########################################
# Content collections config
########################################

cat > src/content/config.ts <<'TS'
import { defineCollection, z } from "astro:content";

const productGroups = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    summary: z.string().optional(),
    hero: z.string().optional(),
    enabled: z.boolean().default(true),
    showInNav: z.boolean().default(false),
    order: z.number().default(100)
  })
});

const products = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    price: z.number(),
    features: z.array(z.string()).optional(),
    badge: z.string().optional(),
    image: z.string().optional(),
    ctaUrl: z.string().url().optional(), // external or internal
    enabled: z.boolean().default(true),
    group: z.string()
  })
});

const faqs = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    order: z.number().optional()
  })
});

const legal = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    // Allow either string or date for updated
    updated: z.union([z.string(), z.date()]).optional()
  })
});

const settings = defineCollection({
  type: "data",
  schema: z.object({
    siteName: z.string(),
    tagline: z.string().optional(),
    discordUrl: z.string().url().optional(),
    clientAreaUrl: z.string().url().optional(),
    showBanner: z.boolean().default(false),
    bannerText: z.string().optional()
  })
});

export const collections = { products, "product-groups": productGroups, faqs, legal, settings };
TS

########################################
# Settings data
########################################

cat > src/content/settings/site.json <<'JSON'
{
  "siteName": "LogicNest",
  "tagline": "Game hosting that just works.",
  "discordUrl": "https://discord.gg/your-server",
  "clientAreaUrl": "https://billing.logicnest.biz",
  "showBanner": false,
  "bannerText": "Scheduled maintenance Sat 2AM UTC."
}
JSON

########################################
# Minimal product groups (samples)
########################################

cat > src/content/product-groups/fivem.md <<'MD'
---
title: "FiveM Hosting"
summary: "NVMe-only performance with DDoS filtering and txAdmin prewire."
enabled: true
showInNav: true
order: 1
---

MD

cat > src/content/product-groups/minecraft.md <<'MD'
---
title: "Minecraft Hosting"
summary: "One-click Paper, Purpur, Fabric, Forge & more. Crash auto-restart."
enabled: true
showInNav: true
order: 2
---

MD

cat > src/content/product-groups/discord-bots.md <<'MD'
---
title: "Discord Bot Hosting"
summary: "PM2 or Docker, logs, env vault, health checks."
enabled: true
showInNav: true
order: 3
---

MD

cat > src/content/product-groups/teamspeak.md <<'MD'
---
title: "TeamSpeak Hosting"
summary: "Low-latency voice for squads and communities."
enabled: true
showInNav: false
order: 4
---

MD

cat > src/content/product-groups/bundles.md <<'MD'
---
title: "Game Server Bundles"
summary: "FiveM + Web + Bot/TS with backups and DB."
enabled: true
showInNav: true
order: 5
---

MD

########################################
# A few sample products (you can keep yours; these are safe defaults)
########################################

cat > src/content/products/fivem-pro-8g.md <<'MD'
---
title: "Pro 8G"
price: 21.50
features:
  - 8 GB RAM
  - 4 vCPU
  - 100 GB NVMe
  - 3 backups, 1 IPv4
  - DDoS filtering, SFTP, scheduler
badge: "Popular"
image: "/uploads/fivem-pro.png"
ctaUrl: "https://billing.logicnest.biz/cart.php?a=add&pid=FIVEM-PRO-8G"
enabled: true
group: "fivem"
---

MD

cat > src/content/products/minecraft-diamond-8g.md <<'MD'
---
title: "Diamond 8G"
price: 16.50
features:
  - 8 GB RAM
  - 4 vCPU
  - 80 GB NVMe
  - 3 backups
  - One-click Paper/Purpur/Fabric/Forge
image: "/uploads/mc-diamond.png"
ctaUrl: "https://billing.logicnest.biz/cart.php?a=add&pid=MC-DIAMOND-8G"
enabled: true
group: "minecraft"
---

MD

cat > src/content/products/discord-bots-pro.md <<'MD'
---
title: "Bot Pro"
price: 4.50
features:
  - 1 GB RAM
  - 2 vCPU
  - 10 GB NVMe
  - Enhanced rate-limit protect
  - PM2 or Docker runtime
image: "/uploads/bot-pro.png"
ctaUrl: "https://billing.logicnest.biz/cart.php?a=add&pid=BOT-PRO"
enabled: true
group: "discord-bots"
---

MD

########################################
# Legal docs
########################################

cat > src/content/legal/tos.md <<'MD'
---
title: "Terms of Service"
updated: "2025-01-01"
---

**Welcome to LogicNest.** By using our services you agree to these terms...
MD

cat > src/content/legal/sla.md <<'MD'
---
title: "Service Level Agreement"
updated: "2025-01-01"
---

We target 99.9% monthly uptime. Credits apply when availability falls below this threshold...
MD

cat > src/content/legal/refund.md <<'MD'
---
title: "Refund Policy"
updated: "2025-01-01"
---

Refunds are evaluated within 7 days of purchase for unused resources...
MD

########################################
# Components
########################################

cat > src/components/AnnouncementBanner.astro <<'ASTRO'
---
import { getEntry } from "astro:content";
const site = await getEntry("settings", "site");
const data = site?.data;
if (!data?.showBanner) {
  // Render nothing
  return;
}
---
<div class="w-full bg-brand-600/20 border-b border-white/10">
  <div class="container py-2 text-center text-sm">
    {data.bannerText}
  </div>
</div>
ASTRO

cat > src/components/ProductCard.astro <<'ASTRO'
---
const { product } = Astro.props as {
  product: {
    title: string;
    price: number;
    features?: string[];
    badge?: string;
    image?: string;
    ctaUrl?: string;
  };
};
---
<article class="rounded-2xl border border-white/10 p-6 shadow-ring flex flex-col bg-black/20">
  {product.badge && (
    <span class="mb-3 inline-block rounded-full border border-white/15 px-3 py-1 text-xs opacity-90">
      {product.badge}
    </span>
  )}

  <h3 class="text-xl font-semibold">{product.title}</h3>
  <div class="mt-2 text-3xl font-bold">${product.price.toFixed(2)}</div>

  {product.image && (
    <img src={product.image} alt={product.title} class="mt-4 rounded-xl border border-white/10" />
  )}

  {product.features && product.features.length > 0 && (
    <ul class="mt-4 list-disc pl-5 text-muted space-y-1">
      {product.features.map((f) => <li>{f}</li>)}
    </ul>
  )}

  <div class="mt-auto pt-6">
    <a href={product.ctaUrl ?? "/contact"} class="btn-primary inline-flex" rel="noopener noreferrer">
      Purchase Now
    </a>
  </div>
</article>
ASTRO

cat > src/components/Header.astro <<'ASTRO'
---
import nav from "@data/nav.json";
const { clientAreaUrl } = nav;
const items = nav.items?.filter((i) => i.enabled !== false) ?? [];
---
<header class="sticky top-0 z-40 backdrop-blur bg-black/40 border-b border-white/10">
  <div class="container h-14 flex items-center justify-between">
    <a href="/" class="font-bold">LogicNest</a>

    <nav class="hidden md:flex items-center gap-2">
      {items.map((item) => (
        item.type === "section" ? (
          <details class="group relative">
            <summary class="cursor-pointer px-3 py-2 rounded-xl hover:bg-white/5">{item.label}</summary>
            <div class="absolute left-0 mt-2 w-[560px] p-4 card">
              <div class="grid grid-cols-2 gap-3">
                {(item.children ?? []).map((c) => (
                  <a href={c.path} class="px-3 py-2 rounded-lg hover:bg-white/5">{c.label}</a>
                ))}
              </div>
            </div>
          </details>
        ) : (
          <a
            href={item.path}
            class="px-3 py-2 rounded-xl hover:bg-white/5"
            target={item.external ? "_blank" : "_self"}
            rel={item.external ? "noopener noreferrer" : undefined}
          >
            {item.label}
          </a>
        )
      ))}
    </nav>

    <div class="flex items-center gap-2">
      {clientAreaUrl && (
        <a href={clientAreaUrl} class="px-3 py-2 rounded-xl border border-white/10 hover:bg-white/5">Client Area</a>
      )}
      <button class="md:hidden px-3 py-2 rounded-xl border border-white/10" onclick="document.getElementById('mnav').showModal()">Menu</button>
    </div>
  </div>

  <!-- mobile -->
  <dialog id="mnav" class="card w-[92vw] max-w-md p-4">
    <form method="dialog">
      <button class="absolute right-3 top-3 px-2 py-1 border rounded-lg border-white/10">✕</button>
    </form>
    <div class="mt-6 space-y-2">
      {items.map((item) => (
        item.type === "section" ? (
          <details>
            <summary class="px-3 py-2 rounded-lg hover:bg-white/5">{item.label}</summary>
            <div class="pl-3 py-2 space-y-1">
              {(item.children ?? []).map((c) => (
                <a href={c.path} class="block px-3 py-2 rounded hover:bg-white/5">{c.label}</a>
              ))}
            </div>
          </details>
        ) : (
          <a href={item.path} class="block px-3 py-2 rounded hover:bg-white/5">{item.label}</a>
        )
      ))}
    </div>
  </dialog>
</header>
ASTRO

########################################
# Layout
########################################

cat > src/layouts/Layout.astro <<'ASTRO'
---
import "../styles/tailwind.css";
import Header from "@components/Header.astro";
import AnnouncementBanner from "@components/AnnouncementBanner.astro";
const { title = "LogicNest" } = Astro.props;
---
<html lang="en" class="bg-[#0B0B0F] text-white">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>{title}</title>
    <link rel="icon" href="/favicon.ico" />
    <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
  </head>
  <body>
    <AnnouncementBanner />
    <Header />
    <main>
      <slot />
    </main>
  </body>
</html>
ASTRO

########################################
# Pages
########################################

# Home
cat > src/pages/index.astro <<'ASTRO'
---
import Layout from "../layouts/Layout.astro";
import { getCollection } from "astro:content";
import ProductCard from "@components/ProductCard.astro";

const groups = (await getCollection("product-groups"))
  .filter(g => g.data.enabled !== false)
  .sort((a,b) => (a.data.order ?? 0) - (b.data.order ?? 0));

const products = (await getCollection("products"))
  .filter(p => p.data.enabled !== false);
---
<Layout title="LogicNest — Game Hosting">
  <section class="container py-16">
    <h1 class="text-4xl font-bold">Game hosting that just works.</h1>
    <p class="text-muted mt-3 max-w-2xl">NVMe-only nodes, DDoS filtering, 1-click installs, and a clean client area.</p>
    <div class="mt-8 grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
      {products.slice(0,6).map(p => <ProductCard product={{
        title: p.data.title,
        price: p.data.price,
        features: p.data.features,
        badge: p.data.badge,
        image: p.data.image,
        ctaUrl: p.data.ctaUrl
      }} />)}
    </div>
  </section>

  <section class="container py-12">
    <h2 class="text-2xl font-semibold mb-4">Categories</h2>
    <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
      {groups.map(g => (
        <a href={`/products/${g.slug}`} class="card p-5 hover:bg-white/5 transition">
          <div class="text-lg font-semibold">{g.data.title}</div>
          <p class="text-muted mt-1">{g.data.summary}</p>
        </a>
      ))}
    </div>
  </section>
</Layout>
ASTRO

# Product group / listing
cat > src/pages/products/[slug].astro <<'ASTRO'
---
import Layout from "../../layouts/Layout.astro";
import { getCollection } from "astro:content";
import ProductCard from "@components/ProductCard.astro";

const { slug } = Astro.params;
const groups = await getCollection("product-groups");
const group = groups.find(g => g.slug === slug);

if (!group) {
  throw new Error("Group not found");
}

const products = (await getCollection("products"))
  .filter(p => p.data.group === group.slug && p.data.enabled !== false);
---
<Layout title={`${group.data.title} — LogicNest`}>
  <section class="container py-12">
    <h1 class="text-3xl font-bold">{group.data.title}</h1>
    {group.data.summary && <p class="text-muted mt-2">{group.data.summary}</p>}
    <div class="mt-8 grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
      {products.map(p => (
        <ProductCard product={{
          title: p.data.title,
          price: p.data.price,
          features: p.data.features,
          badge: p.data.badge,
          image: p.data.image,
          ctaUrl: p.data.ctaUrl
        }} />
      ))}
    </div>
  </section>
</Layout>
ASTRO

# Games page (now valid; no broken slots/imports)
cat > src/pages/games.astro <<'ASTRO'
---
import Layout from "../layouts/Layout.astro";
import { getCollection } from "astro:content";

const groups = (await getCollection("product-groups"))
  .filter(g => g.data.enabled !== false)
  .sort((a,b) => (a.data.order ?? 0) - (b.data.order ?? 0));
---
<Layout title="Games — LogicNest">
  <section class="container py-12">
    <h1 class="text-3xl font-bold">Games & Categories</h1>
    <div class="mt-6 grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
      {groups.map(g => (
        <a href={`/products/${g.slug}`} class="card p-5 hover:bg-white/5 transition">
          <div class="text-lg font-semibold">{g.data.title}</div>
          <p class="text-muted mt-1">{g.data.summary}</p>
        </a>
      ))}
    </div>
  </section>
</Layout>
ASTRO

# Legal page (fixed: renderMarkdown instead of compile())
cat > src/pages/legal.astro <<'ASTRO'
---
import Layout from "../layouts/Layout.astro";
import { getCollection, renderMarkdown } from "astro:content";

const docs = await getCollection("legal");
const activeTitle = Astro.url.searchParams.get("doc") ?? docs[0]?.data.title;
const activeDoc = docs.find(d => d.data.title === activeTitle) ?? docs[0];
const compiled = activeDoc ? await renderMarkdown(activeDoc.body) : null;
---
<Layout title="Legal — LogicNest">
  <section class="container py-12">
    <div class="flex flex-wrap gap-2">
      {docs.map(d => (
        <a
          href={`/legal?doc=${encodeURIComponent(d.data.title)}`}
          class={`px-3 py-2 rounded-xl border border-white/10 transition ${activeDoc?.data.title === d.data.title ? "bg-white/10" : "hover:bg-white/5"}`}
        >{d.data.title}</a>
      ))}
    </div>

    <div class="card p-6 mt-6 prose prose-invert max-w-none">
      <article set:html={compiled?.content}></article>
    </div>
  </section>
</Layout>
ASTRO

########################################
# Navigation data (header supports dropdowns)
########################################

cat > src/data/nav.json <<'JSON'
{
  "clientAreaUrl": "https://billing.logicnest.biz",
  "items": [
    { "key": "home", "label": "Home", "type": "page", "path": "/", "enabled": true },
    {
      "key": "products",
      "label": "Products",
      "type": "section",
      "enabled": true,
      "children": [
        { "label": "FiveM Hosting", "path": "/products/fivem" },
        { "label": "Minecraft Hosting", "path": "/products/minecraft" },
        { "label": "Discord Bots", "path": "/products/discord-bots" },
        { "label": "TeamSpeak", "path": "/products/teamspeak" },
        { "label": "Bundles", "path": "/products/bundles" }
      ]
    },
    { "key": "games", "label": "Games", "type": "page", "path": "/games", "enabled": true },
    { "key": "legal", "label": "Legal", "type": "page", "path": "/legal", "enabled": true }
  ]
}
JSON

########################################
# CMS (Netlify CMS-compatible) config
########################################

cat > public/admin/index.html <<'HTML'
<!doctype html>
<html>
  <head>
    <meta charset="utf-8"/>
    <title>LogicNest CMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
  </head>
  <body>
    <script src="https://unpkg.com/netlify-cms@^2.10.192/dist/netlify-cms.js"></script>
  </body>
</html>
HTML

cat > public/admin/config.yml <<'YAML'
backend:
  name: github
  repo: LogicNest-Development/astrosite
  branch: main
  base_url: "https://cms-auth.logicnest.biz"
  auth_endpoint: "auth"

media_folder: "public/uploads"
public_folder: "/uploads"

collections:
  - name: "nav"
    label: "Navigation"
    format: "json"
    delete: false
    editor: { preview: false }
    files:
      - name: "nav"
        label: "Main Navigation"
        file: "src/data/nav.json"
        fields:
          - { name: "clientAreaUrl", label: "Client Area URL", widget: "string", required: false }
          - name: "items"
            label: "Items"
            label_singular: "Item"
            widget: "list"
            summary: "{{fields.label}} → {{fields.path}}"
            fields:
              - { name: "key", label: "Key", widget: "string" }
              - { name: "label", label: "Label", widget: "string" }
              - { name: "enabled", label: "Enabled", widget: "boolean", default: true, required: false }
              - name: "type"
                label: "Type"
                widget: "select"
                options: ["page","section","external"]
                default: "page"
              - { name: "path", label: "Path / #anchor / URL", widget: "string", required: false }
              - { name: "external", label: "Open in new tab", widget: "boolean", required: false }
              - name: "children"
                label: "Dropdown Items"
                widget: "list"
                required: false
                fields:
                  - { name: "label", label: "Label", widget: "string" }
                  - { name: "path", label: "Path / URL", widget: "string" }

  - name: "product-groups"
    label: "Product Groups"
    folder: "src/content/product-groups"
    create: true
    slug: "{{slug}}"
    extension: "md"
    fields:
      - { name: "title", label: "Title", widget: "string" }
      - { name: "summary", label: "Summary", widget: "text", required: false }
      - { name: "hero", label: "Hero Text", widget: "text", required: false }
      - { name: "enabled", label: "Enabled", widget: "boolean", default: true }
      - { name: "showInNav", label: "Show in Header", widget: "boolean", default: false }
      - { name: "order", label: "Order", widget: "number", default: 100 }

  - name: "products"
    label: "Products"
    folder: "src/content/products"
    create: true
    slug: "{{slug}}"
    extension: "md"
    fields:
      - { name: "title", label: "Title", widget: "string" }
      - { name: "price", label: "Price (USD)", widget: "number" }
      - { name: "features", label: "Features", widget: "list", required: false }
      - { name: "badge", label: "Badge", widget: "string", required: false }
      - { name: "image", label: "Image URL", widget: "string", required: false }
      - { name: "ctaUrl", label: "CTA URL", widget: "string", required: false }
      - { name: "enabled", label: "Enabled", widget: "boolean", default: true }
      - { name: "group", label: "Group (slug)", widget: "relation", collection: "product-groups", search_fields: ["title"], value_field: "{{slug}}", display_fields: ["title"] }

  - name: "faqs"
    label: "FAQs"
    folder: "src/content/faqs"
    create: true
    slug: "{{slug}}"
    extension: "md"
    fields:
      - { name: "title", label: "Title", widget: "string" }
      - { name: "body", label: "Body", widget: "markdown", required: false }

  - name: "legal"
    label: "Legal"
    folder: "src/content/legal"
    create: true
    slug: "{{slug}}"
    extension: "md"
    fields:
      - { name: "title", label: "Title", widget: "string" }
      - { name: "updated", label: "Updated", widget: "datetime", required: false }
      - { name: "body", label: "Body", widget: "markdown" }

  - name: "settings"
    label: "Site Settings"
    format: "json"
    delete: false
    editor: { preview: false }
    files:
      - name: "site"
        label: "Site"
        file: "src/content/settings/site.json"
        fields:
          - { name: "siteName", label: "Site Name", widget: "string" }
          - { name: "tagline", label: "Tagline", widget: "string", required: false }
          - { name: "discordUrl", label: "Discord URL", widget: "string", required: false }
          - { name: "clientAreaUrl", label: "Client Area URL", widget: "string", required: false }
          - { name: "showBanner", label: "Show Announcement", widget: "boolean", default: false }
          - { name: "bannerText", label: "Announcement Text", widget: "string", required: false }
YAML

########################################
# Workflow (use npm install, fix build & rsync)
########################################

cat > .github/workflows/deploy.yml <<'YAML'
name: Build & Deploy (Astro)

on:
  push:
    branches: [main]

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Check out
        uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Install deps
        run: npm install --no-audit --no-fund

      - name: Build
        run: npm run build

      - name: Add server host key
        run: |
          mkdir -p ~/.ssh
          ssh-keyscan -H 72.60.172.192 >> ~/.ssh/known_hosts

      - name: Deploy via rsync
        uses: burnett01/rsync-deployments@7.0.2
        with:
          switches: -avzr --delete
          path: dist/
          remote_path: ~/htdocs/logicnest.biz/
          remote_host: 72.60.172.192
          remote_user: logicnest
          remote_key: ${{ secrets.DEPLOY_SSH_KEY }}
YAML

########################################
# Favicon placeholders (optional)
########################################
# These are placeholders; replace with your actual assets anytime.
echo -n "" > public/favicon.ico
echo -n "" > public/apple-touch-icon.png

echo "==> Done. Now run: npm install && npm run build"
