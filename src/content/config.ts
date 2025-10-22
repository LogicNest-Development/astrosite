// src/content/config.ts
import { defineCollection, z } from "astro:content";

const productGroups = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    summary: z.string().optional(),
    enabled: z.boolean().default(true),
    // NEW: default link for products in this group (fallback)
    defaultPurchaseUrl: z.string().url().optional(),
  }),
});

const products = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    price: z.number().optional(),
    // whatever you use to associate to a group (slug/name)
    group: z.string(),
    enabled: z.boolean().default(true),
    // NEW: per-product purchase link and custom CTA label
    purchaseUrl: z.string().url().optional(),
    ctaLabel: z.string().default("Purchase now").optional(),
    // optional: productId if you build URLs from IDs later
    productId: z.string().optional(),
  }),
});

const settings = defineCollection({
  type: "data",
  schema: z.object({
    // NEW: status page URL to embed
    statusUrl: z.string().url().optional(),
    showStatusInNav: z.boolean().default(true).optional(),
  }),
});

export const collections = {
  "product-groups": productGroups,
  products,
  settings,
};
