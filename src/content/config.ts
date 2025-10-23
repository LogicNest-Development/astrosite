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
