import { defineCollection, z } from "astro:content";

const productGroups = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    summary: z.string().optional(),
    hero: z.string().optional(),
    enabled: z.boolean().default(true),
    showInNav: z.boolean().default(false),
    order: z.number().default(100),
  }),
});

const products = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    price: z.number(),
    features: z.array(z.string()).default([]),
    badge: z.string().optional(),
    image: z.string().optional(),
    ctaUrl: z.string().optional(),
    enabled: z.boolean().default(true),
    group: z.string(),
  }),
});

export const collections = { "product-groups": productGroups, products };
