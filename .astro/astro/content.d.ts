declare module 'astro:content' {
	interface RenderResult {
		Content: import('astro/runtime/server/index.js').AstroComponentFactory;
		headings: import('astro').MarkdownHeading[];
		remarkPluginFrontmatter: Record<string, any>;
	}
	interface Render {
		'.md': Promise<RenderResult>;
	}

	export interface RenderedContent {
		html: string;
		metadata?: {
			imagePaths: Array<string>;
			[key: string]: unknown;
		};
	}
}

declare module 'astro:content' {
	type Flatten<T> = T extends { [K: string]: infer U } ? U : never;

	export type CollectionKey = keyof AnyEntryMap;
	export type CollectionEntry<C extends CollectionKey> = Flatten<AnyEntryMap[C]>;

	export type ContentCollectionKey = keyof ContentEntryMap;
	export type DataCollectionKey = keyof DataEntryMap;

	type AllValuesOf<T> = T extends any ? T[keyof T] : never;
	type ValidContentEntrySlug<C extends keyof ContentEntryMap> = AllValuesOf<
		ContentEntryMap[C]
	>['slug'];

	/** @deprecated Use `getEntry` instead. */
	export function getEntryBySlug<
		C extends keyof ContentEntryMap,
		E extends ValidContentEntrySlug<C> | (string & {}),
	>(
		collection: C,
		// Note that this has to accept a regular string too, for SSR
		entrySlug: E,
	): E extends ValidContentEntrySlug<C>
		? Promise<CollectionEntry<C>>
		: Promise<CollectionEntry<C> | undefined>;

	/** @deprecated Use `getEntry` instead. */
	export function getDataEntryById<C extends keyof DataEntryMap, E extends keyof DataEntryMap[C]>(
		collection: C,
		entryId: E,
	): Promise<CollectionEntry<C>>;

	export function getCollection<C extends keyof AnyEntryMap, E extends CollectionEntry<C>>(
		collection: C,
		filter?: (entry: CollectionEntry<C>) => entry is E,
	): Promise<E[]>;
	export function getCollection<C extends keyof AnyEntryMap>(
		collection: C,
		filter?: (entry: CollectionEntry<C>) => unknown,
	): Promise<CollectionEntry<C>[]>;

	export function getEntry<
		C extends keyof ContentEntryMap,
		E extends ValidContentEntrySlug<C> | (string & {}),
	>(entry: {
		collection: C;
		slug: E;
	}): E extends ValidContentEntrySlug<C>
		? Promise<CollectionEntry<C>>
		: Promise<CollectionEntry<C> | undefined>;
	export function getEntry<
		C extends keyof DataEntryMap,
		E extends keyof DataEntryMap[C] | (string & {}),
	>(entry: {
		collection: C;
		id: E;
	}): E extends keyof DataEntryMap[C]
		? Promise<DataEntryMap[C][E]>
		: Promise<CollectionEntry<C> | undefined>;
	export function getEntry<
		C extends keyof ContentEntryMap,
		E extends ValidContentEntrySlug<C> | (string & {}),
	>(
		collection: C,
		slug: E,
	): E extends ValidContentEntrySlug<C>
		? Promise<CollectionEntry<C>>
		: Promise<CollectionEntry<C> | undefined>;
	export function getEntry<
		C extends keyof DataEntryMap,
		E extends keyof DataEntryMap[C] | (string & {}),
	>(
		collection: C,
		id: E,
	): E extends keyof DataEntryMap[C]
		? Promise<DataEntryMap[C][E]>
		: Promise<CollectionEntry<C> | undefined>;

	/** Resolve an array of entry references from the same collection */
	export function getEntries<C extends keyof ContentEntryMap>(
		entries: {
			collection: C;
			slug: ValidContentEntrySlug<C>;
		}[],
	): Promise<CollectionEntry<C>[]>;
	export function getEntries<C extends keyof DataEntryMap>(
		entries: {
			collection: C;
			id: keyof DataEntryMap[C];
		}[],
	): Promise<CollectionEntry<C>[]>;

	export function render<C extends keyof AnyEntryMap>(
		entry: AnyEntryMap[C][string],
	): Promise<RenderResult>;

	export function reference<C extends keyof AnyEntryMap>(
		collection: C,
	): import('astro/zod').ZodEffects<
		import('astro/zod').ZodString,
		C extends keyof ContentEntryMap
			? {
					collection: C;
					slug: ValidContentEntrySlug<C>;
				}
			: {
					collection: C;
					id: keyof DataEntryMap[C];
				}
	>;
	// Allow generic `string` to avoid excessive type errors in the config
	// if `dev` is not running to update as you edit.
	// Invalid collection names will be caught at build time.
	export function reference<C extends string>(
		collection: C,
	): import('astro/zod').ZodEffects<import('astro/zod').ZodString, never>;

	type ReturnTypeOrOriginal<T> = T extends (...args: any[]) => infer R ? R : T;
	type InferEntrySchema<C extends keyof AnyEntryMap> = import('astro/zod').infer<
		ReturnTypeOrOriginal<Required<ContentConfig['collections'][C]>['schema']>
	>;

	type ContentEntryMap = {
		"faqs": {
"bots.md": {
	id: "bots.md";
  slug: "bots";
  body: string;
  collection: "faqs";
  data: InferEntrySchema<"faqs">
} & { render(): Render[".md"] };
"bundles.md": {
	id: "bundles.md";
  slug: "bundles";
  body: string;
  collection: "faqs";
  data: InferEntrySchema<"faqs">
} & { render(): Render[".md"] };
"fivem.md": {
	id: "fivem.md";
  slug: "fivem";
  body: string;
  collection: "faqs";
  data: InferEntrySchema<"faqs">
} & { render(): Render[".md"] };
"global.md": {
	id: "global.md";
  slug: "global";
  body: string;
  collection: "faqs";
  data: InferEntrySchema<"faqs">
} & { render(): Render[".md"] };
"minecraft.md": {
	id: "minecraft.md";
  slug: "minecraft";
  body: string;
  collection: "faqs";
  data: InferEntrySchema<"faqs">
} & { render(): Render[".md"] };
"teamspeak.md": {
	id: "teamspeak.md";
  slug: "teamspeak";
  body: string;
  collection: "faqs";
  data: InferEntrySchema<"faqs">
} & { render(): Render[".md"] };
};
"legal": {
"refund.md": {
	id: "refund.md";
  slug: "refund";
  body: string;
  collection: "legal";
  data: InferEntrySchema<"legal">
} & { render(): Render[".md"] };
"sla.md": {
	id: "sla.md";
  slug: "sla";
  body: string;
  collection: "legal";
  data: InferEntrySchema<"legal">
} & { render(): Render[".md"] };
"tos.md": {
	id: "tos.md";
  slug: "tos";
  body: string;
  collection: "legal";
  data: InferEntrySchema<"legal">
} & { render(): Render[".md"] };
};
"product-groups": {
"bundles.md": {
	id: "bundles.md";
  slug: "bundles";
  body: string;
  collection: "product-groups";
  data: InferEntrySchema<"product-groups">
} & { render(): Render[".md"] };
"discord-bots.md": {
	id: "discord-bots.md";
  slug: "discord-bots";
  body: string;
  collection: "product-groups";
  data: InferEntrySchema<"product-groups">
} & { render(): Render[".md"] };
"fivem.md": {
	id: "fivem.md";
  slug: "fivem";
  body: string;
  collection: "product-groups";
  data: InferEntrySchema<"product-groups">
} & { render(): Render[".md"] };
"minecraft.md": {
	id: "minecraft.md";
  slug: "minecraft";
  body: string;
  collection: "product-groups";
  data: InferEntrySchema<"product-groups">
} & { render(): Render[".md"] };
"teamspeak.md": {
	id: "teamspeak.md";
  slug: "teamspeak";
  body: string;
  collection: "product-groups";
  data: InferEntrySchema<"product-groups">
} & { render(): Render[".md"] };
};
"products": {
"bundles-bronze-bundle.md": {
	id: "bundles-bronze-bundle.md";
  slug: "bundles-bronze-bundle";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"bundles-gold-bundle.md": {
	id: "bundles-gold-bundle.md";
  slug: "bundles-gold-bundle";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"bundles-silver-bundle.md": {
	id: "bundles-silver-bundle.md";
  slug: "bundles-silver-bundle";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"discord-bots-pro.md": {
	id: "discord-bots-pro.md";
  slug: "discord-bots-pro";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"discord-bots-start.md": {
	id: "discord-bots-start.md";
  slug: "discord-bots-start";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"discord-bots-ultimate.md": {
	id: "discord-bots-ultimate.md";
  slug: "discord-bots-ultimate";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"fivem-core-4g.md": {
	id: "fivem-core-4g.md";
  slug: "fivem-core-4g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"fivem-plus-6g.md": {
	id: "fivem-plus-6g.md";
  slug: "fivem-plus-6g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"fivem-pro-8g.md": {
	id: "fivem-pro-8g.md";
  slug: "fivem-pro-8g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"fivem-scale-12g.md": {
	id: "fivem-scale-12g.md";
  slug: "fivem-scale-12g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"fivem-starter-2g.md": {
	id: "fivem-starter-2g.md";
  slug: "fivem-starter-2g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"fivem-ultra-16g.md": {
	id: "fivem-ultra-16g.md";
  slug: "fivem-ultra-16g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"minecraft-diamond-8g.md": {
	id: "minecraft-diamond-8g.md";
  slug: "minecraft-diamond-8g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"minecraft-gold-6g.md": {
	id: "minecraft-gold-6g.md";
  slug: "minecraft-gold-6g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"minecraft-iron-4g.md": {
	id: "minecraft-iron-4g.md";
  slug: "minecraft-iron-4g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"minecraft-netherite-12g.md": {
	id: "minecraft-netherite-12g.md";
  slug: "minecraft-netherite-12g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"minecraft-stone-2g.md": {
	id: "minecraft-stone-2g.md";
  slug: "minecraft-stone-2g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"minecraft-titan-16g.md": {
	id: "minecraft-titan-16g.md";
  slug: "minecraft-titan-16g";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"teamspeak-pro-64-slots.md": {
	id: "teamspeak-pro-64-slots.md";
  slug: "teamspeak-pro-64-slots";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"teamspeak-start-32-slots.md": {
	id: "teamspeak-start-32-slots.md";
  slug: "teamspeak-start-32-slots";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
"teamspeak-ultimate-128-slots.md": {
	id: "teamspeak-ultimate-128-slots.md";
  slug: "teamspeak-ultimate-128-slots";
  body: string;
  collection: "products";
  data: InferEntrySchema<"products">
} & { render(): Render[".md"] };
};

	};

	type DataEntryMap = {
		"settings": {
"site": {
	id: "site";
  collection: "settings";
  data: InferEntrySchema<"settings">
};
};

	};

	type AnyEntryMap = ContentEntryMap & DataEntryMap;

	export type ContentConfig = typeof import("../../src/content/config.js");
}
