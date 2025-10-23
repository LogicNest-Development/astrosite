import { defineCollection, z } from 'astro:content';

const group = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    summary: z.string().optional(),
    hero: z.string().optional(),
    enabled: z.boolean().default(true),
    showInNav: z.boolean().default(false),
    order: z.number().default(100),
    faqTag: z.string().optional()
  })
});

const product = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    price: z.number(),
    features: z.array(z.string()).optional(),
    badge: z.string().optional(),
    image: z.string().optional(),
    ctaUrl: z.string().optional(),
    enabled: z.boolean().default(true),
    group: z.string()
  })
});

const faqs = defineCollection({
  type: 'content',
  schema: z.object({
    tag: z.string(),
    items: z.array(z.object({ q: z.string(), a: z.string() }))
  })
});

const legal = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    updated: z.string().optional()
  })
});

export const collections = { "product-groups": group, products: product, faqs, legal };
